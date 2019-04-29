package com.neusoft.modules.role.model;

public class Role {
	private String id;
	
	private String roleName;//权限名
	
	private String delFlag;

	public Role(String id, String roleName, String delFlag) {
		super();
		this.id = id;
		this.roleName = roleName;
		this.delFlag = delFlag;
	}

	public Role() {
		super();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	
}
