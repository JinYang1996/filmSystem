package com.neusoft.modules.videoHall.service;

import com.neusoft.common.cominterface.CommonService;
import com.neusoft.modules.videoHall.model.VideoHall;

public interface VideoHallService extends CommonService<VideoHall>{

	/**
	 * 根据影院名称查询是否存在
	 */
	public int selHallName(String hallName);
	
	/**
	 * 根据影院名称查询影院信息
	 */
	public VideoHall selHallForName(String hallName);
	
	/**
	 * 删除影厅信息
	 */
	public void updateVideoHallDel(String id,String updateBy);
}
