package com.neusoft.modules.front.fightTicket.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.common.page.Page;
import com.neusoft.modules.front.fightTicket.mapper.FightTicketMapper;
import com.neusoft.modules.front.fightTicket.model.FightTicket;
import com.neusoft.modules.front.fightTicket.service.FightTicketService;

@Service
public class FightTicketServiceImpl implements FightTicketService{

	@Autowired
	private FightTicketMapper fightTicketMapper;
	@Override
	public FightTicket get(String id) {
		// TODO Auto-generated method stub
		return fightTicketMapper.get(id);
	}

	@Override
	public List<FightTicket> selAll() {
		// TODO Auto-generated method stub
		return fightTicketMapper.selAll();
	}

	@Override
	public void insert(FightTicket t) {
		// TODO Auto-generated method stub
		fightTicketMapper.insert(t);
	}

	@Override
	public void update(FightTicket t) {
		// TODO Auto-generated method stub
		fightTicketMapper.update(t);
	}

	@Override
	public List<FightTicket> selFightByArrange(String arrangeId) {
		return fightTicketMapper.selFightByArrange(arrangeId);
	}

	@Override
	public void updPayStatus(String fightId) {
		fightTicketMapper.updPayStatus(fightId);
	}

	@Override
	public void updPrice(double price, String fightId,int usedScore) {
		fightTicketMapper.updPrice(price, fightId,usedScore);
	}

	@Override
	public void updDelFlag(String delFlag, String id) {
		// TODO Auto-generated method stub
		fightTicketMapper.updDelFlag(delFlag, id);
	}

	@Override
	public FightTicket selDelFlag(String id) {
		// TODO Auto-generated method stub
		return fightTicketMapper.selDelFlag(id);
	}

	@Override
	public List<FightTicket> selAllByPerson(FightTicket fightTicket) {
		// TODO Auto-generated method stub
		return fightTicketMapper.selAllByPerson(fightTicket);
	}

	@Override
	public void updDel(String id) {
		// TODO Auto-generated method stub
		fightTicketMapper.updDel(id);
	}

	@Override
	public List<FightTicket> selTimeOut() {
		// TODO Auto-generated method stub
		return fightTicketMapper.selTimeOut();
	}

	@Override
	public List<FightTicket> selWatchedFilm() {
		// TODO Auto-generated method stub
		return fightTicketMapper.selWatchedFilm();
	}

	@Override
	public void updWatchStatus(String id) {
		// TODO Auto-generated method stub
		fightTicketMapper.updWatchStatus(id);
	}

	@Override
	public void updReviewStatus(String reviewStatus, String updateBy, String id) {
		fightTicketMapper.updReviewStatus(reviewStatus, updateBy, id);
	}

	@Override
	public void updReturnPayStatus(String fightId) {
		fightTicketMapper.updReturnPayStatus(fightId);
	}

	@Override
	public List<FightTicket> selAvailableFight(String arrangeId) {
		return fightTicketMapper.selAvailableFight(arrangeId);
	}

	@Override
	public void updFightStatus(FightTicket fightTicket) {
		fightTicketMapper.updFightStatus(fightTicket);
	}

	@Override
	public FightTicket selWhichFight(String arrangeId) {
		return fightTicketMapper.selWhichFight(arrangeId);
	}

	@Override
	public void updWatchCode(String watchCode, String id) {
		fightTicketMapper.updWatchCode(watchCode, id);
	}

	@Override
	public List<FightTicket> selBeforeTwoHour() {
		return fightTicketMapper.selBeforeTwoHour();
	}

	@Override
	public void updRemarks(String remarks, String updateBy, String id) {
		fightTicketMapper.updRemarks(remarks, updateBy, id);
	}

	@Override
	public void updFinalType(String finalType, String id) {
		fightTicketMapper.updFinalType(finalType, id);
	}

	@Override
	public List<FightTicket> selBeforeOneHour() {
		return fightTicketMapper.selBeforeOneHour();
	}

	@Override
	public List<FightTicket> selAttendFight(String arrangeId) {
		return fightTicketMapper.selAttendFight(arrangeId);
	}

	@Override
	public Page selFightByCreateDate(FightTicket fightTicket, int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(4);
		int startRow = page.getStartRow();
		fightTicket.setStartRow(startRow);
		fightTicket.setPageSize(4);
		List<FightTicket> fightList = fightTicketMapper.selFightByCreateDate(fightTicket);
		page.setData(fightList);
		
		int count = fightTicketMapper.selFightCount();
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public int selFightCount() {
		return fightTicketMapper.selFightCount();
	}

	@Override
	public Page selAllByAdmin(FightTicket fightTicket,int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		int startRow = page.getStartRow();
		fightTicket.setStartRow(startRow);
		fightTicket.setPageSize(page.getPageSize());
		List<FightTicket> fightList = fightTicketMapper.selAllByAdmin(fightTicket);
		page.setData(fightList);
		
		int count = fightTicketMapper.selAllByAdminCount(fightTicket);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public int selAllByAdminCount(FightTicket fightTicket) {
		return fightTicketMapper.selAllByAdminCount(fightTicket);
	}

	@Override
	public List<FightTicket> selWatched() {
		return fightTicketMapper.selWatched();
	}

	@Override
	public FightTicket getTicket(String id) {
		return fightTicketMapper.getTicket(id);
	}

	@Override
	public List<FightTicket> selBeforeOneHourCancel() {
		return fightTicketMapper.selBeforeOneHourCancel();
	}

}
