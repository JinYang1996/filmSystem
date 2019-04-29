package com.neusoft.modules.theaterArrange.service;

import java.util.List;

import com.neusoft.common.cominterface.CommonService;
import com.neusoft.common.page.Page;
import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.theaterArrange.model.TheaterArrange;

public interface TheaterArrangeService extends CommonService<TheaterArrange>{

	/**
	 * 根据影厅号查找影院安排信息
	 */
	public List<TheaterArrange> selByHallId(TheaterArrange theaterArrange);
	
	/**
	 * 根据电影id查找影院安排列表
	 */
	public List<TheaterArrange> selByFilmId(String filmId,String releaseDate);
	
	/**
	 * 删除影院安排信息 
	 */
	public void delArrange(String arrangeId);
	
	/**
	 * 将今天以前的上映安排del_flag全部置为  "1"
	 */
	public void updBeforeToday(String remarks);
	
	/**
	 * 条件查询影厅安排
	 */
	public Page selArrangeByTerm(TheaterArrange theaterArrange,int pageNo);
	
	/**
	 * 条件查询总条数
	 */
	public int selTermCount(TheaterArrange theaterArrange);
	
	/**
	 * 新增影厅安排
	 */
	public void addTheater(TheaterArrange theaterArrange,String filmTime,Account account);
	
	/**
	 * 修改del_flag
	 */
	public void updDelFlag(String delFlag,String id);
	
	/**
	 * 修改备注信息
	 */
	public void updRemarks(String remarks,String id);
	
	/**
	 * 超级管理员条件查询影厅安排
	 */
	public Page selArrangeByTermSuper(TheaterArrange theaterArrange,int pageNo);
	
	/**
	 * 超级管理员条件查询总条数
	 */
	public int selTermCountSuper(TheaterArrange theaterArrange);
	
	/**
	 * 根据优惠券id查询放映安排
	 */
	public List<TheaterArrange> selArrangeByCoupon(String couponId);
	
	/**
	 * 查询影片是否有放映安排
	 */
	public List<TheaterArrange> selArrangeByFilm(String filmId);
}
