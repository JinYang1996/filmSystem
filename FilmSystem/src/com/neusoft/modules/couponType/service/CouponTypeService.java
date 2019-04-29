package com.neusoft.modules.couponType.service;

import com.neusoft.common.cominterface.CommonService;
import com.neusoft.modules.couponType.model.CouponType;

public interface CouponTypeService extends CommonService<CouponType>{
	
	/**
	 * 根据影片id查找优惠类型名称
	 */
	public CouponType selFilmId(CouponType couponType);
	
	/**
	 * 根据类型名称查询优惠id
	 */
	public String selTypeName(String typeName);
}
