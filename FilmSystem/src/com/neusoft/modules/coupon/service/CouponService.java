package com.neusoft.modules.coupon.service;

import java.util.List;

import com.neusoft.common.cominterface.CommonService;
import com.neusoft.common.page.Page;
import com.neusoft.modules.coupon.model.Coupon;

public interface CouponService extends CommonService<Coupon>{

	/**
	 * 根据优惠券类型id查找优惠信息
	 */
	public Coupon selType(String type);
	
	/**
	 * 根据影片id查找优惠类型名称
	 */
	public Coupon selFilmId(Coupon coupon);
	
	/**
	 * 查询优惠信息
	 */
	public List<Coupon> selCouponByTerm(Coupon coupon);
	
	/**
	 * 修改delFlag的值
	 */
	public void updDelFlag(String delFlag,String id);
	
	/**
	 * 分页查询
	 */
	public Page selByTerm(Coupon coupon,int pageNo);
	
	/**
	 * 分页查询数量
	 */
	public int selByTermCount(Coupon coupon);
}
