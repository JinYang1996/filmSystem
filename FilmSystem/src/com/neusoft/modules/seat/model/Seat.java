package com.neusoft.modules.seat.model;

import com.neusoft.common.model.CommonModel;
import com.neusoft.modules.videoHall.model.VideoHall;

public class Seat extends CommonModel{

	private String id;
	
	private String seatRow;//座位：排
	
	private String seatNumber;//座位：号
	
	private VideoHall videoHall;//放映厅

	public Seat(String id, String seatRow, String seatNumber,
			VideoHall videoHall) {
		super();
		this.id = id;
		this.seatRow = seatRow;
		this.seatNumber = seatNumber;
		this.videoHall = videoHall;
	}

	public Seat() {
		super();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSeatRow() {
		return seatRow;
	}

	public void setSeatRow(String seatRow) {
		this.seatRow = seatRow;
	}

	public String getSeatNumber() {
		return seatNumber;
	}

	public void setSeatNumber(String seatNumber) {
		this.seatNumber = seatNumber;
	}

	public VideoHall getVideoHall() {
		return videoHall;
	}

	public void setVideoHall(VideoHall videoHall) {
		this.videoHall = videoHall;
	}
	
	
}
