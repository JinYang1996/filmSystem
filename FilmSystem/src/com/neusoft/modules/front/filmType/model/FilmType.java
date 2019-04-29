package com.neusoft.modules.front.filmType.model;

public class FilmType {

	public String id;
	
	public String typeName;//类型名称
	
	public String delFlag;//作废标记

	public FilmType(String id, String typeName, String delFlag) {
		super();
		this.id = id;
		this.typeName = typeName;
		this.delFlag = delFlag;
	}

	public FilmType() {
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

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	
}
