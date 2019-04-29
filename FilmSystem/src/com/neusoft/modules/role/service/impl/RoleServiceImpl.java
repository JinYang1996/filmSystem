package com.neusoft.modules.role.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.modules.role.mapper.RoleMapper;
import com.neusoft.modules.role.model.Role;
import com.neusoft.modules.role.service.RoleService;

@Service
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	private RoleMapper roleMapper;

	@Override
	public Role get(String id) {
		return roleMapper.get(id);
	}

	@Override
	public List<Role> selAll() {
		return roleMapper.selAll();
	}

}
