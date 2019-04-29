package com.neusoft.modules.videoHall.model;

import com.neusoft.common.model.CommonModel;

public class VideoHall extends CommonModel{

	private String id;
	
	private String hallName;//放映名称
	
	private int hallRow;//影厅规格：行
	
	private int hallCol;//影厅规格：列

	public VideoHall() {
		super();
	}

	public VideoHall(String id, String hallName, int hallRow, int hallCol) {
		super();
		this.id = id;
		this.hallName = hallName;
		this.hallRow = hallRow;
		this.hallCol = hallCol;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getHallName() {
		return hallName;
	}

	public void setHallName(String hallName) {
		this.hallName = hallName;
	}

	public int getHallRow() {
		return hallRow;
	}

	public void setHallRow(int hallRow) {
		this.hallRow = hallRow;
	}

	public int getHallCol() {
		return hallCol;
	}

	public void setHallCol(int hallCol) {
		this.hallCol = hallCol;
	}
}
