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
</style>
<body>
<div class="panel admin-panel" style="width:800px;margin:20px auto">
    <div class="panel-head"><strong><span class="icon-key"></span>影院详情表</strong></div>
    <div class="body-content">
    		<div>
           		<span class="right">
           			<button class="btn btn-primary" style="margin-bottom:10px;margin-right:10px;" onclick="toAdd()">添加影厅</button>
           		</span>
           	</div>
            <div class="form-group">
            	<table class="table table-hover text-center">
            		<tr>
            			<th>序号</th>
            			<th>影厅名</th>
            			<th>影厅规格-行</th>
            			<th>影厅规格-列</th>
            			<th>操作</th>
            		</tr>
            		<c:forEach items="${hallList }" var="hall" varStatus="s">
            		 	<tr>
            		 		<td>${s.count }</td>
            		 		<td>${hall.hallName }</td>
            		 		<td>${hall.hallRow }</td>
            		 		<td>${hall.hallCol }</td>
            		 		<td><a href="seat/toAddSeat?hallName=${hall.hallName }" class="btn btn-success">查看座位表</a>
            		 			<a href="javascript:void(0)" onclick="del('${hall.id}')" class="btn btn-danger">删除</a>
            		 		</td>
            		 	</tr>
            		</c:forEach>
            	</table>
            </div>
    </div>
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	function toAdd(){
		location.href="videoHall/toAddVideoHall";
	}
	
	function del(id){
		if(confirm("确定要删除该影厅信息吗？")){
			$.ajax({
				url:"videoHall/delVideoHall",
				data:{id:id},
				dataType:"json",
				type:"post",
				success:function(data){
					if(data == '2'){
						alert("该放映厅被占用，删除失败");
					}
					window.location.reload();
				}
			});
		}
	}
</script>
</html>