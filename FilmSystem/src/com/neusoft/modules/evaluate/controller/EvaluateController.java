package com.neusoft.modules.evaluate.controller;

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
import com.neusoft.modules.evaluate.model.Evaluate;
import com.neusoft.modules.evaluate.service.EvaluateService;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;

@Controller
@RequestMapping(value = "evaluate")
public class EvaluateController {
	
	@Autowired
	private EvaluateService evaluateService;
	
	@ResponseBody
	@RequestMapping(value = "addComment")
	public Evaluate addComment(@RequestParam("filmId")String filmId,
			@RequestParam("content")String content,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		FilmDetail filmDetail = new FilmDetail(); 
		filmDetail.setId(filmId);
		Evaluate evaluate = new Evaluate();
		if(null != account){
			evaluate.setId(UUID.randomUUID().toString().replace("-",""));
			evaluate.setAccount(account);
			evaluate.setFilmDetail(filmDetail);
			evaluate.setContent(content);
			evaluate.setCreateBy(account.getUserName());
			evaluateService.insert(evaluate);
		}
		return evaluate;
	}
	
	@ResponseBody
	@RequestMapping(value = "selAllComment")
	public Page selAllComment(@RequestParam("filmId")String filmId,@RequestParam("pageNo")Integer pageNo){
		Evaluate evaluate = new Evaluate();
		FilmDetail filmDetail = new FilmDetail();
		filmDetail.setId(filmId);
		evaluate.setFilmDetail(filmDetail);
		Page page = evaluateService.selEvaluateByPage(evaluate,pageNo);
		if(page.data == null){
			page.setData(new ArrayList<Evaluate>());
		}
		return page;
	}
	
	/**
	 * 为评论点赞
	 */
	@ResponseBody
	@RequestMapping(value = "likeEvaluation")
	public Evaluate likeEvaluation(String id){
		Evaluate evaluate = evaluateService.get(id);
		int likes  = evaluate.getLikes() + 1;
		evaluate.setLikes(likes);
		evaluateService.likeEvaluation(evaluate.getLikes(), evaluate.getId());
		return evaluate;
	}
	
	/**
	 * 条件查询评论
	 */
	@RequestMapping(value = "selEvaluateByTerm")
	public String selEvaluateByTerm(Model model,Evaluate evaluate,@RequestParam("pageNo")Integer pageNo){
		Page page = evaluateService.selEvaluateByTerm(evaluate, pageNo);
		if(page.getData() == null){
			page.setData(new ArrayList<Evaluate>());
		}
		model.addAttribute("page",page);
		model.addAttribute("evaluate",evaluate);
		return "modules/evaluate/showEvaluate";
	}
	
	/**
	 * 查找评论
	 */
	@RequestMapping(value = "searchEvaluate")
	public String searchEvaluate(String id,Model model){
		Evaluate evaluate = evaluateService.selOne(id);
		model.addAttribute("evaluate",evaluate);
		return "modules/evaluate/denyEvaluate";
	}
	
	/**
	 * 修改评论审核状态
	 */
	@RequestMapping(value = "changeEvaluate")
	public String changeEvaluate(Evaluate evaluate,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		evaluate.setUpdateBy(account.getUserName());
		evaluateService.updReviewStatus(evaluate);
		return "redirect:selEvaluateByTerm?pageNo=1";
	}
	
	/**
	 * 查询个人的所有评论
	 */
	@RequestMapping(value = "selEvaluateByUser")
	public String selEvaluateByUser(Model model,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		List<Evaluate> evaluateList = evaluateService.selEvaluateByUser(account.getId());
		model.addAttribute("evaluateList",evaluateList);
		return "modules/front/person/per_evaluate";
	}
	
	/**
	 * 查询个人的某一评论
	 */
	@RequestMapping(value = "specifyEvaluate")
	public String specifyEvaluate(String id,Model model){
		Evaluate evaluate = evaluateService.selOne(id);
		model.addAttribute("evaluate",evaluate);
		return "modules/front/person/per_evaluate_detail";
	}
}
