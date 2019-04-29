package com.neusoft.modules.front.filmType.service;

import java.util.List;

import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.front.filmType.model.FilmType;

public interface FilmTypeService {

	/*
	 * 查询单条
	 */
	public FilmType get(String id);
	
	/*
	 * 查询所有
	 */
	public List<FilmType> selAll();
	
	/**
	 * 根据类型名称查询类型
	 */
	public List<FilmType> selAllByType(FilmType filmType);
	
	/**
	 * 新增
	 */
	public void insert(FilmType filmType);
	
	/**
	 * 将电影类型修改为类型id
	 */
	public void updateToFilmType(String newFilmType,String oldFilmType);
	
	/**
	 * 根据类型名称查找该类型id
	 */
	public String selIdByTypeName(String typeName);
	
	/**
	 * 查找某电影的类型名称
	 */
	public List<FilmType> selType(FilmDetail filmDetail);
}
