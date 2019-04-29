package com.neusoft.modules.coupon.controller;

import java.util.ArrayList;
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
import com.neusoft.modules.coupon.model.Coupon;
import com.neusoft.modules.coupon.service.CouponService;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.front.filmDetail.service.FilmDetailService;
import com.neusoft.modules.theaterArrange.model.TheaterArrange;
import com.neusoft.modules.theaterArrange.service.TheaterArrangeService;

@Controller
@RequestMapping(value = "coupon")
public class CouponController {

	@Autowired 
	private CouponService couponService;
	
	@Autowired
	private FilmDetailService filmDetailService;
	
	@Autowired
	private TheaterArrangeService theaterArrangeService;
	
	@RequestMapping(value = "showAllCoupon")
	public String showAllCoupon(Model model,Coupon coupon,Integer pageNo){
		Page page = couponService.selByTerm(coupon, pageNo);
		if(page.data == null){
			page.setData(new ArrayList<Coupon>());
		}
		model.addAttribute("page",page);
		model.addAttribute("coupon",coupon);
		return "modules/coupon/couponList";
	}
	
	@RequestMapping(value = "toAddCoupon")
	public String toAddCoupon(Model model){
		List<FilmDetail> filmList = filmDetailService.selAll();
		model.addAttribute("filmList",filmList);
		return "modules/coupon/addCoupon";
	}
	
	@ResponseBody
	@RequestMapping(value = "addCoupon")
	public String addCoupon(Coupon coupon){
		String flag = "";
		if(coupon.getType().equals("1")){//专用优惠券
			Coupon cou = new Coupon();
			cou.setType("1");
			cou.setFilmDetail(coupon.getFilmDetail());
			List<Coupon> couList = couponService.selCouponByTerm(cou);
			if(couList.size() > 0){
				for(Coupon c : couList){
					couponService.updDelFlag("1", c.getId());
				}
				flag = "1";//优惠已被覆盖
			}else {
				flag = "2";//新优惠
			}
		}else if(coupon.getType().equals("0")){
			Coupon cou = new Coupon();
			cou.setType("0");
			List<Coupon> couList = couponService.selCouponByTerm(cou);
			if(couList.size() > 0){
				for(Coupon c : couList){
					couponService.updDelFlag("1", c.getId());
				}
				flag = "1";//优惠已被覆盖
			}else {
				flag = "2";//新优惠
			}
		}
		coupon.setId(UUID.randomUUID().toString().replace("-", ""));
		couponService.insert(coupon);
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value = "delCoupon")
	public String delCoupon(String id){
		String flag = "";
		if(null != id && !"".equals(id)){
			List<TheaterArrange> arrangeList = theaterArrangeService.selArrangeByCoupon(id);
			if(arrangeList.size() == 0){
				couponService.updDelFlag("1", id);
				flag = "1";
			}else{
				flag = "2";
			}
			
		}
		return flag;
	}
	
	@RequestMapping(value = "toUpdateCoupon")
	public String toUpdateCoupon(Model model,String id){
		Coupon coupon = couponService.get(id);
		List<FilmDetail> filmList = filmDetailService.selAll();
		model.addAttribute("filmList",filmList);
		model.addAttribute("coupon",coupon);
		return "modules/coupon/updateCoupon";
	}
	
	@ResponseBody
	@RequestMapping(value = "updateCoupon")
	public String updateCoupon(Coupon coupon,HttpSession session){
		String flag = "";
		Account account = (Account)session.getAttribute("user");
		if(null != coupon){
			coupon.setUpdateBy(account.getUserName());
			couponService.update(coupon);
			flag = "1";
		}else{
			flag = "2";
		}
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value = "getCoupon")
	public Coupon getCoupon(String id){
		Coupon coupon = couponService.get(id);
		return coupon;
	}
}
