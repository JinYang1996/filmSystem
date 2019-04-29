package com.neusoft.modules.message.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.modules.message.mapper.MessageMapper;
import com.neusoft.modules.message.model.Message;
import com.neusoft.modules.message.service.MessageService;

@Service
public class MessageServiceImpl implements MessageService {

	@Autowired
	private MessageMapper messageMapper;
	
	@Override
	public Message get(String id) {
		return messageMapper.get(id);
	}

	@Override
	public List<Message> selAll() {
		return messageMapper.selAll();
	}

	@Override
	public void insert(Message t) {
		messageMapper.insert(t);
	}

	@Override
	public void update(Message t) {
		messageMapper.update(t);
	}

	
}
