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
    <style type="text/css">
    	body{
    		font-size:12px;
    	}
        table {
            table-layout: fixed;
        }
        td { white-space: nowrap;overflow: hidden;text-overflow: ellipsis;}
    </style>
</head>
<body>
<div>
    <div class="panel admin-panel">
        <div class="panel-head"><strong><span class="icon-key"></span>用户列表</strong></div>
        <div class="container-fluid">
        	<form action="evaluate/selEvaluateByTerm" method="post" id="frm">
        		<div class="form-group" style="margin-top:5px;margin-left:13px;">
        			<input type="hidden" name="pageNo" value="0">
        			<label>影片名：</label>
        			<input type="text" class="form-control" name="filmDetail.title" value="${evaluate.filmDetail.title }" style="width:150px;display:inline-block;">
        			
        			<label>用户名：</label>
        			<input type="text" class="form-control" name="account.userName" value="${evaluate.account.userName }" style="width:150px;display:inline-block">
        			
        			<label>审核状态：</label>
        			<select name="reviewStatus" id="reviewStatus" class="form-control" style="width:150px;display:inline-block">
        				<option value="">--请选择--</option>
  						<option value="1">审核中</option>
  						<option value="0">已通过</option>
  						<option value="2">未通过</option>
        			</select>
        			
        			<button onclick="sub()" class="btn btn-success" style="margin:-5px 0 0 40px">查询</button>
        		</div>
        	</form>
        </div>
        <table class="table table-hover text-center">
            <tr>
            	<th width="6%">序号</th>
                <th width="12%">用户名</th>
                <th width="12%">影片名</th>
                <th width="25%">评论内容</th>
                <th width="8%">点赞数</th>
                <th width="15%">审核状态</th>
                <th width="20%">评论时间</th>
                <th width="20%">操作</th>
            </tr>
     		<c:forEach items="${page.data }" var="evaluate" varStatus="s">
	            <tr>
	            	<td style="vertical-align: middle">${s.count }</td>
	                <td style="vertical-align: middle">${evaluate.account.userName }</td>
	                <td style="vertical-align: middle">${evaluate.filmDetail.title }</td>
	                <td style="vertical-align: middle">${evaluate.content }</td>
	                <td style="vertical-align: middle">${evaluate.likes }</td>
	                <td style="vertical-align: middle">
	                	<c:if test="${evaluate.reviewStatus == '1'}">审核中</c:if>
					 	<c:if test="${evaluate.reviewStatus == '0'}">已通过</c:if>
					 	<c:if test="${evaluate.reviewStatus == '2'}">未通过</c:if>
			 		</td>
	               	<td style="vertical-align: middle"><fmt:formatDate value="${evaluate.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                <td style="vertical-align: middle">
	                	<c:if test="${evaluate.reviewStatus == '1'}">
	                		<button type="button" onclick="review('${evaluate.id}')" class="btn btn-info">审核</button>
	                	</c:if>
	                	<c:if test="${evaluate.reviewStatus != '1'}">
	                		<button type="button" onclick="review('${evaluate.id}')" class="btn btn-info">查看</button>
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
        </div>
        <input type="hidden" id="page_no" value="${page.pageNo}"/>
    </div>
    
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	
	function upd(id){
		var paNo = $("#page_no").val();
		location.href="evaluate/passEvaluate?id="+id + "&pageNo="+ paNo;
	}
	
	function del(id){
		if(confirm("确定要驳回吗？")){
			var paNo = $("#page_no").val();
			location.href="filmDetail/delFilm?id="+id + "&pageNo="+ paNo;
		}
	}
	
	function review(id){
		location.href="evaluate/searchEvaluate?id="+id;
	}
	
	function sub(){
		$("#frm").submit();
	}
	
	$(function() {
		var sumPage = '${page.sumPage}';
		if(sumPage > 10){
			for (i = 1; i <= 10; i++) {
				$("#pNo").append('<a id="num'+i+'" onclick="toPage(this)" data-page="'+i+'">'+i+'</a>');
			}
			$("#pNo").append('<a>...</a>');
		}else{
			for (i = 1; i <= sumPage; i++) {
				$("#pNo").append('<a id="num'+i+'" onclick="toPage(this)" data-page="'+i+'">'+i+'</a>');
			}
		}
		var paNo = $("#page_no").val();
		$("#num"+paNo).css("background","#1CB2EF");
		
		var reviewStatus = '${evaluate.reviewStatus}';
		console.log(reviewStatus);
		$("#reviewStatus option").each(function(index,item){	
			console.log($(item).val());
			if($(item).val() == reviewStatus){
				$(item).prop("selected","selected");
			}
		});
	});
	
	function toPage(p) {
		var paNo = $(p).attr("data-page");
		$("input[name='pageNo']").val(paNo);
		$("#frm").submit();
	}
</script>
</html>