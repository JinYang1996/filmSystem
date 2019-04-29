package com.neusoft.common.websocket;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import com.neusoft.modules.account.model.Account;

public class MyHandShakeInterceptor implements HandshakeInterceptor{

	private static List<String> names = new ArrayList<String>();
	private static Messages message = new Messages();
	
	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
			WebSocketHandler handler, Exception exception) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean beforeHandshake(ServerHttpRequest request,
			ServerHttpResponse response, WebSocketHandler handler,
			Map<String, Object> map) throws Exception {
		System.out.println("握手前。。。。。。。。。");
		if(request instanceof ServletServerHttpRequest){
			HttpSession session = ((ServletServerHttpRequest)request).getServletRequest().getSession(true);
			if(session!=null){
				String userName = (String) session.getAttribute("userName");
				String roleId = (String)session.getAttribute("roleId");
				map.put("webSocket_username", userName);
				map.put("roleId", roleId);
			}
		}
		return true;
	}

}
