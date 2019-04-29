package com.neusoft.modules.videoHall.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.front.fightTicket.model.FightTicket;
import com.neusoft.modules.front.fightTicket.service.FightTicketService;
import com.neusoft.modules.seat.model.Seat;
import com.neusoft.modules.seat.service.SeatService;
import com.neusoft.modules.theaterArrange.model.TheaterArrange;
import com.neusoft.modules.theaterArrange.service.TheaterArrangeService;
import com.neusoft.modules.videoHall.model.VideoHall;
import com.neusoft.modules.videoHall.service.VideoHallService;

@Controller
@RequestMapping(value = "/videoHall")
public class VideoHallController {

	@Autowired
	private VideoHallService videoHallService;
	
	@Autowired
	private SeatService seatService;
	
	@Autowired
	private FightTicketService fightTicketService;
	
	@Autowired
	private TheaterArrangeService theaterArrangeService;
	
	@RequestMapping(value = "/selAllVideoHall")
	public String selAllVideoHall(Model model){
		List<VideoHall> hallList = videoHallService.selAll();
		model.addAttribute("hallList",hallList);
		return "modules/videoHall/showAllHall";
	}
	
	@RequestMapping(value = "toAddVideoHall")
	public String toAddVideoHall(){
		return "modules/videoHall/addVideoHall";
	}
	
	@RequestMapping(value = "/addVideoHall")
	public String addVideoHall(VideoHall videoHall,HttpSession session){
		if(null != videoHall){
			videoHall.setCreateBy(((Account)session.getAttribute("user")).getUserName());
			videoHallService.insert(videoHall);
		}
		return "redirect:selAllVideoHall";
	}
	
	@ResponseBody
	@RequestMapping(value = "validateHallName")
	public String validateHallName(VideoHall videoHall){
		String flag = "";
		int count = videoHallService.selHallName(videoHall.getHallName());
		if(count <= 0){
			flag = "1";//无该影院名称
		}else{
			flag = "2";//影院名称已存在
		}
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value = "getVideoSeat")
	public Map getVideoSeat(@RequestParam("hallId")String hallId,@RequestParam("arrangeId")String arrangeId){
		VideoHall hall = videoHallService.get(hallId);
		
		//查询相应厅号的所有座位信息
		Seat seat = new Seat();
		seat.setVideoHall(videoHallService.selHallForName(hall.getHallName()));
		List<Seat> seatList = seatService.selSeatForHall(seat);
		List<FightTicket> fightList = fightTicketService.selFightByArrange(arrangeId);
		List<String> rowCol = new ArrayList<String>();
		
		String fightPeople = null;
		String payStatus = null;
		for(FightTicket f : fightList){
			//查找发起拼单人
			if(f.getType().equals("1")){
				fightPeople = f.getFightPeople();
				payStatus = f.getPayStatus();
			}
			String seatIds = f.getSeatIds();
			if(seatIds.contains(",")){
				String[] sid = seatIds.split(",");
				for(String s : sid){
					String id = StringUtils.trim(s);
					Seat seats = seatService.get(id);
					String rowAndCol = seats.getSeatRow()+seats.getSeatNumber();
					rowCol.add(rowAndCol);
				}
			}else{
				Seat seats = seatService.get(seatIds);
				String rowAndCol = seats.getSeatRow()+seats.getSeatNumber();
				rowCol.add(rowAndCol);
			}
		}
		Map hallMap = new HashMap();
		hallMap.put("hall", hall);
		hallMap.put("seat", seatList);
		hallMap.put("rowCol", rowCol);
		hallMap.put("fightPeople", fightPeople);
		hallMap.put("payStatus", payStatus);
		return hallMap;
	}
	
	/**
	 * 删除影厅信息
	 * @param id
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "delVideoHall")
	public String delVideoHall(String id,HttpSession session){
		String flag = "";
		Account account = (Account)session.getAttribute("user");
		VideoHall video = new VideoHall();
		video.setId(id);
		TheaterArrange theaterArrange = new TheaterArrange();
		theaterArrange.setVideoHall(video);
		List<TheaterArrange> arrangeList = theaterArrangeService.selByHallId(theaterArrange);
		if(arrangeList.size() == 0){
			videoHallService.updateVideoHallDel(id, account.getUserName());
			flag = "1";
		}else{
			flag = "2";
		}
		return flag;
	}
}
