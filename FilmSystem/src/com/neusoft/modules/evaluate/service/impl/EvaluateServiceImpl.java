package com.neusoft.modules.evaluate.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.common.page.Page;
import com.neusoft.modules.evaluate.mapper.EvaluateMapper;
import com.neusoft.modules.evaluate.model.Evaluate;
import com.neusoft.modules.evaluate.service.EvaluateService;

@Service
public class EvaluateServiceImpl implements EvaluateService {

	@Autowired
	private EvaluateMapper evaluateMapper;
	
	@Override
	public Evaluate get(String id) {
		return evaluateMapper.get(id);
	}

	@Override
	public List<Evaluate> selAll() {
		return evaluateMapper.selAll();
	}

	@Override
	public void insert(Evaluate t) {
		evaluateMapper.insert(t);
	}

	@Override
	public void update(Evaluate t) {
		evaluateMapper.update(t);
	}

	@Override
	public Page selEvaluateByPage(Evaluate evaluate,int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(5);
		int startRow = page.getStartRow();
		evaluate.setStartRow(startRow);
		evaluate.setPageSize(5);
		List<Evaluate> evaluateList = evaluateMapper.selEvaluateByPage(evaluate);
		page.setData(evaluateList);
		
		int count = evaluateMapper.selEvaluateCount(evaluate);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public void likeEvaluation(int like, String id) {
		evaluateMapper.likeEvaluation(like, id);
	}

	@Override
	public Page selEvaluateByTerm(Evaluate evaluate,int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(5);
		int startRow = page.getStartRow();
		evaluate.setStartRow(startRow);
		evaluate.setPageSize(5);
		List<Evaluate> evaluateList = evaluateMapper.selEvaluateByTerm(evaluate);
		page.setData(evaluateList);
		
		int count = evaluateMapper.selEvaluateCountByTerm(evaluate);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public int selEvaluateCountByTerm(Evaluate evaluate) {
		return evaluateMapper.selEvaluateCountByTerm(evaluate);
	}

	@Override
	public void updReviewStatus(Evaluate evaluate) {
		evaluateMapper.updReviewStatus(evaluate);
	}

	@Override
	public Evaluate selOne(String id) {
		return evaluateMapper.selOne(id);
	}

	@Override
	public List<Evaluate> selEvaluateByUser(String accountId) {
		return evaluateMapper.selEvaluateByUser(accountId);
	}

}
