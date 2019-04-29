package com.neusoft.common.task.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.neusoft.common.task.TaskService;
import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.account.service.AccountService;
import com.neusoft.modules.applyArrange.model.ApplyArrange;
import com.neusoft.modules.applyArrange.service.ApplyArrangeService;
import com.neusoft.modules.front.fightTicket.model.FightTicket;
import com.neusoft.modules.front.fightTicket.service.FightTicketService;
import com.neusoft.modules.front.filmDetail.service.FilmDetailService;
import com.neusoft.modules.integral.model.IntegralInfo;
import com.neusoft.modules.integral.service.IntegralInfoService;
import com.neusoft.modules.review.model.Review;
import com.neusoft.modules.review.service.ReviewService;
import com.neusoft.modules.theaterArrange.model.TheaterArrange;
import com.neusoft.modules.theaterArrange.service.TheaterArrangeService;

@Component
@Lazy(false)
public class TaskServiceImpl implements TaskService {
	
	@Autowired
	private TheaterArrangeService theaterArrangeService;
	
	@Autowired
	private FightTicketService fightTicketService;
	
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private IntegralInfoService integralInfoService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ApplyArrangeService applyArrangeService;
	
	@Autowired
	private FilmDetailService filmDetailService;

	@Scheduled(cron="0 0/3 * * * ?")   //每3分钟触发
	/*@Scheduled(cron = "0/5 * * * * *")  //每5秒触发*/
	@Override
	public void myTest() {
		// TODO Auto-generated method stub
		System.out.println("进入测试");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		/*String today = sdf.format(new Date());*/
		theaterArrangeService.updBeforeToday("放映安排已失效");
	}

	/*@Scheduled(cron="0/30 * * * * ?") */  //每30秒触发
	@Scheduled(cron="0 0/1 * * * ?")   //每3分钟触发
	@Override
	public void cancelTimeOut() {
		// TODO Auto-generated method stub
		System.out.println("清除超时订单");
		List<FightTicket> fightList = fightTicketService.selTimeOut();
		if(fightList != null){
			for(FightTicket f : fightList){
				List<FightTicket> fights = fightTicketService.selAvailableFight(f.getTheaterArrange().getId());
				if(fights != null){
					for(FightTicket fight : fights){
						if(fight.getPayStatus().equals("0")){
							Account returnAccount1 = accountService.selAccoutByUserName(fight.getFightPeople());
							int usedScore1 = fight.getUsedScore();
							if(usedScore1 != 0){
								//添加积分记录
								IntegralInfo integral = new IntegralInfo();
								integral.setId(UUID.randomUUID().toString().replace("-", ""));
								integral.setAccount(returnAccount1);
								integral.setIntegralSource("发起者订单超时未支付退还");
								integral.setScore(+usedScore1);
								integralInfoService.insert(integral);
								
								int leaveScore = returnAccount1.getIntegral()+usedScore1;
								accountService.updIntegral(leaveScore, returnAccount1.getId());
							}
							//修改订单退换积分后的状态为  pay_status='2' 已退款
							fightTicketService.updReturnPayStatus(fight.getId());
							//将审核表的相关申请删除
							Review review = reviewService.selReview(fight.getId());
							//修改审核状态：审核失败
							reviewService.updReviewStatus("3", review.getId(), "系统");
							reviewService.updRemarks("发起者订单超时未支付", review.getId());
							reviewService.updDelFlag("2", review.getId());
						}
						//修改订单审核状态为：review_status='3' 未通过审核
						fightTicketService.updReviewStatus("3", "系统", fight.getId());
						fightTicketService.updDelFlag("3",fight.getId());
						//订单最终状态  1:拼单失败
						fightTicketService.updFinalType("1", f.getId());
						fight.setFightStatus("0");
						fightTicketService.updFightStatus(fight);
						fightTicketService.updRemarks("发起拼单者超时未支付订单", "系统", fight.getId());
					}
				}
				//修改订单审核状态为：review_status='3' 未通过审核
				fightTicketService.updReviewStatus("3", "系统", f.getId());
				fightTicketService.updDelFlag("3",f.getId());
				//订单最终状态  1:拼单失败
				fightTicketService.updFinalType("1", f.getId());
				f.setFightStatus("0");
				fightTicketService.updFightStatus(f);
				fightTicketService.updRemarks("发起拼单者超时未支付订单", "系统", f.getId());
			}
		}
	}

	/*@Scheduled(cron="0/45 * * * * ?") */  //每45秒触发
	@Scheduled(cron="0 0/4 * * * ?")   //每4分钟触发
	@Override
	public void changeWatched() {
		// TODO Auto-generated method stub
		System.out.println("查询观看完的订单");
		List<FightTicket> fightList = fightTicketService.selWatchedFilm();
		if(fightList != null){
			for(FightTicket f : fightList){
				int count = f.getFilmDetail().getSales();
				String seats = f.getSeatIds();
				if(!seats.equals("")){
					if(seats.contains(",")){
						String[] ids = seats.split(",");
						for(String s : ids){
							count ++;
						}
					}else{
						count ++;
					}
				}
				filmDetailService.updateSales(count, f.getFilmDetail().getId());
				fightTicketService.updWatchStatus(f.getId());
				fightTicketService.updRemarks("已观看", "系统", f.getId());
			}
		}
	}

