package com.neusoft.modules.front.filmType.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.modules.front.filmDetail.mapper.FilmDetailMapper;
import com.neusoft.modules.front.filmDetail.model.FilmDetail;
import com.neusoft.modules.front.filmType.mapper.FilmTypeMapper;
import com.neusoft.modules.front.filmType.model.FilmType;
import com.neusoft.modules.front.filmType.service.FilmTypeService;

@Service
public class FilmTypeServiceImpl implements FilmTypeService{

	@Autowired
	private FilmTypeMapper filmTypeMapper;
	
	@Autowired
	private FilmDetailMapper filmDetailMapper;
	
	@Override
	public FilmType get(String id) {
		return filmTypeMapper.get(id);
	}

	@Override
	public List<FilmType> selAll() {
		// TODO Auto-generated method stub
		return filmTypeMapper.selAll();
	}

	@Override
	public void updateToFilmType(String newFilmType, String oldFilmType) {
		filmTypeMapper.updateToFilmType(newFilmType, oldFilmType);
	}
	
	@Override
	public String selIdByTypeName(String typeName) {
		// TODO Auto-generated method stub
		return filmTypeMapper.selIdByTypeName(typeName);
	}

	@Override
	public List<FilmType> selType(FilmDetail filmDetail) {
		String filmType = filmDetailMapper.get(filmDetail.getId()).getType();
		String[] typeName = filmType.split(",");
		List<FilmType> typeList = new ArrayList<FilmType>();
		for(String type:typeName){
			FilmType t = filmTypeMapper.get(type);
			typeList.add(t);
		}
		return typeList;
	}

	@Override
	public void insert(FilmType filmType) {
		// TODO Auto-generated method stub
		filmTypeMapper.insert(filmType);
	}

	@Override
	public List<FilmType> selAllByType(FilmType filmType) {
		return filmTypeMapper.selAllByType(filmType);
	}

}
