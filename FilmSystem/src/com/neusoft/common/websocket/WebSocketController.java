package com.neusoft.common.websocket;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/webSocket")
public class WebSocketController {
	
	@RequestMapping(value="toChart")
	public String toChart(String username,HttpSession session){
		session.setAttribute("username", username);
		return "modules/websocket/chart";
	}
}
