package com.neusoft.modules.integral.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.modules.integral.mapper.IntegralInfoMapper;
import com.neusoft.modules.integral.model.IntegralInfo;
import com.neusoft.modules.integral.service.IntegralInfoService;

@Service
public class IntegralInfoServiceImpl implements IntegralInfoService{

	@Autowired
	private IntegralInfoMapper integralInfoMapper;
	
	@Override
	public IntegralInfo get(String id) {
		return integralInfoMapper.get(id);
	}

	@Override
	public List<IntegralInfo> selAll() {
		return integralInfoMapper.selAll();
	}

	@Override
	public void insert(IntegralInfo t) {
		integralInfoMapper.insert(t);
	}

	@Override
	public void update(IntegralInfo t) {
		integralInfoMapper.update(t);
	}

	@Override
	public List<IntegralInfo> selScoreByUser(String accountId) {
		return integralInfoMapper.selScoreByUser(accountId);
	}

}
