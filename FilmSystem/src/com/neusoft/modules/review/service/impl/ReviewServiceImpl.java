package com.neusoft.modules.review.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.common.page.Page;
import com.neusoft.modules.review.mapper.ReviewMapper;
import com.neusoft.modules.review.model.Review;
import com.neusoft.modules.review.service.ReviewService;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewMapper reviewMapper;
	
	@Override
	public Review get(String id) {
		return reviewMapper.get(id);
	}

	@Override
	public List<Review> selAll() {
		return reviewMapper.selAll();
	}

	@Override
	public void insert(Review t) {
		reviewMapper.insert(t);
	}

	@Override
	public void update(Review t) {
		reviewMapper.update(t);
	}

	@Override
	public Review selReview(String applyId) {
		return reviewMapper.selReview(applyId);
	}

	@Override
	public void updDelFlag(String delFlag, String id) {
		reviewMapper.updDelFlag(delFlag, id);
	}

	@Override
	public Page selReviewByType(Review review,int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		int startRow = page.getStartRow();
		review.setStartRow(startRow);
		review.setPageSize(page.getPageSize());
		List<Review> reviewList = reviewMapper.selReviewByType(review);
		page.setData(reviewList);
		
		int count = reviewMapper.selReviewCount(review);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public int selReviewCount(Review review) {
		return reviewMapper.selReviewCount(review);
	}

	@Override
	public void updReviewStatus(String reviewStatus, String id,String updateBy) {
		reviewMapper.updReviewStatus(reviewStatus, id,updateBy);
	}

	@Override
	public int selStatusCount() {
		return reviewMapper.selStatusCount();
	}

	@Override
	public void updRemarks(String remarks, String id) {
		reviewMapper.updRemarks(remarks, id);
	}

	@Override
	public Page selReviewByTypeSuper(Review review, int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		int startRow = page.getStartRow();
		review.setStartRow(startRow);
		review.setPageSize(page.getPageSize());
		List<Review> reviewList = reviewMapper.selReviewByTypeSuper(review);
		page.setData(reviewList);
		
		int count = reviewMapper.selReviewCountSuper(review);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public int selReviewCountSuper(Review review) {
		return reviewMapper.selReviewCount(review);
	}

}
