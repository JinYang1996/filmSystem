package com.neusoft.modules.front.filmDetail.model;

import com.neusoft.common.model.CommonModel;

public class FilmDetail extends CommonModel implements Cloneable{

	private String id;
	
	private String releaseYear;//上映年份
	
	private String picture;//图片
	
	private String giantScreen;//巨幕
	
	private String title;//电影名称
	
	private String direct;//导演
	
	private String screenWriter;//编剧
	
	private String leadingRole;//主演

	private String type;//电影类型
	
	private String state;//地区
	
	private String language;//语言
	
	private String releaseDate;//上映日期
	
	private String filmLength;//时长
	
	private String alternateName;//又名
	
	private double score;//豆瓣评分
	
	private int evaluationNum;//评论人数
	
	private double price;//价格
	
	private String brief;//影片简介
	
	private int sales;//销量

	public FilmDetail() {
		super();
	}

	public FilmDetail(String id, String releaseYear, String picture,
			String giantScreen, String title, String direct,
			String screenWriter, String leadingRole, String type, String state,
			String language, String releaseDate, String filmLength,
			String alternateName, double score, int evaluationNum,
			double price, String brief, int sales) {
		super();
		this.id = id;
		this.releaseYear = releaseYear;
		this.picture = picture;
		this.giantScreen = giantScreen;
		this.title = title;
		this.direct = direct;
		this.screenWriter = screenWriter;
		this.leadingRole = leadingRole;
		this.type = type;
		this.state = state;
		this.language = language;
		this.releaseDate = releaseDate;
		this.filmLength = filmLength;
		this.alternateName = alternateName;
		this.score = score;
		this.evaluationNum = evaluationNum;
		this.price = price;
		this.brief = brief;
		this.sales = sales;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getReleaseYear() {
		return releaseYear;
	}

	public void setReleaseYear(String releaseYear) {
		this.releaseYear = releaseYear;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getGiantScreen() {
		return giantScreen;
	}

	public void setGiantScreen(String giantScreen) {
		this.giantScreen = giantScreen;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDirect() {
		return direct;
	}

	public void setDirect(String direct) {
		this.direct = direct;
	}

	public String getScreenWriter() {
		return screenWriter;
	}

	public void setScreenWriter(String screenWriter) {
		this.screenWriter = screenWriter;
	}

	public String getLeadingRole() {
		return leadingRole;
	}

	public void setLeadingRole(String leadingRole) {
		this.leadingRole = leadingRole;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getFilmLength() {
		return filmLength;
	}

	public void setFilmLength(String filmLength) {
		this.filmLength = filmLength;
	}

	public String getAlternateName() {
		return alternateName;
	}

	public void setAlternateName(String alternateName) {
		this.alternateName = alternateName;
	}

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	public int getEvaluationNum() {
		return evaluationNum;
	}

	public void setEvaluationNum(int evaluationNum) {
		this.evaluationNum = evaluationNum;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
	
	
	public String getBrief() {
		return brief;
	}

	public void setBrief(String brief) {
		this.brief = brief;
	}

	public int getSales() {
		return sales;
	}

	public void setSales(int sales) {
		this.sales = sales;
	}

	@Override
	public Object clone(){
		FilmDetail filmDetail = null;
		try {
			filmDetail = (FilmDetail)super.clone();
		} catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return filmDetail;
	}
}
