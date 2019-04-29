package com.neusoft.common.websocket;

import java.io.EOFException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class MyWebSocketHandler implements WebSocketHandler{
	
	
	@Autowired
	private ObjectMapper objectMapper;
	
	/*private static Gson gson = new Gson();*/
	private static List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus arg1)
			throws EOFException {
		String username = (String) session.getAttributes().get("webSocket_username");
		TextMessage msg = new TextMessage("欢送:"+username+"离开本聊天室</br>");
		sessions.remove(session);
		sendMessageToUser(sessions, msg);
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session)
			throws Exception {
		System.out.println("握手成功"+session.getId());
		sessions.add(session);
		System.out.println("当前在线人数:"+sessions.size());
		/*Map<String,Object> map = session.getAttributes();
		for(Map.Entry<String, Object> entry:map.entrySet()){
			System.out.println(entry.getKey()+"   "+entry.getValue());
			
		}
		session.sendMessage(new TextMessage(gson.toJson(map)));*/
		String username = (String) session.getAttributes().get("webSocket_username");
		TextMessage msg = new TextMessage("欢迎:"+username+"登陆本聊天室</br>");
		sendMessageToUser(sessions,msg);
	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> webSocketMessage)
			throws Exception {
		String username = (String) session.getAttributes().get("webSocket_username");
		String roleId = (String) session.getAttributes().get("roleId");
		System.out.println(roleId);
		System.out.println(webSocketMessage.getPayloadLength());
		String m = (String) webSocketMessage.getPayload().toString();
		
		TextMessage msg = null;
		if(roleId.equals("1")){
			msg = new TextMessage("用 户 "+username+" 说:"+m+"</br>");
		}else{
			msg = new TextMessage("管理员 "+username+" 说:"+m+"</br>");
		}
		
		sendMessageToUser(sessions, msg);
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable arg1)
			throws Exception {
		sessions.remove(session);
		System.out.println("运输错误");
	}

	@Override
	public boolean supportsPartialMessages() {
		// TODO Auto-generated method stub
		return false;
	}

	public void sendMessageToUser(List<WebSocketSession> websessions,WebSocketMessage<?> msg){
		for(WebSocketSession session :websessions){
			try {
				if(session.isOpen()){
					session.sendMessage(msg);
				}
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
