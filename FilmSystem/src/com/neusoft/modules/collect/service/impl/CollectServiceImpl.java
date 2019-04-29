package com.neusoft.modules.collect.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.modules.collect.mapper.CollectMapper;
import com.neusoft.modules.collect.model.Collect;
import com.neusoft.modules.collect.service.CollectService;

@Service
public class CollectServiceImpl implements CollectService{

	@Autowired
	private CollectMapper collectMapper;
	
	@Override
	public Collect get(String id) {
		// TODO Auto-generated method stub
		return collectMapper.get(id);
	}

	@Override
	public List<Collect> selAll() {
		// TODO Auto-generated method stub
		return collectMapper.selAll();
	}

	@Override
	public void insert(Collect t) {
		// TODO Auto-generated method stub
		collectMapper.insert(t);
	}

	@Override
	public void update(Collect t) {
		// TODO Auto-generated method stub
		collectMapper.update(t);
	}

	@Override
	public Collect selByFilmAccount(String filmId, String accountId) {
		// TODO Auto-generated method stub
		return collectMapper.selByFilmAccount(filmId, accountId);
	}

	@Override
	public List<Collect> selByAccount(String accountId) {
		// TODO Auto-generated method stub
		return collectMapper.selByAccount(accountId);
	}

	@Override
	public void updDelFlag(String delFlag, String id) {
		// TODO Auto-generated method stub
		collectMapper.updDelFlag(delFlag, id);
	}

}
