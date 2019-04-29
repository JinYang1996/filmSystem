package com.neusoft.modules.front.filmDetail.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.neusoft.common.httpClient.ClientCustomSSL;
import com.neusoft.common.page.Page;
import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.collect.model.Collect;
import com.neusoft.modules.collect.service.CollectService;
import com.neusoft.modules.coupon.model.Coupon;
import com.neusoft.modules.coupon.service.CouponService;
import com.neusoft.modules.front.fightTicket.model.FightTicket;
import com.neusoft.modules.front.fightTicket.service.FightTicketService;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.front.filmDetail.service.FilmDetailService;
import com.neusoft.modules.front.filmType.model.FilmType;
import com.neusoft.modules.front.filmType.service.FilmTypeService;
import com.neusoft.modules.theaterArrange.model.TheaterArrange;
import com.neusoft.modules.theaterArrange.service.TheaterArrangeService;

@Controller
@RequestMapping(value = "/filmDetail")
public class FilmDetailController {

	@Autowired
	private FilmDetailService filmDetailServcie;
	
	@Autowired
	private FilmTypeService filmTypeService;
	
	@Autowired
	private CouponService couponService;
	
	@Autowired
	private TheaterArrangeService theaterArrangeService;
	
	@Autowired
	private FightTicketService fightTicketService;
	
	@Autowired
	private CollectService collectService;
	
	@RequestMapping(value = "showFilm")
	public String showFilm(Model model){
		List<FilmDetail> filmList = filmDetailServcie.selAll();
		if(null != filmList){
			model.addAttribute("filmList",filmList);
		}else{
			model.addAttribute("filmList",new ArrayList<FilmDetail>());
		}
		return "/modules/film/filmList";
	}
	
	@RequestMapping(value = "showPartFilm")
	public String showPartFilm(Model model,Integer pageNo){
		Page page = filmDetailServcie.selPageFilm(pageNo);
		if(null != page.getData()){
			model.addAttribute("page",page);
		}else{
			return "/error/noFilm.jsp";
		}
		return "/modules/front/film/showPartFilm";
	}
	
	@ResponseBody
	@RequestMapping(value = "getAllFilm")
	public Page getAllFilm(@RequestParam("title")String title,@RequestParam("type")String type,
			@RequestParam("pageNo")Integer pageNo,@RequestParam("state")String state){
		FilmDetail filmDetail = new FilmDetail();
		filmDetail.setTitle(title);
		if(state.equals("undefined")){
			filmDetail.setState("");
		}else if(state.equals("全部")){
			filmDetail.setState("");
		}else{
			filmDetail.setState(state);
		}
		if(!"".equals(type)){
			String typeId = filmTypeService.selIdByTypeName(type);
			if(typeId == null){
				filmDetail.setType("0");
			}
			filmDetail.setType(typeId);
		}
		Page page = filmDetailServcie.selByFilm(filmDetail,pageNo);
		if(null == page.data && page.data.size() == 0)
			page.setData(new ArrayList<FilmDetail>());
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "selAll")
	public List<FilmDetail> selAll(Integer pageNo){
		List<FilmDetail> filmList = filmDetailServcie.selAll();
		if(null == filmList)
			filmList = new ArrayList<FilmDetail>();
		return filmList;
	}
	
