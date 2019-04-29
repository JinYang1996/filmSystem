package com.neusoft.modules.theaterArrange.model;

import java.util.Date;

import com.neusoft.common.model.CommonModel;
import com.neusoft.modules.coupon.model.Coupon;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.videoHall.model.VideoHall;

public class TheaterArrange extends CommonModel{

	private String id;
	
	private Date releaseTime;//放映日期   年月日
	
	private Date startTime;//开始时间
	
	private Date endTime;//结束时间
	
	private VideoHall videoHall;//影厅
	
	private Coupon coupon;//优惠券
	
	private FilmDetail filmDetail;//影片
	
	private String isFight;//是否存在拼单

	public TheaterArrange() {
		super();
	}

	public TheaterArrange(String id, Date releaseTime, Date startTime,
			Date endTime, VideoHall videoHall, Coupon coupon,
			FilmDetail filmDetail,String isFight) {
		super();
		this.id = id;
		this.releaseTime = releaseTime;
		this.startTime = startTime;
		this.endTime = endTime;
		this.videoHall = videoHall;
		this.coupon = coupon;
		this.filmDetail = filmDetail;
		this.isFight = isFight;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getReleaseTime() {
		return releaseTime;
	}

	public void setReleaseTime(Date releaseTime) {
		this.releaseTime = releaseTime;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public VideoHall getVideoHall() {
		return videoHall;
	}

	public void setVideoHall(VideoHall videoHall) {
		this.videoHall = videoHall;
	}

	public Coupon getCoupon() {
		return coupon;
	}

	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}

	public FilmDetail getFilmDetail() {
		return filmDetail;
	}

	public void setFilmDetail(FilmDetail filmDetail) {
		this.filmDetail = filmDetail;
	}
	
	public String getIsFight(){
		return isFight;
	}
	
	public void setIsFight(String isFight){
		this.isFight = isFight;
	}
}
