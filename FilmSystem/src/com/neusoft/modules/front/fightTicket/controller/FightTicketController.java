package com.neusoft.modules.front.fightTicket.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.front.filmDetail.service.FilmDetailService;
import com.neusoft.modules.integral.model.IntegralInfo;
import com.neusoft.modules.integral.service.IntegralInfoService;
import com.neusoft.modules.review.model.Review;
import com.neusoft.modules.review.service.ReviewService;
import com.neusoft.modules.seat.model.Seat;
import com.neusoft.modules.seat.service.SeatService;
import com.neusoft.modules.theaterArrange.model.TheaterArrange;
import com.neusoft.modules.theaterArrange.service.TheaterArrangeService;
import com.neusoft.modules.videoHall.model.VideoHall;
import com.neusoft.modules.videoHall.service.VideoHallService;

@Controller
@RequestMapping(value = "fightTicket")
public class FightTicketController {

	@Autowired
	private FightTicketService fightTicketService;
	
	@Autowired
	private TheaterArrangeService theaterArrangeService;
	
	@Autowired
	private SeatService seatService;
	
	@Autowired
	private IntegralInfoService integralInfoService;
	
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private VideoHallService videoHallService;
	
	@Autowired
	private FilmDetailService filmDetailService;
	
	@ResponseBody
	@RequestMapping(value = "addFightTicket")
	public Map addFightTicket(@RequestParam("arrangeId")String arrangeId,
			@RequestParam("seatList")String seatList,@RequestParam("isFight")String isFight,HttpSession session){
		Map resultMap = new HashMap();
		String flag = "0";
		TheaterArrange arrange = theaterArrangeService.get(arrangeId);
		
		FightTicket fightTicket = new FightTicket();
		fightTicket.setId(UUID.randomUUID().toString().replace("-", ""));
		fightTicket.setBeforeOrder("");
		Account account = (Account)session.getAttribute("user");
		if(account != null && account.getUserName() !=null){
			fightTicket.setFightPeople(account.getUserName());
			fightTicket.setFilmDetail(arrange.getFilmDetail());
			fightTicket.setTheaterArrange(arrange);
			
			String seat[] = seatList.split(",");
			
			/*购票数*/
			int count = seat.length;
			
			List<String> seatIds = new ArrayList<String>();
			
			//存放该安排下座位id的集合
			List<String> seats = new ArrayList<String>();
			
			List<FightTicket> fights = fightTicketService.selFightByArrange(arrangeId);
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
			
			for(String s : seat){
				String row = s.substring(s.indexOf("row"),s.indexOf("col"));
				String col = s.substring(s.indexOf("col"));
				Seat seat1 = seatService.selSeatByHall(row, col, arrange.getVideoHall().getId());
				if(seats.contains(seat1.getId())){
					flag = "3";//座位已被预约！
					break;
				}else{
					seatIds.add(seat1.getId());
				}
			}
			if(!flag.equals("3")){
				fightTicket.setSeatIds(StringUtils.strip(seatIds.toString(),"[]"));
				
				DecimalFormat df = new DecimalFormat("#.00");
				
				//原价
				double originalPrice = count * (arrange.getFilmDetail().getPrice());
				fightTicket.setOriginalPrice(originalPrice);
				
				//票数
				fightTicket.setTicketCount(count);
				
				//优惠后的价格
				double price = count * (arrange.getFilmDetail().getPrice() - arrange.getCoupon().getCouponPrice());
				fightTicket.setPrice(price);
				
				//发起状态  待审核
				fightTicket.setFightStatus("1");
				
				fightTicket.setFavorable(arrange.getCoupon().getCouponName()+":"+df.format(arrange.getCoupon().getCouponPrice()));
				
				//支付状态：未支付
				fightTicket.setPayStatus("1");
				
				//订单状态为占用状态  del_flag='2'
				fightTicket.setDelFlag("2");
				
				//查找发起此次拼单的订单信息
				FightTicket fightTicket1 = fightTicketService.selWhichFight(arrangeId);
				
				//订单类型  1:申请拼单  2.申请参加拼单
				if(isFight.equals("1")){
					//参与拼单
					fightTicket.setType("2");

					if(fightTicket1 != null){
						if(fightTicket1.getType().equals("1")){
							if(fightTicket1.getReviewStatus().equals("1")){
								//审核状态：待审核
								fightTicket.setReviewStatus("1");
							}else if(fightTicket1.getReviewStatus().equals("0")){
								//审核状态：已通过
								fightTicket.setReviewStatus("0");
							}else{
								//审核状态：未通过
								fightTicket.setReviewStatus("3");
							}
						}else if(fightTicket1.getType().equals("3")){
							if(fightTicket1.getReviewStatus().equals("1")){
								//审核状态：待审核
								fightTicket.setReviewStatus("1");
							}else if(fightTicket1.getReviewStatus().equals("0")){
								//审核状态：已通过
								fightTicket.setReviewStatus("3");
							}else{
								//审核状态：未通过
								fightTicket.setReviewStatus("0");
							}
						}
					}else{
						//审核状态：待审核
						fightTicket.setReviewStatus("1");
					}
				}else if(isFight.equals("0")){
					//申请拼单
					fightTicket.setType("1");

					//审核状态：待审核
					fightTicket.setReviewStatus("1");
				}
				
				fightTicket.setCreateBy(account.getUserName());
				fightTicket.setCreateDate(new Date());
				
				fightTicketService.insert(fightTicket);
				//放入Map集合中
				resultMap.put("fightTicket", fightTicket);
				flag = "1";//添加成功
			}
		}else{
			flag = "2";//请登录
		}
		
		resultMap.put("flag", flag);
		return resultMap;
	}
	
