package com.neusoft.modules.collect.mapper;

import java.util.List;

import com.neusoft.common.cominterface.CommonInterface;
import com.neusoft.modules.collect.model.Collect;

public interface CollectMapper extends CommonInterface<Collect>{

	/**
	 * 根据用户id和影片id查找收藏信息
	 */
	public Collect selByFilmAccount(String filmId,String accountId);
	
	/**
	 * 根据用户id查找所有的收藏列表 
	 */
	public List<Collect> selByAccount(String accountId);
	
	/**
	 * 删除收藏信息
	 */
	public void updDelFlag(String delFlag,String id);
}
