package com.neusoft.modules.review.model;

import com.neusoft.common.model.CommonModel;
import com.neusoft.modules.front.fightTicket.model.FightTicket;

public class Review extends CommonModel{

	private String id;
	
	private FightTicket fightTicket;//申请id
	
	private String type;//申请信息的类型
	
	private String reviewStatus;//审核状态
	
	private String sumPer;//此条订单的参与率

	public Review(String id, FightTicket fightTicket, String type,
			String reviewStatus, String sumPer) {
		super();
		this.id = id;
		this.fightTicket = fightTicket;
		this.type = type;
		this.reviewStatus = reviewStatus;
		this.sumPer = sumPer;
	}

	public Review() {
		super();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public FightTicket getFightTicket() {
		return fightTicket;
	}

	public void setFightTicket(FightTicket fightTicket) {
		this.fightTicket = fightTicket;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}

	public String getSumPer() {
		return sumPer;
	}

	public void setSumPer(String sumPer) {
		this.sumPer = sumPer;
	}
	
}