	@Scheduled(cron="0/10 * * * * ?")   //每10秒触发
	@Override
	public void cancelTwoHour() {
		// TODO Auto-generated method stub
		System.out.println("清除影片放映前两小时还没有到达指定比例的拼单");
		List<FightTicket> fightList = fightTicketService.selBeforeTwoHour();
		if(fightList != null){
			for(FightTicket f : fightList){
				//发起状态为：取消
				f.setFightStatus("0");
				fightTicketService.updFightStatus(f);
				fightTicketService.updRemarks("影片放映前两小时还没有到达指定比例的拼单", "系统", f.getId());
				//订单最终状态  1:拼单失败
				fightTicketService.updFinalType("1", f.getId());
				//返还用户使用积分
				Account returnAccount = accountService.selAccoutByUserName(f.getFightPeople());
				int usedScore = f.getUsedScore();
				if(usedScore != 0){
					//添加积分记录
					IntegralInfo integral = new IntegralInfo();
					integral.setId(UUID.randomUUID().toString().replace("-", ""));
					integral.setAccount(returnAccount);
					integral.setIntegralSource("影片放映前两小时还没有到达指定比例的拼单退还");
					integral.setScore(+usedScore);
					integralInfoService.insert(integral);
					
					int leaveScore = returnAccount.getIntegral()+usedScore;
					accountService.updIntegral(leaveScore, returnAccount.getId());
				}
				//修改订单退换积分后的状态为  pay_status='2' 已退款
				fightTicketService.updReturnPayStatus(f.getId());
				
				//修改订单审核状态为：review_status='3' 未通过审核
				fightTicketService.updReviewStatus("3", "系统", f.getId());
				
				//将审核表的相关申请删除
				Review review = reviewService.selReview(f.getId());
				//修改审核状态：审核失败
				reviewService.updReviewStatus("3", review.getId(), "系统");
				reviewService.updRemarks("影片放映前两小时还没有到达指定比例的拼单", review.getId());
				reviewService.updDelFlag("2", review.getId());
				
				//将该影片的放映安排也删除，避免其他人继续发起或参与该时间段的拼单 del_flag='2'
				TheaterArrange theaterArrange = theaterArrangeService.get(f.getTheaterArrange().getId());
				theaterArrangeService.updDelFlag("2", theaterArrange.getId());
				theaterArrangeService.updRemarks("影片放映前两小时还没有到达指定比例的拼单取消该时间段放映安排", theaterArrange.getId());
			}
		}
	}
	
	@Scheduled(cron="0 0/2 * * * ?")   //每2分钟触发
	@Override
	public void cancelOneHour() {
		System.out.println("清除影片放映前一小时还没有审核的订单信息");
		List<FightTicket> fightList = fightTicketService.selBeforeOneHour();
		if(fightList != null){
			for(FightTicket f : fightList){
				//拼单状态：取消
				f.setFightStatus("0");
				fightTicketService.updFightStatus(f);
				//审核状态：未通过审核
				fightTicketService.updReviewStatus("3", "系统", f.getId());
				//最终状态：拼单失败
				fightTicketService.updFinalType("1", f.getId());
				fightTicketService.updRemarks("影片放映前一小时未审核,自动置为未审核状态","系统",f.getId());
				
				//返还用户使用积分
				Account returnAccount = accountService.selAccoutByUserName(f.getFightPeople());
				int usedScore = f.getUsedScore();
				if(usedScore != 0){
					//添加积分记录
					IntegralInfo integral = new IntegralInfo();
					integral.setId(UUID.randomUUID().toString().replace("-", ""));
					integral.setAccount(returnAccount);
					integral.setIntegralSource("影片审核未通过退还");
					integral.setScore(+usedScore);
					integralInfoService.insert(integral);
					
					int leaveScore = returnAccount.getIntegral()+usedScore;
					accountService.updIntegral(leaveScore, returnAccount.getId());
				}
				//修改订单退换积分后的状态为  pay_status='2' 已退款
				fightTicketService.updReturnPayStatus(f.getId());
				
				//将审核表的相关申请删除
				Review review = reviewService.selReview(f.getId());
				//修改审核状态：审核失败
				reviewService.updReviewStatus("3", review.getId(), "系统");
				reviewService.updRemarks("影片放映前一小时未审核,自动置为未审核状态", review.getId());
				reviewService.updDelFlag("2", review.getId());
				
				//将该影片的放映安排也删除，避免其他人继续发起或参与该时间段的拼单
				TheaterArrange theaterArrange = theaterArrangeService.get(f.getTheaterArrange().getId());
				theaterArrangeService.updDelFlag("2", theaterArrange.getId());
				theaterArrangeService.updRemarks("影片放映前一小时未审核,自动置为未审核状态", theaterArrange.getId());
			}			
		}
		
	}

	@Scheduled(cron="0 0/2 * * * ?")   //每2分钟触发
	@Override
	public void cancelApplyBeforeToday() {
		System.out.println("将今天以前没有审核的影厅安排申请全部置为审核失败 ");
		List<ApplyArrange> applyList = applyArrangeService.selBeforeToday();
		if(applyList != null){
			for(ApplyArrange apply : applyList){
				ApplyArrange a = new ApplyArrange();
				a.setId(apply.getId());
				/*a.setDelFlag("1");
				applyArrangeService.updReviewStatus("2", apply.getId());
				applyArrangeService.updateDelFlag(a);*/
				applyArrangeService.updReviewStatus("2", apply.getId());
				applyArrangeService.updRemarks("将今天以前没有审核的影厅安排申请全部置为审核失败", apply.getId());
			}
		}
	}
}
