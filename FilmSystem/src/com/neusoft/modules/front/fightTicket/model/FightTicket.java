package com.neusoft.modules.front.fightTicket.model;

import com.neusoft.common.model.CommonModel;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.theaterArrange.model.TheaterArrange;

public class FightTicket extends CommonModel{

	private String id;
	
	private String beforeOrder;
	
	private String fightPeople;//拼单发起人
	
	private FilmDetail filmDetail;//电影信息
	
	private TheaterArrange theaterArrange;//影院安排信息
	
	private String seatIds;
	
	private String type;//订单类型
	
	private String fightStatus;//发起状态
	
	private double price;//实付钱数
	
	private double originalPrice;//原价
	
	private int ticketCount;//票数
	
	private int usedScore;//使用积分
	
	private String favorable;//优惠信息
	
	private String payStatus;//支付状态
	
	private String reviewStatus;//审核状态
	
	private String watchStatus;//观看状态
	
	private String watchCode;//观影码
	
	private String finalType;//订单最终状态

	public FightTicket(String id, String beforeOrder, String fightPeople,
			FilmDetail filmDetail, TheaterArrange theaterArrange,
			String seatIds, String type, String fightStatus, double price,
			double originalPrice, int ticketCount, int usedScore,
			String favorable, String payStatus, String reviewStatus,
			String watchStatus, String watchCode, String finalType) {
		super();
		this.id = id;
		this.beforeOrder = beforeOrder;
		this.fightPeople = fightPeople;
		this.filmDetail = filmDetail;
		this.theaterArrange = theaterArrange;
		this.seatIds = seatIds;
		this.type = type;
		this.fightStatus = fightStatus;
		this.price = price;
		this.originalPrice = originalPrice;
		this.ticketCount = ticketCount;
		this.usedScore = usedScore;
		this.favorable = favorable;
		this.payStatus = payStatus;
		this.reviewStatus = reviewStatus;
		this.watchStatus = watchStatus;
		this.watchCode = watchCode;
		this.finalType = finalType;
	}

	public FightTicket() {
		super();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBeforeOrder() {
		return beforeOrder;
	}

	public void setBeforeOrder(String beforeOrder) {
		this.beforeOrder = beforeOrder;
	}

	public String getFightPeople() {
		return fightPeople;
	}

	public void setFightPeople(String fightPeople) {
		this.fightPeople = fightPeople;
	}

	public FilmDetail getFilmDetail() {
		return filmDetail;
	}

	public void setFilmDetail(FilmDetail filmDetail) {
		this.filmDetail = filmDetail;
	}

	public TheaterArrange getTheaterArrange() {
		return theaterArrange;
	}

	public void setTheaterArrange(TheaterArrange theaterArrange) {
		this.theaterArrange = theaterArrange;
	}

	public String getSeatIds() {
		return seatIds;
	}

	public void setSeatIds(String seatIds) {
		this.seatIds = seatIds;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFightStatus() {
		return fightStatus;
	}

	public void setFightStatus(String fightStatus) {
		this.fightStatus = fightStatus;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getOriginalPrice() {
		return originalPrice;
	}

	public void setOriginalPrice(double originalPrice) {
		this.originalPrice = originalPrice;
	}

	public int getTicketCount() {
		return ticketCount;
	}

	public void setTicketCount(int ticketCount) {
		this.ticketCount = ticketCount;
	}

	public int getUsedScore() {
		return usedScore;
	}

	public void setUsedScore(int usedScore) {
		this.usedScore = usedScore;
	}

	public String getFavorable() {
		return favorable;
	}

	public void setFavorable(String favorable) {
		this.favorable = favorable;
	}

	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public String getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}

	public String getWatchStatus() {
		return watchStatus;
	}

	public void setWatchStatus(String watchStatus) {
		this.watchStatus = watchStatus;
	}

	public String getWatchCode() {
		return watchCode;
	}

	public void setWatchCode(String watchCode) {
		this.watchCode = watchCode;
	}

	public String getFinalType() {
		return finalType;
	}

	public void setFinalType(String finalType) {
		this.finalType = finalType;
	}
}
