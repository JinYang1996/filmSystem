package com.neusoft.modules.collect.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.collect.model.Collect;
import com.neusoft.modules.collect.service.CollectService;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.front.filmDetail.service.FilmDetailService;

@Controller
@RequestMapping(value = "collect")
public class CollectController {

	@Autowired
	private CollectService collectService;
	
	@Autowired
	private FilmDetailService filmDetailService;
	
	/**
	 * 添加收藏
	 */
	@ResponseBody
	@RequestMapping(value = "addCollect")
	public String addCollect(String filmId,HttpSession session){
		String flag = "0";
		FilmDetail film = filmDetailService.get(filmId);
		Account account = (Account)session.getAttribute("user");
		
		if(null != account && !("").equals(account.getUserName())){
			Collect collects = collectService.selByFilmAccount(filmId,account.getId());
			if(collects == null){
				Collect collect = new Collect();
				collect.setId(UUID.randomUUID().toString().replace("-", ""));
				collect.setFilmDetail(film);
				collect.setAccount(account);
				collectService.insert(collect);
				flag = "2";//添加成功
			}else{
				flag = "3";//已收藏
			}
		}else{
			flag = "1";//未登录
		}		
		return flag;
	}
	
	/**
	 * 查询该账号下的所有收藏信息
	 */
	@RequestMapping(value = "selAllCollect")
	public String selAllCollect(Model model,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		List<Collect> collectList = collectService.selByAccount(account.getId());
		model.addAttribute("collectList",collectList);
		return "modules/front/person/person_collect";
	}
	
	/**
	 * 删除收藏信息
	 */
	@RequestMapping(value = "delCollect")
	public String delCollect(String id){
		if(null != id){
			//将收藏信息del_flag设为“1”  删除
			collectService.updDelFlag("1", id);
		}
		return "redirect:selAllCollect";
	}
}
