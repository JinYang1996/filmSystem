package com.neusoft.modules.couponType.model;

import com.neusoft.modules.front.filmDetail.model.FilmDetail;

public class CouponType {

	private String id;
	
	private String typeName;
	
	private FilmDetail filmDetail;
	
	private String delFlag;

	public CouponType(String id, String typeName, FilmDetail filmDetail,
			String delFlag) {
		super();
		this.id = id;
		this.typeName = typeName;
		this.filmDetail = filmDetail;
		this.delFlag = delFlag;
	}

	public CouponType() {
		super();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public FilmDetail getFilmDetail() {
		return filmDetail;
	}

	public void setFilmDetail(FilmDetail filmDetail) {
		this.filmDetail = filmDetail;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	
}
