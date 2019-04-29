package com.neusoft.common.page;

import java.util.List;

public class Page {

	public int pageSize = 6;//每页多少条
	
	public int pageNo;//页码数
	
	public int sumCount;//总条数
	
	public int sumPage;//总页码数
	
	public int startRow;//开始位置
	
	public List data;//查询出的数据
	
	public int getPage(){
		if(sumCount % pageSize == 0){
			sumPage = sumCount / pageSize;
		}else{
			sumPage = sumCount / pageSize + 1;
		}
		return sumPage;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getSumCount() {
		return sumCount;
	}

	public void setSumCount(int sumCount) {
		this.sumCount = sumCount;
	}

	public int getSumPage() {
		return sumPage;
	}

	public void setSumPage(int sumPage) {
		if(sumCount % pageSize == 0){
			this.sumPage = sumCount / pageSize;
		}else{
			this.sumPage = sumCount / pageSize + 1;
		}
	}

	public int getStartRow() {
		startRow = (pageNo-1) * pageSize;
		return startRow;
	}

	public List getData() {
		return data;
	}

	public void setData(List data) {
		this.data = data;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
}
