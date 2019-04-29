package com.neusoft.modules.couponType.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.modules.couponType.mapper.CouponTypeMapper;
import com.neusoft.modules.couponType.model.CouponType;
import com.neusoft.modules.couponType.service.CouponTypeService;

@Service
public class CouponTypeServiceImpl implements CouponTypeService{

	@Autowired
	private CouponTypeMapper couponTypeMapper;
	
	@Override
	public CouponType get(String id) {
		// TODO Auto-generated method stub
		return couponTypeMapper.get(id);
	}

	@Override
	public List<CouponType> selAll() {
		// TODO Auto-generated method stub
		return couponTypeMapper.selAll();
	}

	@Override
	public void insert(CouponType t) {
		// TODO Auto-generated method stub
		couponTypeMapper.insert(t);	
	}

	@Override
	public void update(CouponType t) {
		// TODO Auto-generated method stub
		couponTypeMapper.update(t);
	}

	@Override
	public CouponType selFilmId(CouponType couponType) {
		// TODO Auto-generated method stub
		return couponTypeMapper.selFilmId(couponType);
	}

	@Override
	public String selTypeName(String typeName) {
		// TODO Auto-generated method stub
		return couponTypeMapper.selTypeName(typeName);
	}

}
