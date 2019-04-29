package com.neusoft.modules.collect.model;

import java.util.Date;

import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;

public class Collect {
	
	private String id;
	
	private FilmDetail filmDetail;
	
	private Account account;
	
	private Date collectTime;//收藏时间
	
	private String delFlag;//作废标记

	public Collect(String id, FilmDetail filmDetail, Account account,
			Date collectTime, String delFlag) {
		super();
		this.id = id;
		this.filmDetail = filmDetail;
		this.account = account;
		this.collectTime = collectTime;
		this.delFlag = delFlag;
	}

	public Collect() {
		super();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public FilmDetail getFilmDetail() {
		return filmDetail;
	}

	public void setFilmDetail(FilmDetail filmDetail) {
		this.filmDetail = filmDetail;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public Date getCollectTime() {
		return collectTime;
	}

	public void setCollectTime(Date collectTime) {
		this.collectTime = collectTime;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
}