	@RequestMapping(value = "toSubmitOrder")
	public String toSubmitOrder(String fightId,Model model,HttpSession session){
		FightTicket fightTicket = fightTicketService.selDelFlag(fightId);
		
		Account account = (Account)session.getAttribute("user");
		account = accountService.get(account.getId());
		session.setAttribute("user", account);
		
		//座位信息
		String rowCol = "";
		
		if(account != null && account.getUserName() != null){
			String seatIds = fightTicket.getSeatIds();
			
			if(seatIds.contains(",")){
				String[] ids = seatIds.split(",");
				for(String s : ids){
					String id = StringUtils.trim(s);
					Seat seat = seatService.get(id);
					String row = seat.getSeatRow();
					String col = seat.getSeatNumber();
					if(rowCol.length() == 0){
						rowCol = row.substring(3)+"排"+col.substring(3)+"座";
					}else{
						rowCol += ","+row.substring(3)+"排"+col.substring(3)+"座";
					}
				}
			}else{
				Seat seat = seatService.get(seatIds);
				String row = seat.getSeatRow();
				String col = seat.getSeatNumber();
				rowCol = row.substring(3)+"排"+col.substring(3)+"座";
			}
		}
		
		model.addAttribute("fightTicket",fightTicket);
		model.addAttribute("rowCol",rowCol);
		return "modules/front/film/submitOrder";
	}
	
