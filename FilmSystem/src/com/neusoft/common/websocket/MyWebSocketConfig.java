package com.neusoft.common.websocket;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Component
@EnableWebSocket
public class MyWebSocketConfig implements WebSocketConfigurer{

	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry webSocketHandlerRegistry) {
		// TODO Auto-generated method stub
		System.out.println("启动。。。。。。。。。。。");
		webSocketHandlerRegistry.addHandler(new MyWebSocketHandler(), "/echo").addInterceptors(new MyHandShakeInterceptor());
		webSocketHandlerRegistry.addHandler(new MyWebSocketHandler(), "/sockjs/echo").addInterceptors(new MyHandShakeInterceptor()).withSockJS();
	}

}
