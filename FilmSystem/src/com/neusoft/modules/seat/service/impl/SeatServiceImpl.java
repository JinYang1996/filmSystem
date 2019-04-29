package com.neusoft.modules.seat.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.modules.seat.mapper.SeatMapper;
import com.neusoft.modules.seat.model.Seat;
import com.neusoft.modules.seat.service.SeatService;

@Service
public class SeatServiceImpl implements SeatService {

	@Autowired
	private SeatMapper seatMapper;
	
	@Override
	public Seat get(String id) {
		return seatMapper.get(id);
	}

	@Override
	public List<Seat> selAll() {
		return seatMapper.selAll();
	}

	@Override
	public void insert(Seat seat) {
		seat.setId(UUID.randomUUID().toString().replace("-", ""));
		seatMapper.insert(seat);
	}

	@Override
	public void update(Seat seat) {
		seatMapper.update(seat);
	}

	@Override
	public List<Seat> selSeatForHall(Seat seat) {
		return seatMapper.selSeatForHall(seat);
	}

	@Override
	public Seat selRowAndCol(Seat seat) {
		return seatMapper.selRowAndCol(seat);
	}

	@Override
	public void updateDelFlag(Seat seat) {
		seatMapper.updateDelFlag(seat);
	}

	@Override
	public Seat selSeatByHall(String row, String col, String hallId) {
		return seatMapper.selSeatByHall(row, col, hallId);
	}

}
