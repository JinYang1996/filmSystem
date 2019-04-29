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
    
    <title>My JSP 'showPartFilm.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <table>
    	<c:forEach items="${page.data }" var="film">
	    	<tr>
	    		<td>${film.title }</td>
	    		<td>${film.type }</td>
	    	</tr>
    	</c:forEach>
    </table>
    <a onclick="toPage(this)" data-page="${page.pageNo-1 }">上一页</a>
    <a onclick="toPage(this)" data-page="${page.pageNo+1 }">下一页</a>
  </body>
  <script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
  <script type="text/javascript">
  	function toPage(page){
  		var pageNo = $(page).attr("data-page");
  		location.href = "filmDetail/showPartFilm?pageNo="+pageNo;
  	}  	
  </script>
</html>
