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
    <div class="panel-head"><strong><span class="icon-key"></span>销量排行</strong></div>
   	<div>
   		<table class="table">
   			<tr>
   				<th>序号</th>
   				<th>影片</th>
   				<th>影片名</th>
   				<th>销量</th>
   			</tr>
   			<c:forEach items="${filmList }" var="film" varStatus="s">
	   			<tr>
	   				<td style="vertical-align: middle">${s.count }</td>
	   				<td style="vertical-align: middle"><img src="${film.picture }" width="60px"></td>
	   				<td style="vertical-align: middle">${film.title }</td>
	   				<td style="vertical-align: middle">${film.sales }</td>
	   			</tr>
   			</c:forEach>
   			
   		</table>
    </div>
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	
</script>
</html>