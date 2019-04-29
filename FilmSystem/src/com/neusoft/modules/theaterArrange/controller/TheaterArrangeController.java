package com.neusoft.modules.theaterArrange.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neusoft.common.page.Page;
import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.applyArrange.model.ApplyArrange;
import com.neusoft.modules.applyArrange.service.ApplyArrangeService;
import com.neusoft.modules.coupon.model.Coupon;
import com.neusoft.modules.coupon.service.CouponService;
import com.neusoft.modules.front.fightTicket.model.FightTicket;
import com.neusoft.modules.front.fightTicket.service.FightTicketService;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.front.filmDetail.service.FilmDetailService;
import com.neusoft.modules.theaterArrange.model.TheaterArrange;
import com.neusoft.modules.theaterArrange.service.TheaterArrangeService;
import com.neusoft.modules.videoHall.model.VideoHall;
import com.neusoft.modules.videoHall.service.VideoHallService;

@Controller
@RequestMapping(value = "theaterArrange")
public class TheaterArrangeController {

	@Autowired
	private TheaterArrangeService theaterArrangeService;
	
	@Autowired
	private VideoHallService videoHallService;
	
	@Autowired
	private CouponService couponService;
	
	@Autowired
	private FilmDetailService filmDetailService;
	
	@Autowired
	private FightTicketService fightTicketService;
	
	@Autowired
	private ApplyArrangeService applyArrangeService;
	
	@RequestMapping(value = "showAllArrange")
	public String showAllArrange(Model model,TheaterArrange theaterArrange,@RequestParam("pageNo")Integer pageNo,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		if(pageNo == null){
			pageNo = 0;
		}
		
		Page page = null;
		if(account.getRole().getId().equals("2")){//普通管理员
			page = theaterArrangeService.selArrangeByTerm(theaterArrange, pageNo);
		}else if(account.getRole().getId().equals("3")){//超级管理员
			page = theaterArrangeService.selArrangeByTermSuper(theaterArrange, pageNo);
		}
		if(null == page.getData()){
			page.setData(new ArrayList<TheaterArrange>());
		}
		List<VideoHall> videoHallList = videoHallService.selAll();
		model.addAttribute("page",page);
		model.addAttribute("theaterArrange",theaterArrange);
		model.addAttribute("videoHallList",videoHallList);
		return "modules/theaterArrange/showTheaterArrange";
	}
	
	@RequestMapping(value = "toAddArrange")
	public String toAddArrange(Model model,String title){
		Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_YEAR, 1);
		Date tomorrow = calendar.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String today = sdf.format(tomorrow);
		
		//获取影厅列表
		List<VideoHall> hallList = videoHallService.selAll();
		
		//获取优惠列表
		List<Coupon> couponList = couponService.selAll();
		
		//获取电影列表
		List<FilmDetail> filmList = filmDetailService.selAll();
		
