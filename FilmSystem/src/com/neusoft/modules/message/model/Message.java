package com.neusoft.modules.message.model;

import java.util.Date;

public class Message {
	private String id;
	
	private String sender;//发送者
	
	private String receiver;//接收者
	
	private String content;//发送的内容
	
	private String isRead;//是否已读
	
	private Date createDate;
	
	private String remarks;
	
	private String delFlag;
	
	private String role;//发表的账号类型

	public Message(String id, String sender, String receiver, String content,
			String isRead, Date createDate, String remarks, String delFlag,
			String role) {
		super();
		this.id = id;
		this.sender = sender;
		this.receiver = receiver;
		this.content = content;
		this.isRead = isRead;
		this.createDate = createDate;
		this.remarks = remarks;
		this.delFlag = delFlag;
		this.role = role;
	}

	public Message() {
		super();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIsRead() {
		return isRead;
	}

	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
}
