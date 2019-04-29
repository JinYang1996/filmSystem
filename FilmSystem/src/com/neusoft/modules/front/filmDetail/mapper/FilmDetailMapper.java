package com.neusoft.modules.front.filmDetail.mapper;

import java.util.List;

import com.neusoft.modules.front.filmDetail.model.FilmDetail;

public interface FilmDetailMapper {

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
	public List<FilmDetail> selPageFilm(int startRow,int pageSize);
	
	/**
	 * 查询所有的电影总数
	 */
	public int selAllCount();
	
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
	public List<FilmDetail> selByFilm(FilmDetail filmDetail);
	
	/**
	 * 条件查询条页数
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
