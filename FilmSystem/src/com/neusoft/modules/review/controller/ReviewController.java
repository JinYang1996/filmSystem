package com.neusoft.modules.review.controller;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neusoft.common.page.Page;
import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.account.service.AccountService;
import com.neusoft.modules.front.fightTicket.model.FightTicket;
import com.neusoft.modules.front.fightTicket.service.FightTicketService;
import com.neusoft.modules.integral.model.IntegralInfo;
import com.neusoft.modules.integral.service.IntegralInfoService;
import com.neusoft.modules.review.model.Review;
import com.neusoft.modules.review.service.ReviewService;
import com.neusoft.modules.seat.model.Seat;
import com.neusoft.modules.seat.service.SeatService;
import com.neusoft.modules.videoHall.model.VideoHall;
import com.neusoft.modules.videoHall.service.VideoHallService;

@Controller
@RequestMapping(value = "review")
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private FightTicketService fightTicketService;
	
	@Autowired
	private IntegralInfoService integralInfoService;
	
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private VideoHallService videoHallService;
	
	@Autowired
	private SeatService seatService;
	
	/**
	 * 查找申请拼单的审核
	 */
	@RequestMapping(value = "selReview")
	public String selReview(Model model,Review review,@RequestParam("pageNo")Integer pageNo,
			@RequestParam("type")String type,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		if(pageNo == null){
			pageNo = 0;
		}
		review.setType(type);
		//查找类型为申请拼单的审核列表  审核类型  1.申请拼单  2.申请参加拼单  3.申请取消拼单  4.申请取消参加拼单  
		Page page = null;
		if(account.getRole().getId().equals("2")){
			page = reviewService.selReviewByType(review,pageNo);
		}else if(account.getRole().getId().equals("3")){
			page = reviewService.selReviewByTypeSuper(review,pageNo);
		}
		if(null == page.getData()){
			page.setData(new ArrayList<Review>());
		}else{
			List<Review> reviewList = page.getData();
			List<Review> rList = new ArrayList<Review>();
			for(Review r : reviewList){
				//存放该安排下座位id的集合
				List<String> seats = new ArrayList<String>();
				FightTicket fightTicket = fightTicketService.get(r.getFightTicket().getId());
				
				List<FightTicket> fights = fightTicketService.selAvailableFight(fightTicket.getTheaterArrange().getId());
				VideoHall videoHall = videoHallService.selHallForName(fightTicket.getTheaterArrange().getVideoHall().getHallName());
				Seat seat2 = new Seat();
				seat2.setVideoHall(videoHall);
				List<Seat> seat1 = seatService.selSeatForHall(seat2);
				float sumCount = seat1.size();//总位置数
				if(fights.size() != 0){
					for(FightTicket f : fights){
						String seatIds1 = f.getSeatIds();
						if(seatIds1.contains(",")){
							String[] sid = seatIds1.split(",");
							for(String s : sid){
								String id = StringUtils.trim(s);
								seats.add(id);
							}
						}else{
							seats.add(seatIds1);
						}
					}
				}
				
				float selCount = seats.size();
				String sumPer = null;
				NumberFormat nf = NumberFormat.getPercentInstance();
				nf.setMinimumFractionDigits(2);
				
				if(selCount == 0){
					sumPer = "0.00%";
				}else{
					sumPer = nf.format(selCount/sumCount);
				}
				r.setSumPer(sumPer);
				rList.add(r);
			}
			page.setData(rList);
		}
		int count = reviewService.selStatusCount();
		

		
		
		model.addAttribute("page",page);
		model.addAttribute("review",review);
		model.addAttribute("count",count);
		return "modules/review/showReview";
	}
	
	/**
	 * 通过审核
	 */
	@RequestMapping(value = "passReview")
	public String passReview(@RequestParam("id")String id,@RequestParam("pageNo")Integer pageNo,
			@RequestParam("type")String type,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		if(null != id && !"".equals(id)){
			reviewService.updReviewStatus("0", id,account.getUserName());
			Review review = reviewService.get(id);
			
			FightTicket fightTicket = fightTicketService.get(review.getFightTicket().getId());
			
			if(type.equals("3")){//取消拼单
				FightTicket fightTicket1 = fightTicketService.get(fightTicket.getId());
				List<FightTicket> fights = fightTicketService.selAttendFight(fightTicket1.getTheaterArrange().getId());
				
				//1.先退发起者  此操作由发起者发起
				//返还用户使用积分
				Account returnAccount = accountService.selAccoutByUserName(fightTicket.getFightPeople());
				int usedScore = fightTicket.getUsedScore();
				if(usedScore != 0){
					//添加积分记录
					IntegralInfo integral = new IntegralInfo();
					integral.setId(UUID.randomUUID().toString().replace("-", ""));
					integral.setAccount(returnAccount);
					integral.setIntegralSource("取消拼单退还");
					integral.setScore(+usedScore);
					integralInfoService.insert(integral);
					
					int leaveScore = returnAccount.getIntegral()+usedScore;
					accountService.updIntegral(leaveScore, returnAccount.getId());
				}
				//修改订单退换积分后的状态为  pay_status='2' 已退款
				fightTicketService.updReturnPayStatus(review.getFightTicket().getId());
				
				//修改订单状态为  review_status='0' 已通过审核
				fightTicketService.updReviewStatus("0", account.getUserName(), review.getFightTicket().getId());
				
				//2.再退参与者
				for(FightTicket f : fights){
					//返还用户使用积分
					Account returnAccount1 = accountService.selAccoutByUserName(f.getFightPeople());
					int usedScore1 = f.getUsedScore();
					if(usedScore1 != 0){
						//添加积分记录
						IntegralInfo integral = new IntegralInfo();
						integral.setId(UUID.randomUUID().toString().replace("-", ""));
						integral.setAccount(returnAccount1);
						integral.setIntegralSource("发起者取消拼单退还");
						integral.setScore(+usedScore1);
						integralInfoService.insert(integral);
						
						int leaveScore = returnAccount1.getIntegral()+usedScore1;
						accountService.updIntegral(leaveScore, returnAccount1.getId());
					}
					//修改订单退换积分后的状态为  pay_status='2' 已退款
					fightTicketService.updReturnPayStatus(f.getId());
					
					//修改订单状态为  review_status='3' 未通过审核
					fightTicketService.updReviewStatus("3", account.getUserName(), f.getId());
					
					//修改订单发起状态为： 已取消
					f.setFightStatus("0");
					fightTicketService.updFightStatus(f);
				}
			}
			
			if(type.equals("4")){//取消参与拼单
				//返还用户使用积分
				Account returnAccount = accountService.selAccoutByUserName(fightTicket.getFightPeople());
				int usedScore = fightTicket.getUsedScore();
				if(usedScore != 0){
					//添加积分记录
					IntegralInfo integral = new IntegralInfo();
					integral.setId(UUID.randomUUID().toString().replace("-", ""));
					integral.setAccount(returnAccount);
					integral.setIntegralSource("取消参与拼单退还");
					integral.setScore(+usedScore);
					integralInfoService.insert(integral);
					
					int leaveScore = returnAccount.getIntegral()+usedScore;
					accountService.updIntegral(leaveScore, returnAccount.getId());
				}
				//修改订单退换积分后的状态为  pay_status='2' 已退款
				fightTicketService.updReturnPayStatus(review.getFightTicket().getId());
				
				//修改订单状态为  review_status='0' 已通过审核
				fightTicketService.updReviewStatus("0", account.getUserName(), review.getFightTicket().getId());
			}
			
			if(type.equals("1")){
				//存放该安排下座位id的集合
				List<String> seats = new ArrayList<String>();
				FightTicket fightTicket1 = fightTicketService.get(fightTicket.getId());
				
				List<FightTicket> fights = fightTicketService.selAvailableFight(fightTicket1.getTheaterArrange().getId());
				VideoHall videoHall = videoHallService.selHallForName(fightTicket1.getTheaterArrange().getVideoHall().getHallName());
				Seat seat2 = new Seat();
				seat2.setVideoHall(videoHall);
				List<Seat> seat1 = seatService.selSeatForHall(seat2);
				float sumCount = seat1.size();//总位置数
				for(FightTicket f : fights){
					String seatIds1 = f.getSeatIds();
					if(seatIds1.contains(",")){
						String[] sid = seatIds1.split(",");
						for(String s : sid){
							String id2 = StringUtils.trim(s);
							seats.add(id2);
						}
					}else{
						seats.add(seatIds1);
					}
					if(f.getType().equals("1") || f.getType().equals("2")){
						fightTicketService.updReviewStatus("0", account.getUserName(), f.getId());
					}else if(f.getType().equals("3") || f.getType().equals("4")){
						fightTicketService.updReviewStatus("3", account.getUserName(), f.getId());
					}
				}
				float selCount = seats.size();
				/*System.out.println("selCount:"+selCount + " sumCount" +sumCount);
				System.out.println(selCount/sumCount);*/
				
				//大于百分之60 无法进行取消订单  订单到达指定人数，等待拼单者影片审核  如果审核通过，发放观影码  如果审核失败，该影片该时间段拼单信息失效
				if(selCount/sumCount > 0.6){
					//根据座位发放观影码
					List<FightTicket> fightList = fightTicketService.selAvailableFight(fightTicket.getTheaterArrange().getId());
					for(FightTicket f : fightList){
						String seats2 = f.getSeatIds();
						if(seats2.contains(",")){
							String[] sid = seats2.split(",");
							String code = "";
							for(String s : sid){
								if(s != null){
									if(code.length()==0){
										code += UUID.randomUUID().toString().replace("-", "").substring(0,6);
									}else{
										code += ","+UUID.randomUUID().toString().replace("-", "").substring(0,6);
									}
								}
							}
							fightTicketService.updWatchCode(code, f.getId());
						}else{
							String code = UUID.randomUUID().toString().replace("-", "").substring(0,6);
							fightTicketService.updWatchCode(code, f.getId());
						}
					}
				}
				
				//修改订单状态为  review_status='0' 已通过审核
				fightTicketService.updReviewStatus("0", account.getUserName(), review.getFightTicket().getId());
			}
			
		}
		return "redirect:selReview?pageNo="+pageNo+"&type="+type;
	}
	
	/**
	 * 驳回审核
	 */
	@RequestMapping(value = "rebutReview")
	public String rebutReview(@RequestParam("id")String id,@RequestParam("pageNo")Integer pageNo,
			@RequestParam("type")String type,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		if(null != id && !"".equals(id)){
			
			Review review = reviewService.get(id);
			
			if(type.equals("1")){//申请拼单
				
				FightTicket fightTicket1 = fightTicketService.get(review.getFightTicket().getId());
				List<FightTicket> fights = fightTicketService.selAttendFight(fightTicket1.getTheaterArrange().getId());
				
				//1.先退发起者  此操作由发起者发起
				//返还用户使用积分
				Account returnAccount = accountService.selAccoutByUserName(fightTicket1.getFightPeople());
				int usedScore = fightTicket1.getUsedScore();
				if(usedScore != 0){
					//添加积分记录
					IntegralInfo integral = new IntegralInfo();
					integral.setId(UUID.randomUUID().toString().replace("-", ""));
					integral.setAccount(returnAccount);
					integral.setIntegralSource("影片审核失败退还");
					integral.setScore(+usedScore);
					integralInfoService.insert(integral);
					
					int leaveScore = returnAccount.getIntegral()+usedScore;
					accountService.updIntegral(leaveScore, returnAccount.getId());
				}
				//修改订单退换积分后的状态为  pay_status='2' 已退款
				fightTicketService.updReturnPayStatus(review.getFightTicket().getId());
				
				//修改订单发起状态为： 已取消
				fightTicket1.setFightStatus("0");
				fightTicketService.updFightStatus(fightTicket1);
				
				//2.再退参与者
				for(FightTicket f : fights){
					//返还用户使用积分
					Account returnAccount1 = accountService.selAccoutByUserName(f.getFightPeople());
					int usedScore1 = f.getUsedScore();
					if(usedScore1 != 0){
						//添加积分记录
						IntegralInfo integral = new IntegralInfo();
						integral.setId(UUID.randomUUID().toString().replace("-", ""));
						integral.setAccount(returnAccount1);
						integral.setIntegralSource("影片审核失败退还");
						integral.setScore(+usedScore1);
						integralInfoService.insert(integral);
						
						int leaveScore = returnAccount1.getIntegral()+usedScore1;
						accountService.updIntegral(leaveScore, returnAccount1.getId());
					}
					//修改订单退换积分后的状态为  pay_status='2' 已退款
					fightTicketService.updReturnPayStatus(f.getId());
					
					if(f.getType().equals("2")){
						//修改订单状态为  review_status='3' 未通过审核
						fightTicketService.updReviewStatus("3", account.getUserName(), f.getId());
					}else if(f.getType().equals("4")){
						//修改订单状态为  review_status='0' 通过审核
						fightTicketService.updReviewStatus("0", account.getUserName(), f.getId());
					}
					
					//修改订单发起状态为： 已取消
					f.setFightStatus("0");
					fightTicketService.updFightStatus(f);
				}
			}else if(type.equals("3")){
				FightTicket fightTicket = fightTicketService.get(review.getFightTicket().getId());
				List<FightTicket> fights = fightTicketService.selAvailableFight(fightTicket.getTheaterArrange().getId());
				//参与人数到达指定比例      发起状态为：达到指定人数
				fightTicket.setFightStatus("2");
				fightTicketService.updFightStatus(fightTicket);
				//最终状态： 拼单成功
				fightTicketService.updFinalType("2", fightTicket.getId());
				
				if(fightTicket.getWatchCode() == null){
					String seats2 = fightTicket.getSeatIds();
					if(seats2.contains(",")){
						String[] sid = seats2.split(",");
						String code = "";
						for(String s : sid){
							if(s != null){
								if(code.length()==0){
									code += UUID.randomUUID().toString().replace("-", "").substring(0,6);
								}else{
									code += ","+UUID.randomUUID().toString().replace("-", "").substring(0,6);
								}
							}
						}
						fightTicketService.updWatchCode(code, fightTicket.getId());
					}else{
						String code = UUID.randomUUID().toString().replace("-", "").substring(0,6);
						fightTicketService.updWatchCode(code, fightTicket.getId());
					}
				}
				for(FightTicket f : fights){
					//参与人数到达指定比例      发起状态为：达到指定人数
					f.setFightStatus("2");
					fightTicketService.updFightStatus(f);
					//最终状态： 拼单成功
					fightTicketService.updFinalType("2", f.getId());
					fightTicketService.updReviewStatus("0", account.getUserName(), f.getId());
					
					if(f.getWatchCode() == null){
						String seats2 = f.getSeatIds();
						if(seats2.contains(",")){
							String[] sid = seats2.split(",");
							String code = "";
							for(String s : sid){
								if(s != null){
									if(code.length()==0){
										code += UUID.randomUUID().toString().replace("-", "").substring(0,6);
									}else{
										code += ","+UUID.randomUUID().toString().replace("-", "").substring(0,6);
									}
								}
							}
							fightTicketService.updWatchCode(code, f.getId());
						}else{
							String code = UUID.randomUUID().toString().replace("-", "").substring(0,6);
							fightTicketService.updWatchCode(code, f.getId());
						}
					}
				}
				
			}else if(type.equals("4")){
				FightTicket fightTicket = fightTicketService.get(review.getFightTicket().getId());
				//参与人数到达指定比例      发起状态为：达到指定人数
				fightTicket.setFightStatus("2");
				fightTicketService.updFightStatus(fightTicket);
				//最终状态： 拼单成功
				fightTicketService.updFinalType("2", fightTicket.getId());
				
				if(fightTicket.getWatchCode() == null){
					String seats2 = fightTicket.getSeatIds();
					if(seats2.contains(",")){
						String[] sid = seats2.split(",");
						String code = "";
						for(String s : sid){
							if(s != null){
								if(code.length()==0){
									code += UUID.randomUUID().toString().replace("-", "").substring(0,6);
								}else{
									code += ","+UUID.randomUUID().toString().replace("-", "").substring(0,6);
								}
							}
						}
						fightTicketService.updWatchCode(code, fightTicket.getId());
					}else{
						String code = UUID.randomUUID().toString().replace("-", "").substring(0,6);
						fightTicketService.updWatchCode(code, fightTicket.getId());
					}
				}
			}
			
			reviewService.updReviewStatus("3", id,account.getUserName());
			
			fightTicketService.updReviewStatus("3", account.getUserName(), review.getFightTicket().getId());
		}
		return "redirect:selReview?pageNo="+pageNo+"&type="+type;
	}
	
	/**
	 * 获取待审核申请的总数量
	 */
	@ResponseBody
	@RequestMapping(value = "getReviewCount")
	public int getReviewCount(){
		int count = 0;
		count = reviewService.selStatusCount();
		return count;
	}
}
