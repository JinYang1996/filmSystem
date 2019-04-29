package com.neusoft.modules.role.mapper;

import java.util.List;

import com.neusoft.modules.role.model.Role;

public interface RoleMapper {
	
	/*
	 * 查询单条
	 */
	public Role get(String id);
	
	/*
	 * 查询所有
	 */
	public List<Role> selAll();
	
}
