package com.neusoft.modules.integral.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.integral.model.IntegralInfo;
import com.neusoft.modules.integral.service.IntegralInfoService;

@Controller
@RequestMapping(value = "integralInfo")
public class IntegralInfoController {
	
	@Autowired
	private IntegralInfoService integralInfoService;
	
	@RequestMapping(value = "selIntegral")
	public String selIntegral(Model model,HttpSession session){
		Account account = (Account)session.getAttribute("user");
		List<IntegralInfo> integralList = integralInfoService.selScoreByUser(account.getId());
		model.addAttribute("integralList",integralList);
		return "modules/front/person/per_integral";
	}
}
