package com.neusoft.modules.theaterArrange.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.common.page.Page;
import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.applyArrange.mapper.ApplyArrangeMapper;
import com.neusoft.modules.applyArrange.model.ApplyArrange;
import com.neusoft.modules.front.filmDetail.mapper.FilmDetailMapper;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.theaterArrange.mapper.TheaterArrangeMapper;
import com.neusoft.modules.theaterArrange.model.TheaterArrange;
import com.neusoft.modules.theaterArrange.service.TheaterArrangeService;

@Service
public class TheaterArrangeServiceImpl implements TheaterArrangeService{

	@Autowired
	private TheaterArrangeMapper theaterArrangeMapper;
	
	@Autowired
	private FilmDetailMapper filmDetailMapper;
	
	@Autowired
	private ApplyArrangeMapper applyArrangeMapper;
	
	@Override
	public TheaterArrange get(String id) {
		return theaterArrangeMapper.get(id);
	}

	@Override
	public List<TheaterArrange> selAll() {
		return theaterArrangeMapper.selAll();
	}

	@Override
	public void insert(TheaterArrange t) {
		theaterArrangeMapper.insert(t);
	}

	@Override
	public void update(TheaterArrange t) {
		theaterArrangeMapper.update(t);
	}

	@Override
	public List<TheaterArrange> selByHallId(TheaterArrange theaterArrange) {
		return theaterArrangeMapper.selByHallId(theaterArrange);
	}

	@Override
	public List<TheaterArrange> selByFilmId(String filmId,String releaseDate) {
		return theaterArrangeMapper.selByFilmId(filmId,releaseDate);
	}

	@Override
	public void delArrange(String arrangeId) {
		theaterArrangeMapper.delArrange(arrangeId);
	}

	@Override
	public void updBeforeToday(String remarks) {
		// TODO Auto-generated method stub
		theaterArrangeMapper.updBeforeToday(remarks);
	}

	@Override
	public Page selArrangeByTerm(TheaterArrange theaterArrange,int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		int startRow = page.getStartRow();
		theaterArrange.setStartRow(startRow);
		theaterArrange.setPageSize(page.getPageSize());
		List<TheaterArrange> arrangeList = theaterArrangeMapper.selArrangeByTerm(theaterArrange);;
		page.setData(arrangeList);
		
		int count = theaterArrangeMapper.selTermCount(theaterArrange);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public int selTermCount(TheaterArrange theaterArrange) {
		// TODO Auto-generated method stub
		return theaterArrangeMapper.selTermCount(theaterArrange);
	}

	/**
	 * 新增影厅安排
	 */
	public void addTheater(TheaterArrange theaterArrange,String filmTime,Account account){
		String releaseTime = filmTime.substring(0,10);
		String startTime = filmTime.substring(11);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		
		//获取选中的电影时长，并计算结束时间
		FilmDetail film = filmDetailMapper.get(theaterArrange.getFilmDetail().getId());
		String filmLength = film.getFilmLength();
		String length = filmLength.substring(0,filmLength.indexOf("分钟"));
		Calendar calendar = Calendar.getInstance();
		try {
			calendar.setTime(sdf2.parse(filmTime));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		calendar.add(Calendar.MINUTE, Integer.parseInt(length));
		String end = sdf1.format(calendar.getTime());
		
		Date release = null;
		Date start = null;
		Date endTime = null;
		try {
			release = sdf.parse(releaseTime);
			start = sdf1.parse(startTime);
			endTime = sdf1.parse(end);
		} catch (Exception e) {
			e.printStackTrace();
		}
		theaterArrange.setReleaseTime(release);
		theaterArrange.setStartTime(start);
		theaterArrange.setEndTime(endTime);
		theaterArrange.setId(UUID.randomUUID().toString().replace("-", ""));
		theaterArrange.setCreateBy(account.getUserName());
		
		theaterArrangeMapper.insert(theaterArrange);
		
		List<ApplyArrange> applyList = applyArrangeMapper.selApplyByFilmId(theaterArrange.getFilmDetail().getId(), release);
		for(ApplyArrange a : applyList){
			applyArrangeMapper.updReviewStatus("0", a.getId());
		}
	}

	@Override
	public void updDelFlag(String delFlag, String id) {
		theaterArrangeMapper.updDelFlag(delFlag, id);
	}

	@Override
	public void updRemarks(String remarks, String id) {
		theaterArrangeMapper.updRemarks(remarks, id);
	}

	@Override
	public Page selArrangeByTermSuper(TheaterArrange theaterArrange,int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		int startRow = page.getStartRow();
		theaterArrange.setStartRow(startRow);
		theaterArrange.setPageSize(page.getPageSize());
		List<TheaterArrange> arrangeList = theaterArrangeMapper.selArrangeByTermSuper(theaterArrange);;
		page.setData(arrangeList);
		
		int count = theaterArrangeMapper.selTermCountSuper(theaterArrange);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public int selTermCountSuper(TheaterArrange theaterArrange) {
		return theaterArrangeMapper.selTermCountSuper(theaterArrange);
	}

	@Override
	public List<TheaterArrange> selArrangeByCoupon(String couponId) {
		return theaterArrangeMapper.selArrangeByCoupon(couponId);
	}

	@Override
	public List<TheaterArrange> selArrangeByFilm(String filmId) {
		return theaterArrangeMapper.selArrangeByFilm(filmId);
	}
}
