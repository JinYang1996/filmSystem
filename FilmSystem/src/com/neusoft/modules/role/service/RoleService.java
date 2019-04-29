package com.neusoft.modules.role.service;

import java.util.List;

import com.neusoft.modules.role.model.Role;

public interface RoleService {

	/*
	 * 查询单条
	 */
	public Role get(String id);
	
	/*
	 * 查询所有
	 */
	public List<Role> selAll();
}
