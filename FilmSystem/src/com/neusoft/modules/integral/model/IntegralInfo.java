package com.neusoft.modules.integral.model;

import java.util.Date;

import com.neusoft.modules.account.model.Account;

public class IntegralInfo {
	
	private String id;
	
	private Account account;//账号信息
	
	private String integralSource;//积分来源
	
	private int score;//获得的积分数
	
	private Date achieveTime;//获得时间
	
	private String delFlag;//作废标记

	public IntegralInfo(String id, Account account, String integralSource,
			int score, Date achieveTime, String delFlag) {
		super();
		this.id = id;
		this.account = account;
		this.integralSource = integralSource;
		this.score = score;
		this.achieveTime = achieveTime;
		this.delFlag = delFlag;
	}

	public IntegralInfo() {
		super();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public String getIntegralSource() {
		return integralSource;
	}

	public void setIntegralSource(String integralSource) {
		this.integralSource = integralSource;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public Date getAchieveTime() {
		return achieveTime;
	}

	public void setAchieveTime(Date achieveTime) {
		this.achieveTime = achieveTime;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
}
