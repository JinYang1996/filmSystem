package com.neusoft.modules.evaluate.model;

import com.neusoft.common.model.CommonModel;
import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;

public class Evaluate extends CommonModel{

	private String id;
	
	private FilmDetail filmDetail;//影片
	
	private Account account;//账号
	
	private String content;//评论内容
	
	private String reviewStatus;//审核状态
	
	private int likes;//点赞数

	public Evaluate(String id, FilmDetail filmDetail, Account account,
			String content, String reviewStatus, int likes) {
		super();
		this.id = id;
		this.filmDetail = filmDetail;
		this.account = account;
		this.content = content;
		this.reviewStatus = reviewStatus;
		this.likes = likes;
	}

	public Evaluate() {
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}
	
}
