package com.neusoft.modules.front.filmType.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neusoft.common.pattern.PatternTool;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.front.filmDetail.service.FilmDetailService;
import com.neusoft.modules.front.filmType.model.FilmType;
import com.neusoft.modules.front.filmType.service.FilmTypeService;

@Controller
@RequestMapping(value = "filmType")
public class FilmTypeController {

	@Resource
	private FilmTypeService filmTypeService;
	
	@Resource
	private FilmDetailService filmDetailService;
	
	/**
	 * 修改影片类型为字符串
	 * 部门：软件开发事业部
	 * 功能：
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-4-11
	 */
	@RequestMapping(value = "changeFilmType")
	public String changeFilmType(Model model){
		//获取所有的电影信息列表
		List<FilmDetail> filmList = filmDetailService.selAll();
		
		//存放未找到电影类别的电影
		List<FilmDetail> failList = new ArrayList<FilmDetail>();
		
		if(null != filmList){
			//遍历电影
			for(FilmDetail f :filmList){
				//爬虫获取的数据中电影类型是以“/”分割的，如果存在“/”，就是类型没有转换过的
				if(f.getType().contains("/")){
					//将类型分割为一个数组
					String[] oldFilmType = f.getType().split("/");
					if(null != oldFilmType && !"".equals(oldFilmType)){
						List<String> ids = new ArrayList<String>();
						for(String typeName : oldFilmType){
							//将分割数组中的空白字符替换并根据类型名称查询相应的类型id
							String id = filmTypeService.selIdByTypeName(typeName.replace(" ",""));
							if(null != id){
								ids.add(id);
							}else{
								ids.add(typeName);
							}							
						}
						if(PatternTool.isContainChinese(ids.toString())){
							failList.add(f);
						}else{
							filmTypeService.updateToFilmType(StringUtils.strip(ids.toString(),"[]"), f.getType());
						}
					}
				}else{
					//存在单个类型的电影也没有“/”，所以也要进行转换
					if(PatternTool.isContainChinese(f.getType())){
						String id = filmTypeService.selIdByTypeName(f.getType());
						//如果id为空则不改变电影类型
						if(null != id){
							List<String> ids = new ArrayList<String>();
							ids.add(id);
							filmTypeService.updateToFilmType(StringUtils.strip(ids.toString(),"[]"), f.getType());
						}else{
							//如果找不到该电影类型 则保留电影类型 并添加到未找到类型数组中
							filmTypeService.updateToFilmType(f.getType(), f.getType());
							failList.add(f);
						}
					}
				}
			}
		}else{
			return "index";
		}
		//如果无没找的电影类型 则跳转到。。
		if(failList.size() == 0){
			return "redirect:../filmDetail/selByFilm?pageNo=0";
		}else{
			model.addAttribute("failList",failList);
			return "error/changeTypeFail";
		}
		
	}
	
	/**
	 * 查询所有影片类型信息
	 */
	@RequestMapping(value = "selFilmType")
	public String selFilmType(Model model,FilmType filmType){
		List<FilmType> typeList = filmTypeService.selAllByType(filmType);
		if(typeList == null){
			typeList = new ArrayList<FilmType>();
		}
		model.addAttribute("typeList",typeList);
		model.addAttribute("filmType",filmType);
		return "modules/filmType/filmTypeList";
	}
	
	/**
	 * 检查类型名称是否存在
	 */
	@ResponseBody
	@RequestMapping(value = "checkType")
	public String checkType(String typeName){
		String flag = "0";
		if(null != typeName && !"".equals(typeName)){
			String id = filmTypeService.selIdByTypeName(typeName);
			if(null == id){
				flag = "1";//没用重复  可用
			}else{
				flag = "2";//重复 不可用
			}
		}else{
			flag = "3";//类型名称为空
		}
		return flag;
	}
	
	/**
	 * 新增影片类型
	 */
	@RequestMapping(value = "addFilmType")
	public String addFilmType(String typeName){
		FilmType filmType = new FilmType();
		if(null != typeName && !"".equals(typeName)){
			filmType.setTypeName(typeName);
			filmTypeService.insert(filmType);
			
		}
		return "redirect:selFilmType";
	}
}