	@ResponseBody
	@RequestMapping(value = "addFilm")
	public String addFilm(HttpSession session){
		String flag = "0";
		Account account = (Account)session.getAttribute("user");
		if(null != account && !"".equals(account.getUserName())){
			List<FilmDetail> filmList;
			try {
				filmList = ClientCustomSSL.achieveFilms();
				for(FilmDetail film : filmList){
					int count = filmDetailServcie.selFilmByTitle(film.getTitle());
					if(count == 0){
						film.setCreateBy(account.getUserName());
						film.setPrice(99.00);
						filmDetailServcie.insert(film);
						flag = "1";//添加成功
					}else{
						//更新影片简介和豆瓣评分
						film.setUpdateBy(account.getUserName());
						filmDetailServcie.update(film);
						flag = "3";//更新成功
					}
					flag = "2";
				}
			} catch (JsonProcessingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	/**
	 * 跳转到添加电影页
	 * 部门：软件开发事业部
	 * 功能：
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-4-11
	 */
	@RequestMapping(value = "toAddFilm")
	public String toAddFilm(){
		return "modules/film/addFilm";
	}
	
	@RequestMapping(value = "delAllFilm")
	public String delAllFilm(){
		filmDetailServcie.delAll();
		return "redirect:/filmDetail/showFilm";
	}
	
	@RequestMapping(value = "getFilmDetail")
	public String getFilmDetail(@RequestParam("id")String id,Model model){
		FilmDetail film = filmDetailServcie.get(id);
		List<FilmType> typeList = filmTypeService.selType(film);
		int size = typeList.size();
		String type = "";
		if(size == 1 && typeList.get(0) == null){//类型有误，直接显示
			type = film.getType();
		}else if(size == 1 && typeList.get(0) != null){
			type = typeList.get(0).getTypeName();
		}else{//如果类型是多个，则用"/"分隔显示
			for(int i=0 ; i<size ; i++){
				type += typeList.get(i).getTypeName();
				if(i < size-1){
					type += "/";
				}
			}
		}
		model.addAttribute("type",type);
		model.addAttribute("film",film);
		return "modules/film/specifyFilm";
	}
	
	@RequestMapping(value = "saveFilmPrice")
	public String saveFilmPrice(FilmDetail filmDetail,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		if(null != filmDetail && !("").equals(filmDetail.getPrice())){
			filmDetailServcie.updatePrice(filmDetail.getPrice(),filmDetail.getId(),account.getUserName());
			return "redirect:selByFilm?pageNo=0";
		}else{
			return "error/error";
		}
		
	}
	
	@RequestMapping(value = "selectedFilm")
	public String selectedFilm(@RequestParam("id")String id,Model model,HttpSession session){
		FilmDetail film = filmDetailServcie.get(id);
		List<FilmType> typeList = filmTypeService.selType(film);
		int size = typeList.size();
		String type = "";
		if(size == 1 && typeList.get(0) == null){//类型有误，直接显示
			type = film.getType();
		}else if(size == 1 && typeList.get(0) != null){
			type = typeList.get(0).getTypeName();
		}else{//如果类型是多个，则用"/"分隔显示
			for(int i=0 ; i<size ; i++){
				type += typeList.get(i).getTypeName();
				if(i < size-1){
					type += "/";
				}
			}
		}
		
		/*CouponType couType = new CouponType();
		Coupon cou = new Coupon();
		Coupon coupon = null;
		
		couType.setFilmDetail(film);
		CouponType couponType = couponTypeService.selFilmId(couType);
		if(couponType == null){//该影片没有专门的优惠，所以使用通用优惠
			String typeId = couponTypeService.selTypeName("通用");
			CouponType couType1 = new CouponType();
			couType1.setId(typeId);
			cou.setCouponType(couType1);
			coupon = couponService.selType(cou);
		}else{//影片有专门的优惠活动
			cou.setCouponType(couponType);
			coupon = couponService.selType(cou);
		}*/
		
		Coupon cou = new Coupon();
		cou.setFilmDetail(film);
		Coupon coupon = null;
		
		Coupon cou1 = couponService.selFilmId(cou);
		if(cou1 == null){
			//优惠为通用优惠
			coupon = couponService.selType("0");
		}
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String day = sdf.format(date);
		SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm:ss");
		String startTime = sdf1.format(new Date());
		Date startDate = null;
		try {
			startDate = sdf1.parse(startTime);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<TheaterArrange> arrangeList = theaterArrangeService.selByFilmId(id,day);
		
		for(int i = arrangeList.size()-1; i >= 0; i --){
			List<FightTicket> fight = fightTicketService.selFightByArrange(arrangeList.get(i).getId());
			if(fight.size() == 0){
				arrangeList.get(i).setIsFight("0");//没有拼单标记
			}else{
				arrangeList.get(i).setIsFight("1");//存在拼单选座
			}
			//将今天超过此时段的影厅安排移除显示
			String relTime = sdf.format(arrangeList.get(i).getReleaseTime());
			if(relTime.equals(day)){
				if(arrangeList.get(i).getStartTime().compareTo(startDate) < 0){
					arrangeList.remove(arrangeList.remove(i));
				}
			}
		}
		
		Account account = (Account)session.getAttribute("user");
		//查询该账号下 此电影是否收藏过
		Collect collect = null;
		if(null != account && !("").equals(account.getUserName())){
			collect = collectService.selByFilmAccount(id, account.getId());
		}	
		
		model.addAttribute("film",film);
		model.addAttribute("typeList",typeList);
		model.addAttribute("type",type);
		model.addAttribute("coupon",coupon);
		model.addAttribute("arrangeList",arrangeList);
		model.addAttribute("collect",collect);
		return "modules/front/film/selectedFilm";
	}
	
	/**
	 * 影片根据积分排行
	 */
	@ResponseBody
	@RequestMapping(value = "selFilmByScore")
	public List<FilmDetail> selFilmByScore(){
		List<FilmDetail> filmList = filmDetailServcie.selFilmByScore();
		return filmList;
	}
	
	/**
	 * 删除影片
	 */
	@ResponseBody
	@RequestMapping(value = "delFilm")
	public String delFilm(String id,HttpSession session){
		String flag = "";
		Account account = (Account)session.getAttribute("user");
		if(null != id && !"".equals(id)){
			List<TheaterArrange> arrangeList = theaterArrangeService.selArrangeByFilm(id);
			if(arrangeList.size() == 0){
				filmDetailServcie.updDelFlag("1", id ,account.getUserName());
				flag = "1";
			}else{
				flag = "2";
			}
			
		}
		return flag;
	}
	
	/**
	 * 查询影片
	 */
	@RequestMapping(value = "selByFilm")
	public String selByFilm(Model model,FilmDetail filmDetail,@RequestParam("pageNo")Integer pageNo){
		FilmDetail film = (FilmDetail) filmDetail.clone();
		
		if(pageNo == null){
			pageNo = 0;
		}
		
		if(null != filmDetail && !"".equals(filmDetail.getType())){
			String type = filmDetail.getType();
			String typeId = filmTypeService.selIdByTypeName(type);
			if(typeId == null){
				filmDetail.setType("0");
			}
			filmDetail.setType(typeId);
		}
		Page page = filmDetailServcie.selByFilm(filmDetail,pageNo);
		if(null == page.getData()){
			page.setData(new ArrayList<FilmDetail>());
		}
		List<FilmType> typeList = filmTypeService.selAll();
		model.addAttribute("page",page);
		model.addAttribute("filmDetail",film);
		model.addAttribute("typeList",typeList);
		return "/modules/film/filmList";
	}
	
	/**
	 * 查询所有的影片类型
	 */
	@ResponseBody
	@RequestMapping(value = "getAllFilmType")
	public List<FilmType> getAllFilmType(){
		List<FilmType> typeList = filmTypeService.selAll();
		if(typeList == null){
			typeList = new ArrayList<FilmType>();
		}
		return typeList;
	}
	
	/**
	 * 页面倒计时
	 */
	@ResponseBody
	@RequestMapping(value = "countDownTime")
	public String countDownTime(String id){
		FightTicket fightTicket = fightTicketService.selDelFlag(id);
		if(fightTicket != null){
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(fightTicket.getCreateDate());
			//订单15分钟之内确定 ，否则取消订单
			calendar.add(Calendar.MINUTE, 15);
			Date endDate = calendar.getTime();
			
			Date nowDate = new Date(System.currentTimeMillis());
			long seconds = (endDate.getTime() - nowDate.getTime())/1000;
			Map<String,Float> map = new HashMap<String,Float>();
			map.put("seconds", new Float(seconds));
			try {
				return new ObjectMapper().writeValueAsString(map);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@RequestMapping(value = "toAddNewFilm")
	public String toAddNewFilm(){
		return "modules/film/addFilmDetail";
	}
	
	/**
	 * 根据影片名查询影片是否存在
	 */
	@ResponseBody
	@RequestMapping(value = "selFilmExist")
	public String selFilmExist(String title){
		String flag = "";
		int count =  filmDetailServcie.selFilmByTitle(title);
		if(count == 0){
			//影片不存在
			flag = "1";
		}else{
			//影片存在
			flag = "2";
		}
		return flag;
	}
	
	/**
	 * 添加电影
	 */
	@RequestMapping(value = "addNewFilm")
	public String addNewFilm(FilmDetail filmDetail,@RequestParam("filmPicture")MultipartFile file,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		filmDetail.setId(UUID.randomUUID().toString().replace("-", ""));
		filmDetail.setCreateBy(account.getUserName());
		if(!file.getOriginalFilename().equals("")){
			String url = session.getServletContext().getRealPath("upload");
			String lpath = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			String path = new Date().getTime()+lpath;
			filmDetail.setPicture("upload/"+path);
			File data = new File(url+"\\"+path);
			try {
				FileUtils.copyInputStreamToFile(file.getInputStream(),data);				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		filmDetailServcie.insert(filmDetail);
		return "redirect:selByFilm?pageNo=0";
	}
}
