package com.neusoft.modules.applyArrange.model;

import java.util.Date;

import com.neusoft.common.model.CommonModel;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;

public class ApplyArrange extends CommonModel{

	private String id;
	
	private FilmDetail filmDetail;
	
	private String applyTime;
	
	private String reviewStatus;
	
	private String hallName;
	
	private Date startTime;
	
	private Date endTime;

	public ApplyArrange(String id, FilmDetail filmDetail, String applyTime,
			String reviewStatus, String hallName, Date startTime, Date endTime) {
		super();
		this.id = id;
		this.filmDetail = filmDetail;
		this.applyTime = applyTime;
		this.reviewStatus = reviewStatus;
		this.hallName = hallName;
		this.startTime = startTime;
		this.endTime = endTime;
	}

	public ApplyArrange() {
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

	public String getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}

	public String getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}

	public String getHallName() {
		return hallName;
	}

	public void setHallName(String hallName) {
		this.hallName = hallName;
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
}
