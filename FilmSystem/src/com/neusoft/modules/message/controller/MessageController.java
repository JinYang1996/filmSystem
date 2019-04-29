package com.neusoft.modules.message.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.account.service.AccountService;
import com.neusoft.modules.message.model.Message;
import com.neusoft.modules.message.service.MessageService;

@Controller
@RequestMapping(value = "message")
public class MessageController {

	@Autowired
	private MessageService messageService;
	
	@Autowired
	private AccountService accountService;
	
	@ResponseBody
	@RequestMapping("sendMessage")
	public String sendMessage(@RequestParam("roleName")String roleName,@RequestParam("content")String content){
		String flag = "";
		
		Message message = new Message();
		message.setSender(roleName);
		message.setContent(content);
		message.setId(UUID.randomUUID().toString().replace("-", ""));
		messageService.insert(message);
		flag = "1";//添加成功
		/*if(account.getRole().getId().equals("1")){//用户发送消息给管理员
			List<Account> accountList = accountService.selAdmin();
			for(Account a : accountList){
				String adminName = a.getUserName();
				
			}
		}else{//管理员
			
		}*/
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value = "selAllMessage")
	public List<Message> selAllMessage(){
		List<Message> messageList = messageService.selAll();
		List<Message> mList = new ArrayList<Message>();
		if(messageList != null){
			for(Message m : messageList){
				Account account = accountService.selAccoutByUserName(m.getSender());
				m.setRole(account.getRole().getId());
				mList.add(m);
			}
		}
		return mList;
	}
	
	/*@ResponseBody
	@RequestMapping(value = "selRole")
	public String selRole(String userName){
		Account account = accountService.selAccoutByUserName(userName);
		return account.getRole().getId();
	}*/
}
