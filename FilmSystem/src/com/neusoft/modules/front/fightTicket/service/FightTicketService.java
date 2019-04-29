package com.neusoft.modules.front.fightTicket.service;

import java.util.List;

import com.neusoft.common.cominterface.CommonService;
import com.neusoft.common.page.Page;
import com.neusoft.modules.front.fightTicket.model.FightTicket;

public interface FightTicketService extends CommonService<FightTicket>{

	/**
	 * 根据影厅安排id查找拼单的座位信息
	 */
	public List<FightTicket> selFightByArrange(String arrangeId);
	
	public FightTicket getTicket(String id);
	
	/**
	 * 根据拼单信息id修改该条记录的支付情况
	 */
	public void updPayStatus(String fightId);
	
	/**
	 * 根据使用积分数更新最终实付钱数
	 */
	public void updPrice(double price,String fightId,int usedScore);
	
	/**
	 * 更改订单状态
	 */
	public void updDelFlag(String delFlag,String id);
	
	/**
	 * 查询被占用的订单
	 */
	public FightTicket selDelFlag(String id);
	
	/**
	 * 查询该用户下的所有订单
	 */
	public List<FightTicket> selAllByPerson(FightTicket fightTicket);
	
	/**
	 * 取消订单
	 */
	public void updDel(String id);
	
	/**
	 * 查询超时订单
	 */
	public List<FightTicket> selTimeOut();
	
	/**
	 * 查询影片放映完后的订单信息
	 */
	public List<FightTicket> selWatchedFilm();
	
	/**
	 * 修改订单观看状态
	 */
	public void updWatchStatus(String id);
	
	/**
	 * 修改审核状态
	 */
	public void updReviewStatus(String reviewStatus,String updateBy,String id);
	
	/**
	 * 修改订单退换积分后的支付状态
	 */
	public void updReturnPayStatus(String fightId);
	
	/**
	 * 查询已支付的有效的订单信息
	 */
	public List<FightTicket> selAvailableFight(String arrangeId);
	
	/**
	 * 修改拼单状态
	 */
	public void updFightStatus(FightTicket fightTicket);
	
	/**
	 * 查询发起拼单的订单信息
	 */
	public FightTicket selWhichFight(String arrangeId);
	
	/**
	 * 添加观影码
	 */
	public void updWatchCode(String watchCode,String id);
	
	/**
	 * 查询影片开始前两小时内拼单人数还未到达指定比例的订单信息
	 */
	public List<FightTicket> selBeforeTwoHour();
	
	/**
	 * 写明备注信息
	 */
	public void updRemarks(String remarks,String updateBy,String id);
	
	/**
	 * 修改订单最终状态
	 */
	public void updFinalType(String finalType,String id);
	
	/**
	 * 查询影片放映1小时前还未审核的订单信息
	 */
	public List<FightTicket> selBeforeOneHour();
	
	/**
	 * 查询影片放映1小时前还未审核的取消的订单信息
	 */
	public List<FightTicket> selBeforeOneHourCancel();
	
	/**
	 * 查询拼单下参与拼单的订单信息
	 */
	public List<FightTicket> selAttendFight(String arrangeId);
	
	/**
	 * 查找拼单信息 根据发布的时间排序 
	 */
	public Page selFightByCreateDate(FightTicket fightTicket,int pageNo);
	
	/**
	 * 查询拼单信息的总条数
	 */
	public int selFightCount();
	
	/**
	 * 查询所有订单
	 */
	public Page selAllByAdmin(FightTicket fightTicket,int pageNo);
	
	/**
	 * 查询所有订单的数量
	 */
	public int selAllByAdminCount(FightTicket fightTicket);
	
	/**
	 * 查询已观看的订单信息
	 */
	public List<FightTicket> selWatched();
}
