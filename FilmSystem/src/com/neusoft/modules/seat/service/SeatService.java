package com.neusoft.modules.seat.service;

import java.util.List;

import com.neusoft.common.cominterface.CommonService;
import com.neusoft.modules.seat.model.Seat;

public interface SeatService extends CommonService<Seat>{
	/**
	 * 根据放映厅的厅号查找座位信息
	 */
	public List<Seat> selSeatForHall(Seat seat);
	
	/**
	 * 根据座位行、列查找座位号是否存在
	 */
	public Seat selRowAndCol(Seat seat);
	
	public void updateDelFlag(Seat seat);
	
	/**
	 * 根据影厅号、座位行、座位列 查找座位id
	 */
	public Seat selSeatByHall(String row,String col,String hallId);
}
