package com.neusoft.modules.videoHall.mapper;

import org.apache.ibatis.annotations.Param;

import com.neusoft.common.cominterface.CommonInterface;
import com.neusoft.modules.videoHall.model.VideoHall;

public interface VideoHallMapper extends CommonInterface<VideoHall>{

	/**
	 * 根据影院名称查询是否存在
	 */
	public int selHallName(@Param("hallName")String hallName);
	
	/**
	 * 根据影院名称查询影院信息
	 */
	public VideoHall selHallForName(@Param("hallName")String hallName);
	
	/**
	 * 删除影厅信息
	 */
	public void updateVideoHallDel(String id,String updateBy);
}
