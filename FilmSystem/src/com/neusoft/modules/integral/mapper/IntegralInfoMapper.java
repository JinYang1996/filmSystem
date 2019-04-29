package com.neusoft.modules.integral.mapper;

import java.util.List;

import com.neusoft.common.cominterface.CommonInterface;
import com.neusoft.modules.integral.model.IntegralInfo;

public interface IntegralInfoMapper extends CommonInterface<IntegralInfo>{

	/**
	 * 查看个人积分使用情况
	 */
	public List<IntegralInfo> selScoreByUser(String accountId);
}
