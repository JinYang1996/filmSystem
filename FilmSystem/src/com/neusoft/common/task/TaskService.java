package com.neusoft.common.task;

public interface TaskService {
	/**
	 * 测试
	 * 部门：软件开发事业部
	 * 功能：
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-4-9
	 */
	public void myTest();
	
	/**
	 * 定时任务，用于清除超时订单
	 */
	public void cancelTimeOut();
	
	/**
	 * 定时任务，用于将观看完的订单状态置为已观看
	 */
	public void changeWatched();
	
	/**
	 * 定时任务，用于将影片放映前两小时还没有到达指定比例的拼单信息清除
	 */
	public void cancelTwoHour();
	
	/**
	 * 定时任务，用于将影片放映前1小时没有审核的订单信息全部清空
	 */
	public void cancelOneHour();
	
	/**
	 * 将今天以前没有审核的影厅安排申请清除 
	 */
	public void cancelApplyBeforeToday();
}
