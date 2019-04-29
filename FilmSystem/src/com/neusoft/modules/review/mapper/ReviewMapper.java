package com.neusoft.modules.review.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.neusoft.common.cominterface.CommonInterface;
import com.neusoft.modules.review.model.Review;

public interface ReviewMapper extends CommonInterface<Review>{

	/**
	 * 根据applyid查找申请信息
	 */
	public Review selReview(String applyId);
	
	/**
	 * 修改del_flag
	 */
	public void updDelFlag(@Param("delFlag")String delFlag,@Param("id")String id);
	
	/**
	 * 根据类型查找审核列表
	 */
	public List<Review> selReviewByType(Review review);
	
	/*
	 * 条件查询的总条数
	 */
	public int selReviewCount(Review review);
	
	/**
	 * 超级管理员根据条件查找审核列表
	 */
	public List<Review> selReviewByTypeSuper(Review review);
	
	/*
	 * 超级管理员条件查询的总条数
	 */
	public int selReviewCountSuper(Review review);
	
	
	/**
	 * 修改审核装填
	 */
	public void updReviewStatus(String reviewStatus,String id ,String updateBy);
	
	/**
	 * 查询所有待审核的总条数 
	 */
	public int selStatusCount();
	
	/**
	 * 修改备注信息
	 */
	public void updRemarks(String remarks,String id);
}
