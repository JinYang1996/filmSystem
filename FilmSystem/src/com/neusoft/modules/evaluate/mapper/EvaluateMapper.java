package com.neusoft.modules.evaluate.mapper;

import java.util.List;

import com.neusoft.common.cominterface.CommonInterface;
import com.neusoft.modules.evaluate.model.Evaluate;

public interface EvaluateMapper extends CommonInterface<Evaluate>{

	/**
	 * 分页查询评论列表
	 */
	public List<Evaluate> selEvaluateByPage(Evaluate evaluate);
	
	/**
	 * 查询评论总条数
	 */
	public int selEvaluateCount(Evaluate evaluate);
	
	/**
	 * 为评论点赞
	 */
	public void likeEvaluation(int like,String id);
	
	/**
	 * 根据条件查询评论
	 */
	public List<Evaluate> selEvaluateByTerm(Evaluate evaluate);
	
	/**
	 * 根据条件查询评论数量
	 */
	public int selEvaluateCountByTerm(Evaluate evaluate);
	
	/**
	 * 修改审核状态
	 */
	public void updReviewStatus(Evaluate evaluate);
	
	/**
	 * 查找评论
	 */
	public Evaluate selOne(String id);
	
	/**
	 * 查找用户下的所有评论信息
	 */
	public List<Evaluate> selEvaluateByUser(String accountId);
}
