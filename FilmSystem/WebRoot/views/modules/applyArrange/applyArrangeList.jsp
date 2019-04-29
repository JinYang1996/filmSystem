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
    <div class="panel-head"><strong><span class="icon-key"></span>申请安排时间审核</strong></div>
    	<div class="container-fluid">
        	<form action="applyArrange/selAllApply" method="post" id="frm">
        		<div class="form-group" style="margin-top:20px;margin-left:5px">
        			<input type="hidden" name="pageNo" value="0">
        			<label>影片名：</label>
        			<input type="text" class="form-control" name="filmDetail.title" value="${applyArrange.filmDetail.title }" style="width:150px;display:inline-block">
        			
        			<label>审核状态</label>
        			<select class="form-control" id="reviewStatus" name="reviewStatus" style="width:150px;display:inline-block">
        				<option value="">-----请选择-----</option>
        				<option value="0">审核通过</option>
        				<option value="1">审核中</option>
        				<option value="2">审核失败</option>
        			</select>
        			
        			<label>申请时间：</label>
        			<input type="date" name="applyTime" class="form-control" style="width:165px;display:inline-block">
        			<p style="display:none" id="createD">${applyArrange.applyTime }<%-- <fmt:formatDate value="${applyArrange.applyTime }" pattern="yyyy-MM-dd"/> --%></p>      			
        			<button onclick="sub()" class="btn btn-success" style="margin:-5px 0 0 40px">查询</button>
        		</div>
        	</form>
        </div>
    <div class="body-content">
            <div class="form-group">
            	
                <table class="table">
                	<tr>
                		<td>序号</td>
                		<td>影片名</td>
                		<td>申请放映时间</td>
                		<td>影厅安排</td>
                		<td>申请人</td>
                		<td>操作</td>
                	</tr>
                	<c:forEach items="${page.data }" var="apply" varStatus="s">
	                	<tr class="content">
	                		<td style="line-height:33px;">${s.count }</td>
	                		<td style="line-height:33px;">${apply.filmDetail.title }</td>
	                		<td style="line-height:33px;">${apply.applyTime }</td>
	                		<td style="line-height:33px;">
	                			<c:if test="${apply.reviewStatus == '1' }">
	                				影厅安排中
	                			</c:if>
	                			<c:if test="${apply.reviewStatus == '0' }">
	                				已安排
	                			</c:if>
	                			<c:if test="${apply.reviewStatus == '2' }">
	                				无安排
	                			</c:if>
	                		</td>
	                		<td style="line-height:33px;">${apply.createBy }</td>
	                		<td style="line-height:33px;">
	                			<c:if test="${apply.reviewStatus == '1' }">
	                				<button type="button" class="btn btn-primary" onclick="toAddArrange('${apply.filmDetail.title}','${apply.applyTime }')">新增</button>
	                				<button type="button" class="btn btn-primary" onclick="toDelArrange('${apply.id}')">驳回</button>
	                			</c:if>
	                			<c:if test="${apply.reviewStatus != '1' }">
	                				<button type="button" class="btn btn-primary" onclick="selArrange('${apply.id}')">查看</button>
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
	function toAddArrange(title,applyTime){
		location.href="applyArrange/toAddApplyArrange?title="+title+"&applyTime="+applyTime;
	}
	
	function toDelArrange(id){
		if(confirm("确定要驳回吗？")){
			location.href="applyArrange/toDelArrange?id="+id;
		}
	}
	
	function selArrange(id){
		location.href="applyArrange/selArrange?id="+id;
	}
	
	$(function(){
		var status = '${applyArrange.reviewStatus}';
		console.log(status);
		$("#reviewStatus option").each(function(index,item){	
			console.log($(item).val());
			if($(item).val() == status){
				$(item).prop("selected","selected");
			}
		});
		var date = $("#createD").text();
		console.log(date);
		$("input[name='applyTime']").val(date);
		
		var sumPage = '${page.sumPage}';
		for (i = 1; i <= sumPage; i++) {
			$("#pNo").append('<a id="num'+i+'" onclick="toPage(this)" data-page="'+i+'">'+i+'</a>');
		}
		var paNo = $("#page_no").val();
		$("#num"+paNo).css("background","#1CB2EF");
		
		$("#message b",parent.document).text('${count}'+" ");
	});
	
	function toPage(p) {
		var paNo = $(p).attr("data-page");
		$("input[name='pageNo']").val(paNo);
		$("#frm").submit();
	}
</script>
</html>