	/**
	 * 提交拼单信息  支付
	 * 部门：软件开发事业部
	 * 功能：
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-4-5
	 */
	@ResponseBody
	@RequestMapping(value = "submitOrder")
	public String submitOrder(@RequestParam("fightId")String fightId,
			@RequestParam("finalPrice")String finalPrice,
			@RequestParam("usedScore")String usedScore,
			@RequestParam("leaveScore")String leaveScore,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		String flag = "0";
		if(account != null && account.getUserName() != null){
			//防止多次订单提交
			FightTicket fightTicket = fightTicketService.get(fightId);
			
			if(null != fightTicket && ("0").equals(fightTicket.getPayStatus())){
				flag = "4";//订单多次提交
			}else{
				if(fightId != null && fightId != ""){
					
					//更改订单的支付状态
					fightTicketService.updPayStatus(fightId);
					
					//更改订单的最终价格
					fightTicketService.updPrice(Double.parseDouble(finalPrice), fightId,Integer.parseInt(usedScore));
					
					//更新订单状态  占用状态变为正常状态
					fightTicketService.updDelFlag("0", fightId);
					
					FightTicket fightTicket1 = fightTicketService.get(fightId);
					
					//添加积分记录
					if(Integer.parseInt(usedScore) != 0){
						IntegralInfo integral = new IntegralInfo();
						integral.setId(UUID.randomUUID().toString().replace("-", ""));
						integral.setAccount(account);
						if(fightTicket1.getType().equals("1")){
							integral.setIntegralSource("发起拼单使用");
						}else if(fightTicket1.getType().equals("2")){
							integral.setIntegralSource("参与拼单使用");
						}
						integral.setScore(-Integer.parseInt(usedScore));
						integralInfoService.insert(integral);
					}
					
					accountService.updIntegral(Integer.parseInt(leaveScore), account.getId());
					
					if(fightTicket1.getType().equals("1")){//发起拼单，则发起审核
						Review review = new Review();
						review.setId(UUID.randomUUID().toString().replace("-", ""));
						review.setFightTicket(fightTicket1);
						
						review.setType(fightTicket1.getType());
						review.setReviewStatus("1");
						review.setCreateBy(account.getUserName());
						reviewService.insert(review);
					}
					flag="1";//更改支付状态成功
					
					//存放该安排下座位id的集合
					List<String> seats = new ArrayList<String>();
					
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
								String id = StringUtils.trim(s);
								seats.add(id);
							}
						}else{
							seats.add(seatIds1);
						}
					}
					float selCount = seats.size();
					/*System.out.println("selCount:"+selCount + " sumCount" +sumCount);
					System.out.println(selCount/sumCount);*/
					
					//大于百分之60 无法进行取消订单  订单到达指定人数，等待拼单者影片审核  如果审核通过，发放观影码  如果审核失败，该影片该时间段拼单信息失效
					if(selCount/sumCount > 0.6){
						for(FightTicket f : fights){
							f.setFightStatus("2");
							//修改订单发起状态为 2 ：达到指定人数
							fightTicketService.updFightStatus(f);
							//发起拼单信息
							FightTicket fightTicket2 = fightTicketService.selWhichFight(f.getTheaterArrange().getId());
							if(fightTicket2 != null){
								if((fightTicket2.getType().equals("1") && fightTicket2.getReviewStatus().equals("0")) || (fightTicket2.getType().equals("3") && fightTicket2.getReviewStatus().equals("3"))){
									if(f.getWatchCode() == null && !f.getType().equals("3") && !f.getType().equals("4")){
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
							}
							
						}
					}
				}else{
					flag="2";//订单id为空
				}
			}
		}else{
			flag = "3";//未登录
		}
		
