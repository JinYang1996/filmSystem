package com.neusoft.common.websocket;

import java.util.Date;
import java.util.List;

import com.google.gson.Gson;

public class Messages {

	private String welcome;
	
	private List<String> usernames;
	
	private String content;

	public Messages(String welcome, List<String> usernames) {
		super();
		this.welcome = welcome;
		this.usernames = usernames;
	}

	public Messages() {
		super();
	}

	public String getWelcome() {
		return welcome;
	}

	public void setWelcome(String welcome) {
		this.welcome = welcome;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String name,String msg) {
		this.content = name+" "+new Date().toLocaleString()+" :</br>"
						+msg+"</br>";
	}

	public List<String> getUsernames() {
		return usernames;
	}

	public void setUsernames(List<String> usernames) {
		this.usernames = usernames;
	}
	
	public String getGson(){
		return gson.toJson(this);
	}
	
	private static Gson gson = new Gson();
}
