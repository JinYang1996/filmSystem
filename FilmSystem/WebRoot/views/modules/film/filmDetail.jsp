<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>电影页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <style type="text/css">
  	.filmDetail{
  		width:200px;
  		height:330px;
  		border:1px solid #fff;
  		float:left;
  		margin-left:10px;
  	}
  	.filmDetail p{
  		height:13px;
  		font-size:13px;
  		text-align:center;
  		margin:5px;
  	}
  	.filmDetail:hover{
  		cursor:pointer;
  		border:1px solid red;
  	}
  </style>
  <body>
    <div>
    	<c:forEach items="${filmList }" var="film">
    		<div class="filmDetail">
    			<img src="${film.picture }" width="200" height="281"/>
    			<p>${film.title }</p>
    			<p>价格：${film.price }</p>
    			<input type="hidden" value="${film.id }"/>
    		</div>
    	</c:forEach>
    </div>
  </body>
  <script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
  <script type="text/javascript">
  	$(".filmDetail").click(function(){
  		$(this).children().each(function(index,item){
  			if($(this).prop("tagName") == "INPUT"){
  				location.href="filmDetail/getFilmDetail?id="+$(this).attr("value");
  			}
  		});
  		console.log($(this).children());
  	});
  </script>
</html>
