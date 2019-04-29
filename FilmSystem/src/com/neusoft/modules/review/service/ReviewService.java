package com.neusoft.modules.review.service;

import java.util.List;

import com.neusoft.common.cominterface.CommonService;
import com.neusoft.common.page.Page;
import com.neusoft.modules.review.model.Review;

public interface ReviewService extends CommonService<Review>{

	/**
	 * 根据applyid查找申请信息
	 */
	public Review selReview(String applyId);
	
	/**
	 * 修改del_flag
	 */
	public void updDelFlag(String delFlag,String id);
	
	/**
	 * 根据类型查找审核列表
	 */
	public Page selReviewByType(Review review,int pageNo);
	
	/*
	 * 条件查询的总条数
	 */
	public int selReviewCount(Review review);
	
	/**
	 * 超级管理员根据条件查找审核列表
	 */
	public Page selReviewByTypeSuper(Review review,int pageNo);
	
	/*
	 * 超级管理员条件查询的总条数
	 */
	public int selReviewCountSuper(Review review);
	
	/**
	 * 修改审核装填
	 */
	public void updReviewStatus(String reviewStatus,String id,String updateBy);
	
	/**
	 * 查询所有待审核的总条数 
	 */
	public int selStatusCount();
	
	/**
	 * 修改备注信息
	 */
	public void updRemarks(String remarks,String id);
}