		model.addAttribute("today",today);
		model.addAttribute("hallList",hallList);
		model.addAttribute("couponList",couponList);
		model.addAttribute("filmList",filmList);
		model.addAttribute("title",title);
		return "modules/theaterArrange/addTheaterArrange";
	}
	
	@RequestMapping(value = "addArrange")
	public String addArrange(Model model,TheaterArrange theaterArrange,
			@RequestParam("filmTime")String filmTime,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		theaterArrangeService.addTheater(theaterArrange, filmTime, account);
		return "redirect:showAllArrange?pageNo=1";
	}
	
	@ResponseBody
	@RequestMapping(value = "checkTime")
	public String checkTime(Model model,HttpServletRequest request){
		String flag = "0";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		
		String hallId = request.getParameter("hallId");
		String filmId = request.getParameter("filmId");
		String checkTime = request.getParameter("checkTime");
		VideoHall hall = new VideoHall();
		FilmDetail film = new FilmDetail();
		TheaterArrange arrange = new TheaterArrange();
		hall.setId(hallId);
		film.setId(filmId);
		arrange.setVideoHall(hall);
		arrange.setFilmDetail(film);
		
		List<TheaterArrange> arrangeList = theaterArrangeService.selByHallId(arrange);
		FilmDetail filmDetail = filmDetailService.get(filmId); 
		
		//获取所选时间的电影结束时间
		String filmLength = filmDetail.getFilmLength();
		String length = filmLength.substring(0,filmLength.indexOf("分钟"));
		Calendar calendar = Calendar.getInstance();
		try {
			calendar.setTime(sdf2.parse(checkTime));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		calendar.add(Calendar.MINUTE, Integer.parseInt(length));
		String end = sdf1.format(calendar.getTime());
		Date checkE = null;
		
		List<String> flagList = new ArrayList<String>();
		
		for(TheaterArrange t : arrangeList){
			Date releaseTime = t.getReleaseTime();
			//选中日期的  年/月/日
			String checkDate = checkTime.substring(0,10);
			//选中日期的时间段  时：分
			String checkStart = checkTime.substring(11);
			Date checkD = null;
			Date checkS = null;
			try {
				checkD = sdf.parse(checkDate);
				checkS = sdf1.parse(checkStart);
				checkE = sdf1.parse(end);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//判断所选日期的 年月日 和该影厅的 年月日 是否相同，不是同一天的时间段比较 无意义
			if(checkD.compareTo(releaseTime) == 0){//与所选日期 年月日 相同
				Date startTime = t.getStartTime();
				Date endTime = t.getEndTime();
				if(startTime.compareTo(checkS) == 0){         //start=check
					flag = "1";//所选时间段的开始时间相同  不可选
				}else if(startTime.compareTo(checkS) < 0){//所选时间在时间段之后    start<check
					if(checkS.compareTo(endTime) == 0){       //start<check=end
						flag = "1";//所选时间段的开始时间与结束时间冲突  不可选
					}else if(checkS.compareTo(endTime) < 0){  //start<check<end
						flag = "1";//所选时间在该时间段之内  不可选
					}else{
						flag = "2";//所选时间在时间段之外  可选                         //start<end<check
					}
				}else{//所选时间在时间段之前
					if(checkE.compareTo(startTime) == 0){ //  checkEnd=start
						flag = "1";//所选时间的结束时间与安排时间冲突
					}else if(checkE.compareTo(startTime) < 0){//checkEnd<start
						flag = "2";//所选时间段不冲突
					}else{
						flag = "1";//所选时间的结束时间与安排时间冲突   start<checkEnd
					}
				}
			}
			
			flagList.add(flag);
			
		}
		String count = "0";
		for(String s : flagList){
			if(s == "1"){
				count = "1";//时间段不符合
				break;
			}else if(s == "2"){
				count = "2";
			}
		}
		
		return count;
	}
	
	@RequestMapping(value = "delArrange")
	public String delArrange(@RequestParam("arrangeId")String arrangeId){
		TheaterArrange theaterArrange = theaterArrangeService.get(arrangeId);
		theaterArrangeService.delArrange(arrangeId);
		
		FilmDetail filmDetail = theaterArrange.getFilmDetail();
		Date releaseTime = theaterArrange.getReleaseTime();
		TheaterArrange theater = new TheaterArrange();
		theater.setReleaseTime(releaseTime);
		theater.setFilmDetail(filmDetail);
		int count = theaterArrangeService.selTermCount(theater);
		if(count == 0){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String applyTime = sdf.format(releaseTime);
			ApplyArrange applyArrange = new ApplyArrange();
			applyArrange.setApplyTime(applyTime);
			applyArrange.setFilmDetail(filmDetail);
			List<ApplyArrange> applyList = applyArrangeService.selApplyByTime(applyArrange);
			for(ApplyArrange apply : applyList){
				//审核状态：2     无放映安排
				applyArrangeService.updReviewStatus("2", apply.getId());
			}
		}
		return "redirect:showAllArrange?pageNo=1";
	}
	
	@ResponseBody
	@RequestMapping(value = "getCorrectArrange")
	public List<TheaterArrange> getCorrectArrange(@RequestParam("filmId")String filmId,@RequestParam("releaseTime")String releaseTime){
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd"); 
		List<TheaterArrange> arrangeList = theaterArrangeService.selByFilmId(filmId,releaseTime);
		String today = sdf1.format(new Date());
		String startTime = sdf.format(new Date());
		Date startDate = null;
		try {
			startDate = sdf.parse(startTime);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//将今天超过此时段的影厅安排移除显示
		for(int i = arrangeList.size()-1; i >= 0; i --){
			List<FightTicket> fight = fightTicketService.selFightByArrange(arrangeList.get(i).getId());
			if(fight.size() == 0){
				arrangeList.get(i).setIsFight("0");//没有拼单标记
			}else{
				arrangeList.get(i).setIsFight("1");//存在拼单选座
			}
			//将今天超过此时段的影厅安排移除显示
			String relTime = sdf1.format(arrangeList.get(i).getReleaseTime());
			if(relTime.equals(today)){
				if(arrangeList.get(i).getStartTime().compareTo(startDate) < 0){
					arrangeList.remove(arrangeList.remove(i));
				}
			}
		}
		return arrangeList;
	}
	
	@RequestMapping(value = "toDelArrange")
	public String toDelArrange(String id ,Model model){
		applyArrangeService.updReviewStatus("2",id);
		return "redirect:/appalyArrange/selAllApply?pageNo=1";
	}
}
