package com.neusoft.modules.front.filmDetail.service;

import java.util.List;

import com.neusoft.common.page.Page;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;

public interface FilmDetailService {
	
	/*
	 * 查询单条
	 */
	public FilmDetail get(String id);
	
	/*
	 * 查询所有
	 */
	public List<FilmDetail> selAll();
	
	/**
	 * 对电影信息进行分页
	 */
	public Page selPageFilm(int pageNo);
	
	/**
	 * 添加电影信息
	 */
	public void insert(FilmDetail filmDetail);
	
	/**
	 * 删除表中所有数据
	 */
	public void delAll();

	/**
	 * 根据电影名称查询是否存在
	 */
	public int selFilmByTitle(String title);
	
	/**
	 * 修改电影价格
	 */
	public void updatePrice(double price,String id,String updateBy);
	
	/**
	 * 评分排行
	 */
	public List<FilmDetail> selFilmByScore();
	
	/**
	 * 修改del_flag状态
	 */
	public void updDelFlag(String delFlag,String id,String updateBy);
	
	/**
	 * 条件查询
	 */
	public Page selByFilm(FilmDetail filmDetail,int pageNo);
	
	/**
	 * 条件查询总条数
	 */
	public int selPageCount(FilmDetail filmDetail);
	
	/**
	 * 更新
	 */
	public void update(FilmDetail filmDetail);
	
	/**
	 * 更新销量
	 */
	public void updateSales(int count,String id);
	
	/**
	 * 根据排行查询影片
	 */
	public List<FilmDetail> selFilmBySales();
}
