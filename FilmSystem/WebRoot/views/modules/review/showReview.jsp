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
    	white-space: nowrap;
    	overflow: hidden;
    	text-overflow: ellipsis;
    }
</style>
<body>
<div class="panel admin-panel" style="width:1000px;margin:20px auto">
    <div class="panel-head"><strong><span class="icon-key"></span>申请审核表</strong></div>
    	<div class="container-fluid">
        	<form action="review/selReview" method="post" id="frm">
        		<div class="form-group" style="margin-top:20px;margin-left:5px">
        			<input type="hidden" name="pageNo" value="0">
        			<input type="hidden" name="type" value="${review.type }">
        			<label>影片名：</label>
        			<input type="text" class="form-control" name="fightTicket.filmDetail.title" value="${review.fightTicket.filmDetail.title }" style="width:150px;display:inline-block">
        			
        			<label>审核状态</label>
        			<select class="form-control" id="reviewStatus" name="reviewStatus" style="width:150px;display:inline-block">
        				<option value="">-----请选择-----</option>
        				<option value="0">审核通过</option>
        				<option value="1">审核中</option>
        				<option value="2">审核失败</option>
        			</select>
        			
        			<label>申请时间：</label>
        			<input type="date" name="createDate" class="form-control" style="width:165px;display:inline-block">
        			<p style="display:none" id="createD"><fmt:formatDate value="${review.createDate }" pattern="yyyy-MM-dd"/></p>      			
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
                		<td>影厅</td>
                		<td>放映日期</td>
                		<td>时间段</td>
                		<td>审核类型</td>
                		<td>审核状态</td>
                		<td>参与率</td>
                		<td>申请人</td>
                		<td>申请时间</td>
                		<td>操作</td>
                	</tr>
                	<c:forEach items="${page.data }" var="review" varStatus="s">
	                	<tr class="content">
	                		<td style="line-height:33px;">${s.count }</td>
	                		<td style="line-height:33px;">${review.fightTicket.filmDetail.title }</td>
	                		<td style="line-height:33px;">${review.fightTicket.theaterArrange.videoHall.hallName }</td>
	                		<td style="line-height:33px;"><fmt:formatDate value="${review.fightTicket.theaterArrange.releaseTime}" pattern="yyyy-MM-dd"/></td>
	                		<td style="line-height:33px;">
	                			<fmt:formatDate value="${review.fightTicket.theaterArrange.startTime }" pattern="HH:mm"/>-<fmt:formatDate value="${review.fightTicket.theaterArrange.endTime }" pattern="HH:mm"/></td>
	                		<td style="line-height:33px;">
	                			<c:if test="${review.type == '1' }">
	                				发起拼单
	                			</c:if>
	                			<c:if test="${review.type == '2' }">
	                				参与拼单
	                			</c:if>
	                			<c:if test="${review.type == '3' }">
	                				取消拼单
	                			</c:if>
	                			<c:if test="${review.type == '4' }">
	                				取消参与拼单
	                			</c:if>
	                		</td>
	                		<td style="line-height:33px;">
	                			<c:if test="${review.reviewStatus == '1' }">
	                				审核中
	                			</c:if>
	                			<c:if test="${review.reviewStatus == '0' }">
	                				审核通过
	                			</c:if>
	                			<c:if test="${review.reviewStatus == '3' }">
	                				审核失败
	                			</c:if>
	                		</td>
	                		<td style="line-height:33px;">${review.sumPer }</td>
	                		<td style="line-height:33px;">${review.createBy }</td>
	                		<td style="line-height:33px;"><fmt:formatDate value="${review.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                		<td>
	                			<c:if test="${review.reviewStatus == '1' }">
	                				<button type="button" class="btn btn-info" onclick="pass('${review.id}')">通过</button>
	                				<button type="button" class="btn btn-danger" onclick="del('${review.id}')">驳回</button>
	                			</c:if>
	                			<c:if test="${review.reviewStatus == '0' }">
	                				<button type="button" class="btn btn-warning">已通过</button>
	                			</c:if>
	                			<c:if test="${review.reviewStatus == '3' }">
	                				<button type="button" class="btn btn-warning">已驳回</button>
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
	function pass(id){
		var paNo = $("#page_no").val();
		location.href="review/passReview?id="+id + "&pageNo="+ paNo +"&type=" +'${review.type}';
	}
	
	function del(id){
		if(confirm("确认要驳回该条申请吗？")){
			var paNo = $("#page_no").val();
			location.href="review/rebutReview?id="+id + "&pageNo="+ paNo+"&type=" +'${review.type}';
		}
	}
	
	$(function(){
		var status = '${review.reviewStatus}';
		console.log(status);
		$("#reviewStatus option").each(function(index,item){	
			console.log($(item).val());
			if($(item).val() == status){
				$(item).prop("selected","selected");
			}
		});
		var date = $("#createD").text();
		console.log(date);
		$("input[name='createDate']").val(date);
		
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