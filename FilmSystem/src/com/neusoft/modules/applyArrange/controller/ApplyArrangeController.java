package com.neusoft.modules.applyArrange.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

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
import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.front.filmDetail.service.FilmDetailService;
import com.neusoft.modules.theaterArrange.model.TheaterArrange;
import com.neusoft.modules.theaterArrange.service.TheaterArrangeService;
import com.neusoft.modules.videoHall.model.VideoHall;
import com.neusoft.modules.videoHall.service.VideoHallService;

@Controller
@RequestMapping(value = "applyArrange")
public class ApplyArrangeController {

	@Autowired 
	private ApplyArrangeService applyArrangeService;
	
	@Autowired
	private TheaterArrangeService theaterArrangeService;
	
	@Autowired
	private VideoHallService videoHallService;
	
	@Autowired
	private CouponService couponService;
	
	@Autowired
	private FilmDetailService filmDetailService;
	
	@ResponseBody
	@RequestMapping(value = "addApply")
	public String addApply(@RequestParam("filmId")String filmId,
			@RequestParam("releaseTime")String releaseTime,HttpSession session){
		String flag = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date releaseDate = null;
		try {
			releaseDate = sdf.parse(releaseTime);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Account account = (Account)session.getAttribute("user");
		if(null != account && !"".equals(account.getUserName())){
			List<ApplyArrange> applyList = applyArrangeService.selApplyByFilmId(filmId,releaseDate);
			if(applyList.size() == 0){
				FilmDetail filmDetail = new FilmDetail();
				filmDetail.setId(filmId);
				
				ApplyArrange applyArrange = new ApplyArrange();
				applyArrange.setId(UUID.randomUUID().toString().replace("-", ""));
				applyArrange.setFilmDetail(filmDetail);
				applyArrange.setApplyTime(releaseTime);
				applyArrange.setCreateBy(account.getUserName());
				applyArrangeService.insert(applyArrange);
				flag = "1";//添加成功
			}else{
				flag = "3";//已提交过申请
			}
			
		}else{
			flag = "2";//未登录
		}
		
		return flag;
	}
	
	@RequestMapping(value = "selAllApply")
	public String selAllApply(Model model,ApplyArrange applyArrange,@RequestParam("pageNo")Integer pageNo,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		Page page = null;
		if(account.getRole().getId().equals("2")){
			page = applyArrangeService.selApplyByTerm(applyArrange, pageNo);
		}else if(account.getRole().getId().equals("3")){
			page = applyArrangeService.selApplyByTermSuper(applyArrange, pageNo);
		}
		if(page.data == null){
			page.setData(new ArrayList<ApplyArrange>());
		}
		
		model.addAttribute("page",page);
		model.addAttribute("applyArrange",applyArrange);
		return "modules/applyArrange/applyArrangeList";
	}
	
	@RequestMapping(value = "selArrange")
	public String selArrange(String id,Model model,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		TheaterArrange theaterArrange = new TheaterArrange();
		ApplyArrange applyArrange = applyArrangeService.get(id);
		String applyTime = applyArrange.getApplyTime();
		FilmDetail filmDetail = applyArrange.getFilmDetail();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date releaseTime = null;
		try {
			releaseTime = sdf.parse(applyTime);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		theaterArrange.setReleaseTime(releaseTime);
		theaterArrange.setFilmDetail(filmDetail);
		int pageNo = 1;
		Page page = null;
		if(account.getRole().getId().equals("2")){
			page = theaterArrangeService.selArrangeByTerm(theaterArrange, pageNo);
		}else if(account.getRole().getId().equals("3")){
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
	
	/**
	 * 查询账号下的申请信息
	 */
	@RequestMapping(value = "selApplyByUser")
	public String selApplyByUser(HttpSession session,Model model){
		Account account = (Account)session.getAttribute("user");
		List<ApplyArrange> applyList = applyArrangeService.selApplyByUser(account.getUserName());
		model.addAttribute("applyList",applyList);
		return "modules/front/person/per_fight";
	}
	
	/**
	 * 驳回申请
	 */
	@RequestMapping(value = "toDelArrange")
	public String toDelArrange(String id){
		//驳回申请  修改申请的审核状态 ：申请失败
		applyArrangeService.updReviewStatus("2", id);
		return "redirect:selAllApply?pageNo=1";
	}
	
	/**
	 * 添加申请时间段
	 */
	@RequestMapping(value = "toAddApplyArrange")
	public String toAddArrange(Model model,@RequestParam("title")String title,@RequestParam("applyTime")String applyTime){
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
		model.addAttribute("applyTime",applyTime);
		return "modules/theaterArrange/addTheaterArrange";
	}
	
	@RequestMapping(value = "cancelApply")
	public String cancelApply(String id){
		ApplyArrange apply = new ApplyArrange();
		apply.setDelFlag("1");
		apply.setId(id);
		applyArrangeService.updateDelFlag(apply);
		return "redirect:selApplyByUser";
	}
}
