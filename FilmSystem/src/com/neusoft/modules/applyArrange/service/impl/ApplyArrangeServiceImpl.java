package com.neusoft.modules.applyArrange.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.common.page.Page;
import com.neusoft.modules.applyArrange.mapper.ApplyArrangeMapper;
import com.neusoft.modules.applyArrange.model.ApplyArrange;
import com.neusoft.modules.applyArrange.service.ApplyArrangeService;

@Service
public class ApplyArrangeServiceImpl implements ApplyArrangeService {

	@Autowired
	private ApplyArrangeMapper applyArrangeMapper;
	
	@Override
	public ApplyArrange get(String id) {
		return applyArrangeMapper.get(id);
	}

	@Override
	public List<ApplyArrange> selAll() {
		return applyArrangeMapper.selAll();
	}

	@Override
	public void insert(ApplyArrange t) {
		applyArrangeMapper.insert(t);
	}

	@Override
	public void update(ApplyArrange t) {
		applyArrangeMapper.update(t);
	}

	@Override
	public List<ApplyArrange> selApplyByFilmId(String filmId, Date applyTime) {
		return applyArrangeMapper.selApplyByFilmId(filmId, applyTime);
	}

	@Override
	public void updReviewStatus(String reviewStatus, String id) {
		applyArrangeMapper.updReviewStatus(reviewStatus, id);
	}

	@Override
	public Page selApplyByTerm(ApplyArrange applyArrange,int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		int startRow = page.getStartRow();
		applyArrange.setStartRow(startRow);
		applyArrange.setPageSize(page.getPageSize());
		List<ApplyArrange> applyArrangeList = applyArrangeMapper.selApplyByTerm(applyArrange);;
		page.setData(applyArrangeList);
		
		int count = applyArrangeMapper.selApplyByTermCount(applyArrange);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public List<ApplyArrange> selApplyByTime(ApplyArrange applyArrange) {
		return applyArrangeMapper.selApplyByTime(applyArrange);
	}

	@Override
	public List<ApplyArrange> selBeforeToday() {
		return applyArrangeMapper.selBeforeToday();
	}

	@Override
	public void updateDelFlag(ApplyArrange applyArrange) {
		applyArrangeMapper.updateDelFlag(applyArrange);
	}

	@Override
	public void updRemarks(String remarks, String id) {
		applyArrangeMapper.updRemarks(remarks, id);
	}

	@Override
	public List<ApplyArrange> selApplyByUser(String createBy) {
		return applyArrangeMapper.selApplyByUser(createBy);
	}

	@Override
	public List<ApplyArrange> selApplyByUserAndFilmId(String createBy,
			String filmId) {
		return applyArrangeMapper.selApplyByUserAndFilmId(createBy,filmId);
	}

	@Override
	public Page selApplyByTermSuper(ApplyArrange applyArrange,int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		int startRow = page.getStartRow();
		applyArrange.setStartRow(startRow);
		applyArrange.setPageSize(page.getPageSize());
		List<ApplyArrange> applyArrangeList = applyArrangeMapper.selApplyByTermSuper(applyArrange);;
		page.setData(applyArrangeList);
		
		int count = applyArrangeMapper.selApplyByTermCountSuper(applyArrange);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public int selApplyByTermCountSuper(ApplyArrange applyArrange) {
		return applyArrangeMapper.selApplyByTermCountSuper(applyArrange);
	}

}
