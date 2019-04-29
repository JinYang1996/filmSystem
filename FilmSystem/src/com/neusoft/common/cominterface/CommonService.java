package com.neusoft.common.cominterface;

import java.util.List;

public interface CommonService<T> {
	/**
	 * 查询单条
	 */
	public T get(String id);
	
	/**
	 * 查询多条
	 */
	public List<T> selAll();
	
	/**
	 * 添加单条数据
	 */
	public void insert(T t);
	
	/**
	 * 更新单条数据
	 */
	public void update(T t);
}
