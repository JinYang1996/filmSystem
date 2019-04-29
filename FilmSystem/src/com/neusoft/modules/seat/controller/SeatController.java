package com.neusoft.modules.seat.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neusoft.modules.seat.model.Seat;
import com.neusoft.modules.seat.service.SeatService;
import com.neusoft.modules.videoHall.model.VideoHall;
import com.neusoft.modules.videoHall.service.VideoHallService;

@Controller
@RequestMapping(value = "seat")
public class SeatController {
	
	@Autowired
	private SeatService seatService;
	
	@Autowired
	private VideoHallService videoHallService;
	
	/**
	 * 跳转到添加座位页面
	 * 部门：软件开发事业部
	 * 功能：
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-3-22
	 */
	@RequestMapping(value = "toAddSeat")
	public String toAddSeat(String hallName,Model model){
		if(null != hallName){
			model.addAttribute("hall",videoHallService.selHallForName(hallName));
			return "modules/seat/addSeat";
		}else{
			return "error/error";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="getSeatDetail")
	public List<Seat> getSeatDetail(String hallName){
		//查询相应厅号的所有座位信息
		Seat seat = new Seat();
		seat.setVideoHall(videoHallService.selHallForName(hallName));
		List<Seat> seatList = seatService.selSeatForHall(seat);
		return seatList;
	}

	/**
	 * 根据放映厅厅号添加座位信息
	 * 部门：软件开发事业部
	 * 功能：
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-3-22
	 */
	@ResponseBody
	@RequestMapping(value = "addSeat1")
	public String addSeat1(@RequestParam("seatList")String seatList,@RequestParam("hallName")String hallName,
			@RequestParam("hallRow")String hallRow,@RequestParam("hallCol")String hallCol){
		String flag = "";
		String[] seat = seatList.split(",");
		
		VideoHall videoHall = videoHallService.selHallForName(hallName);
		
		//用来清空改变影厅规格时的座位信息
		Seat s2 = new Seat();
		s2.setVideoHall(videoHallService.selHallForName(hallName));
		List<Seat> seatAllList = seatService.selSeatForHall(s2);
		//保存影厅的行、列规格
		if(Integer.parseInt(hallRow) != videoHall.getHallRow() || Integer.parseInt(hallCol) != videoHall.getHallCol()){
			videoHall.setHallRow(Integer.parseInt(hallRow));
			videoHall.setHallCol(Integer.parseInt(hallCol));
			videoHallService.update(videoHall);
			for(Seat sss : seatAllList){
				sss.setDelFlag("1");
				seatService.updateDelFlag(sss);
			}
		}
		
		
		//用来存放选择座位的行、列的座位集合
		List<Seat> sList = new ArrayList<Seat>();
		
		//用来存放取消座位的行、列集合
		List<Seat> sListCancel = new ArrayList<Seat>();
		Seat s1 = new Seat();
		s1.setVideoHall(videoHallService.selHallForName(hallName));
		sListCancel = seatService.selSeatForHall(s1);
		
		for(String s : seat){
			Seat sea = new Seat();
			String row = s.substring(s.indexOf("row"),s.indexOf("col"));
			String col = s.substring(s.indexOf("col"));
			sea.setSeatRow(row);//座位行
			sea.setSeatNumber(col);//座位列
			sea.setVideoHall(videoHall);
			//查找座位行、列是否存在
			Seat ss = seatService.selRowAndCol(sea);
			if(ss == null){//座位行、列不存在，添加座位
				sList.add(sea);
				seatService.insert(sea);
			}else{//座位行、列存在
				if(ss.getDelFlag().equals("1")){//如果座位存在且被作废，将del_flag改为'0'
					ss.setDelFlag("0");
					seatService.updateDelFlag(ss);
				}else{
					for(int i=0 ; i<sListCancel.size();i++){
						Seat s3 = sListCancel.get(i);
						if(s3.getId().equals(ss.getId())){
							sListCancel.remove(i);
						}
					}
				}
			}
		}
		for(Seat sss:sListCancel){
			sss.setDelFlag("1");
			seatService.updateDelFlag(sss);
		}
		if(null != sList && sList.size() != 0){
			flag = "1";//添加成功
		}else{
			flag = "2";
		}
		return flag;
	}
}
