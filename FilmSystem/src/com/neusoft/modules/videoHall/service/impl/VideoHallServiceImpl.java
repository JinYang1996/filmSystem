package com.neusoft.modules.videoHall.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.modules.videoHall.mapper.VideoHallMapper;
import com.neusoft.modules.videoHall.model.VideoHall;
import com.neusoft.modules.videoHall.service.VideoHallService;

@Service
public class VideoHallServiceImpl implements VideoHallService {

	@Autowired
	private VideoHallMapper videoHallMapper;

	@Override
	public VideoHall get(String id) {
		return videoHallMapper.get(id);
	}

	@Override
	public List<VideoHall> selAll() {
		return videoHallMapper.selAll();
	}

	@Override
	public void insert(VideoHall videoHall) {
		if(null != videoHall.getHallName() && !"".equals(videoHall.getHallName())){
			videoHall.setId(UUID.randomUUID().toString().replace("-", ""));
			videoHallMapper.insert(videoHall);
		}
	}

	@Override
	public void update(VideoHall videoHall) {
		videoHallMapper.update(videoHall);
	}

	@Override
	public int selHallName(String hallName) {
		return videoHallMapper.selHallName(hallName);
	}

	@Override
	public VideoHall selHallForName(String hallName) {
		return videoHallMapper.selHallForName(hallName);
	}

	@Override
	public void updateVideoHallDel(String id, String updateBy) {
		videoHallMapper.updateVideoHallDel(id, updateBy);
	}
	
	
}