		return flag;
	}
	
	/**
	 * 查看该用户下未取消的所有拼单订单信息
	 * 部门：软件开发事业部
	 * 功能：
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-4-7
	 */
	@RequestMapping(value = "toPersonOrder")
	public String toPersonOrder(Model model,HttpSession session,FightTicket fightTicket){
		Account account = (Account)session.getAttribute("user");
		fightTicket.setFightPeople(account.getUserName());
		List<FightTicket> fightList = fightTicketService.selAllByPerson(fightTicket);	
		model.addAttribute("fightList",fightList);
		model.addAttribute("fight",fightTicket);
		return "modules/front/person/person_order";
	}
	
	/**
	 * 取消订单
	 */
	@RequestMapping(value = "cancelOrder")
	public String cancelOrder(String fightId,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		FightTicket fight = fightTicketService.get(fightId);
		
		/*SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm:ss");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		TheaterArrange theaterArrange = theaterArrangeService.get(fight.getTheaterArrange().getId());
		String date = sdf.format(theaterArrange.getReleaseTime());
		String day = sdf1.format(theaterArrange.getStartTime());
		//放映开始时间
		String releaseDay = date + " " + day;
		Date releaseDate = null;
		try {
			releaseDate = sdf2.parse(releaseDay);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Date today = new Date();
		if(releaseDate.after(today)){
			
		}*/
		
		if(fight != null){
			fight.setId(UUID.randomUUID().toString().replace("-",""));
			
			//添加上一个订单号
			fight.setBeforeOrder(fightId);
			
			//发起状态为  取消
			fight.setFightStatus("0");
			
			//审核状态为  1：正在审核
			fight.setReviewStatus("1");
			
			//将上一个订单逻辑删除   del_flag:1
			fightTicketService.updDelFlag("1", fightId);
			
			//将上一个订单号的申请逻辑删除   del_flag:1
			Review review1 = reviewService.selReview(fightId);
			if(review1 == null){//此订单是参与拼单
				//type 类型为申请取消参与拼单
				fight.setType("4");
			}else{//此订单是申请拼单
				//type 类型为申请取消拼单
				fight.setType("3");
				reviewService.updDelFlag("1", review1.getId());
			}
			
			//创建新的申请   ：  申请取消拼单
			Review review = new Review();
			review.setId(UUID.randomUUID().toString().replace("-", ""));
			review.setFightTicket(fight);
			
			review.setType(fight.getType());
			review.setReviewStatus(fight.getReviewStatus());
			review.setCreateBy(account.getUserName());
			reviewService.insert(review);
			
			//添加取消的订单信息
			fightTicketService.insert(fight);
		}
		return "redirect:toPersonOrder";
	}
	
	/**
	 * 超时取消订单
	 */
	@RequestMapping(value = "cancelFightTicket")
	public String cancelFightTicket(@RequestParam("id")String id,@RequestParam("filmId")String filmId){
		fightTicketService.updDel(id);
		return "redirect:../filmDetail/selectedFilm?id="+filmId;
	}
	
	/**
	 * 查询订单详情
	 */
	@RequestMapping(value = "orderDetail")
	public String orderDetail(String fightId,Model model){
		FightTicket fightTicket = fightTicketService.get(fightId);
		//座位信息
		String rowCol = "";
		if(fightTicket != null){
			String seatIds = fightTicket.getSeatIds();
			
			if(seatIds.contains(",")){
				String[] ids = seatIds.split(",");
				for(String s : ids){
					String id = StringUtils.trim(s);
					Seat seat = seatService.get(id);
					String row = seat.getSeatRow();
					String col = seat.getSeatNumber();
					if(rowCol.length() == 0){
						rowCol = row.substring(3)+"排"+col.substring(3)+"座";
					}else{
						rowCol += ","+row.substring(3)+"排"+col.substring(3)+"座";
					}
				}
			}else{
				Seat seat = seatService.get(seatIds);
				String row = seat.getSeatRow();
				String col = seat.getSeatNumber();
				rowCol = row.substring(3)+"排"+col.substring(3)+"座";
			}
		}else{
			fightTicket = fightTicketService.getTicket(fightId);
		}
		
		
		model.addAttribute("fightTicket",fightTicket);
		model.addAttribute("rowCol",rowCol);
		return "modules/front/person/per_order_detail";
	}
	
	/**
	 * 查找拼单信息 ，根据创建时间进行排序
	 */
	@ResponseBody
	@RequestMapping(value = "selNewFight")
	public Page selNewFight(Integer pageNo){
		FightTicket fightTicket = new FightTicket();
		Page page = fightTicketService.selFightByCreateDate(fightTicket,pageNo);
		if(page.getData() == null){
			page.setData(new ArrayList<FightTicket>());
		}
		return page;
	}
	
	/**
	 * 查询所有订单信息
	 */
	@RequestMapping(value = "selAllFightByAdmin")
	public String selAllFightByAdmin(FightTicket fightTicket,Model model,@RequestParam("pageNo")Integer pageNo){
		Page page = fightTicketService.selAllByAdmin(fightTicket, pageNo);
		if(page.getData() == null){
			page.setData(new ArrayList<FightTicket>());
		}
		model.addAttribute("page",page);
		model.addAttribute("fight",fightTicket);
		return "modules/fightTicket/showAllFight";
	}
	
	/**
	 * 查询影片销量排行榜
	 */
	@RequestMapping(value = "selSales")
	public String selSales(Model model){
		List<FilmDetail> filmList = filmDetailService.selFilmBySales();
		model.addAttribute("filmList",filmList);
		return "modules/sales/sales";
	}
}
