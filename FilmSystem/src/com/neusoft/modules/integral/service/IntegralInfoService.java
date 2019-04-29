package com.neusoft.modules.integral.service;

import java.util.List;

import com.neusoft.common.cominterface.CommonService;
import com.neusoft.modules.integral.model.IntegralInfo;

public interface IntegralInfoService extends CommonService<IntegralInfo>{

	/**
	 * 查看个人积分使用情况
	 */
	public List<IntegralInfo> selScoreByUser(String accountId);
}
