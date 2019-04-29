package com.neusoft.modules.coupon.model;

import com.neusoft.common.model.CommonModel;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;

public class Coupon extends CommonModel{

	private String id;
	
	private String couponName;
	
	private double couponPrice;
	
	private String type;//优惠类型 0：通用  1：专用
	
	private FilmDetail filmDetail;//影片

	public Coupon(String id, String couponName, double couponPrice,
			String type, FilmDetail filmDetail) {
		super();
		this.id = id;
		this.couponName = couponName;
		this.couponPrice = couponPrice;
		this.type = type;
		this.filmDetail = filmDetail;
	}

	public Coupon() {
		super();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public double getCouponPrice() {
		return couponPrice;
	}

	public void setCouponPrice(double couponPrice) {
		this.couponPrice = couponPrice;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public FilmDetail getFilmDetail() {
		return filmDetail;
	}

	public void setFilmDetail(FilmDetail filmDetail) {
		this.filmDetail = filmDetail;
	}
}
