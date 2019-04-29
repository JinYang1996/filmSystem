package com.neusoft.modules.front.filmDetail.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.common.page.Page;
import com.neusoft.modules.front.filmDetail.mapper.FilmDetailMapper;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.front.filmDetail.service.FilmDetailService;

@Service
public class FilmDetailServiceImpl implements FilmDetailService{

	@Autowired
	private FilmDetailMapper filmDetailMapper;
	
	@Override
	public FilmDetail get(String id) {
		return filmDetailMapper.get(id);
	}

	@Override
	public List<FilmDetail> selAll() {
		return filmDetailMapper.selAll();
	}

	@Override
	public void insert(FilmDetail filmDetail) {
		filmDetailMapper.insert(filmDetail);
	}

	@Override
	public void delAll() {
		filmDetailMapper.delAll();
	}

	@Override
	public Page selPageFilm(int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setSumCount(filmDetailMapper.selAllCount());
		page.setSumPage(page.getPage());
		int startRow = page.getStartRow();
		page.setData(filmDetailMapper.selPageFilm(startRow, page.getPageSize()));
		return page;
	}

	@Override
	public int selFilmByTitle(String title) {
		return filmDetailMapper.selFilmByTitle(title);
	}

	@Override
	public void updatePrice(double price,String id,String updateBy) {
		filmDetailMapper.updatePrice(price, id, updateBy);
	}

	@Override
	public List<FilmDetail> selFilmByScore() {
		return filmDetailMapper.selFilmByScore();
	}

	@Override
	public void updDelFlag(String delFlag, String id,String updateBy) {
		filmDetailMapper.updDelFlag(delFlag, id ,updateBy);
	}

	@Override
	public Page selByFilm(FilmDetail filmDetail,int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		int startRow = page.getStartRow();
		filmDetail.setStartRow(startRow);
		filmDetail.setPageSize(page.getPageSize());
		List<FilmDetail> filmList = filmDetailMapper.selByFilm(filmDetail);
		page.setData(filmList);
		
		int count = filmDetailMapper.selPageCount(filmDetail);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public int selPageCount(FilmDetail filmDetail) {
		return filmDetailMapper.selPageCount(filmDetail);
	}

	@Override
	public void update(FilmDetail filmDetail) {
		filmDetailMapper.update(filmDetail);
	}

	@Override
	public void updateSales(int count, String id) {
		filmDetailMapper.updateSales(count, id);
	}

	@Override
	public List<FilmDetail> selFilmBySales() {
		return filmDetailMapper.selFilmBySales();
	}
}
