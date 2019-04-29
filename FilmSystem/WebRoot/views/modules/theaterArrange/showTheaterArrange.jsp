<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
</head>
<style type="text/css">
    .form-x .form-group .label{
        width:100px;
    }
    .right{
    	float:right;
    }
    .table{
    	text-align:center;
    }
    .content td{
    	font-size:14px;
    }
</style>
<body>
<div class="panel admin-panel" style="width:1000px;margin:20px auto">
    <div class="panel-head"><strong><span class="icon-key"></span>放映安排详情表</strong></div>
   	<div class="container-fluid">
       	<form action="theaterArrange/showAllArrange" method="post" id="frm">
       		<div class="form-group" style="margin-top:20px;margin-left:5px">
       			<input type="hidden" name="pageNo" value="0">
       			<label>放映日期：</label>
       			<input type="date" class="form-control" name="releaseTime" value="${theaterArrange.releaseTime }" style="width:165px;display:inline-block">
       			
       			<label>影厅名</label>
       			<select class="form-control" name="videoHall.id" style="width:150px;display:inline-block">
       				<option value="">-----请选择-----</option>
       				<c:forEach items="${videoHallList }" var="hall">
       					<c:choose>
       						<c:when test="${hall.id == theaterArrange.videoHall.id }">
       							<option value="${hall.id }" selected>${hall.hallName }</option>
       						</c:when>
       						<c:otherwise>
       							<option value="${hall.id }">${hall.hallName }</option>
       						</c:otherwise>
       					</c:choose>
       				</c:forEach>
       			</select>
       			
       			<label>影片名：</label>
       			<input type="text" name="filmDetail.title" class="form-control" value="${theaterArrange.filmDetail.title }" style="width:165px;display:inline-block">
       			<p style="display:none" id="createD"><fmt:formatDate value="${theaterArrange.releaseTime }" pattern="yyyy-MM-dd"/></p>      			
       			<button onclick="sub()" class="btn btn-success" style="margin:-5px 0 0 40px">查询</button>
       			<button type="button" class="btn btn-primary" onclick="toAddArrange()" style="margin:-5px 0 0 40px">新增</button>
       		</div>
       	</form>
       </div>
    <div class="body-content">
            <div class="form-group">
                <table class="table">
                	<tr>
                		<td>放映日期</td>
                		<td>开始时间</td>
                		<td>结束时间</td>
                		<td>影厅名</td>
                		<td>影片名</td>
                		<td>优惠</td>
                		<td>操作</td>
                	</tr>
                	<c:forEach items="${page.data }" var="arrange">
	                	<tr class="content">
	                		<td style="line-height:33px;"><fmt:formatDate value="${arrange.releaseTime }" pattern="yyyy-MM-dd"/></td>
	                		<td style="line-height:33px;"><fmt:formatDate value="${arrange.startTime }" pattern="HH:mm"/></td>
	                		<td style="line-height:33px;"><fmt:formatDate value="${arrange.endTime }" pattern="HH:mm"/></td>
	                		<td style="line-height:33px;">${arrange.videoHall.hallName }</td>
	                		<td style="line-height:33px;">${arrange.filmDetail.title }</td>
	                		<td style="line-height:33px;">${arrange.coupon.couponName }:<fmt:formatNumber type="number" value="${arrange.coupon.couponPrice }" pattern="#.00"/>元</td>
	                		<td>
	                			<!-- <button class="btn btn-info">修改</button> -->
	                			<c:if test="${arrange.delFlag == '0' }">
	                				<button class="btn btn-danger" onclick="del('${arrange.id}')">删除</button>
	                			</c:if>
	                		</td>
	                	</tr>
                	</c:forEach>
                </table> 
                <div class="pagelist"> 
		    	<a onclick="toPage(this)" data-page="1" id="home" class="home left">首页</a>
		    	<c:if test="${page.pageNo>1 }">
		    		<a onclick="toPage(this)" data-page="${page.pageNo-1 }">上一页</a>
		    	</c:if>
		   		<span id="pNo"></span>
		   		<c:if test="${page.pageNo<page.sumPage }">
		   			<a onclick="toPage(this)" data-page="${page.pageNo+1 }">下一页</a>
		   		</c:if>
		   		<a onclick="toPage(this)" data-page="${page.sumPage }">尾页</a> 
            </div>
            <input type="hidden" id="page_no" value="${page.pageNo}"/>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	function toAddArrange(){
		location.href="theaterArrange/toAddArrange";
	}
	
	function del(id){
		if(confirm("确认要删除该条信息吗？")){
			location.href="theaterArrange/delArrange?arrangeId="+id;
		}
	}
	
	$(function(){
		var date = $("#createD").text();
		console.log(date);
		$("input[name='releaseTime']").val(date);
	
		var sumPage = '${page.sumPage}';
		for (i = 1; i <= sumPage; i++) {
			$("#pNo").append('<a id="num'+i+'" onclick="toPage(this)" data-page="'+i+'">'+i+'</a>');
		}
		var paNo = $("#page_no").val();
		$("#num"+paNo).css("background","#1CB2EF");
	});
	
	function toPage(p) {
		var paNo = $(p).attr("data-page");
		$("input[name='pageNo']").val(paNo);
		$("#frm").submit();
	}
</script>
</html>