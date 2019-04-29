package com.neusoft.modules.coupon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.common.page.Page;
import com.neusoft.modules.coupon.mapper.CouponMapper;
import com.neusoft.modules.coupon.model.Coupon;
import com.neusoft.modules.coupon.service.CouponService;

@Service
public class CouponServiceImpl implements CouponService {

	@Autowired
	private CouponMapper couponMapper;
	
	@Override
	public Coupon get(String id) {
		return couponMapper.get(id);
	}

	@Override
	public List<Coupon> selAll() {
		return couponMapper.selAll();
	}

	@Override
	public void insert(Coupon t) {
		couponMapper.insert(t);
	}

	@Override
	public void update(Coupon t) {
		couponMapper.update(t);
	}

	@Override
	public Coupon selType(String type) {
		return couponMapper.selType(type);
	}

	@Override
	public Coupon selFilmId(Coupon coupon) {
		return couponMapper.selFilmId(coupon);
	}

	@Override
	public List<Coupon> selCouponByTerm(Coupon coupon) {
		return couponMapper.selCouponByTerm(coupon);
	}

	@Override
	public void updDelFlag(String delFlag,String id) {
		couponMapper.updDelFlag(delFlag,id);
	}

	@Override
	public Page selByTerm(Coupon coupon,int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		int startRow = page.getStartRow();
		coupon.setStartRow(startRow);
		coupon.setPageSize(page.getPageSize());
		List<Coupon> couponList = couponMapper.selByTerm(coupon);
		page.setData(couponList);
		
		int count = couponMapper.selByTermCount(coupon);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public int selByTermCount(Coupon coupon) {
		return couponMapper.selByTermCount(coupon);
	}

}
