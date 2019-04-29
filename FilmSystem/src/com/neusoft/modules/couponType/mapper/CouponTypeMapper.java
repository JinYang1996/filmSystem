package com.neusoft.modules.couponType.mapper;

import com.neusoft.common.cominterface.CommonInterface;
import com.neusoft.modules.couponType.model.CouponType;

public interface CouponTypeMapper extends CommonInterface<CouponType>{

	/**
	 * 根据影片id查找优惠类型名称
	 */
	public CouponType selFilmId(CouponType couponType);
	
	/**
	 * 根据类型名称查询优惠id
	 */
	public String selTypeName(String typeName);
}
