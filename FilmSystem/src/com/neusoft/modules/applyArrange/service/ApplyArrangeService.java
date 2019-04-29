package com.neusoft.modules.applyArrange.service;

import java.util.Date;
import java.util.List;

import com.neusoft.common.cominterface.CommonService;
import com.neusoft.common.page.Page;
import com.neusoft.modules.applyArrange.model.ApplyArrange;

public interface ApplyArrangeService extends CommonService<ApplyArrange>{

	/**
	 * 根据影片id和申请日期查询未审核申请安排列表
	 */
	public List<ApplyArrange> selApplyByFilmId(String filmId,Date applyTime);
	
	/**
	 * 修改审核状态
	 */
	public void updReviewStatus(String reviewStatus,String id);
	
	/**
	 * 条件查询
	 */
	public Page selApplyByTerm(ApplyArrange applyArrange,int pageNo);
	
	/**
	 * 根据申请日期查询申请信息
	 */
	public List<ApplyArrange> selApplyByTime(ApplyArrange applyArrange);
	
	/**
	 *  将今天以前没有审核的影厅安排申请清除 
	 */
	public List<ApplyArrange> selBeforeToday();
	
	/**
	 * 将申请删除
	 */
	public void updateDelFlag(ApplyArrange applyArrange);
	
	/**
	 * 修改备注信息
	 */
	public void updRemarks(String remarks,String id);
	
	/**
	 * 查询指定用户下的申请
	 */
	public List<ApplyArrange> selApplyByUser(String createBy);
	
	/**
	 * 查询所有申请
	 */
	public List<ApplyArrange> selApplyByUserAndFilmId(String createBy,String filmId);
	
	/**
	 * 超级管理员条件查询
	 */
	public Page selApplyByTermSuper(ApplyArrange applyArrange,int pageNo);
	
	/**
	 * 超级管理员条件查询数量
	 */
	public int selApplyByTermCountSuper(ApplyArrange applyArrange);
}
