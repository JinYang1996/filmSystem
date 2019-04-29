<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>项目完成情况</title>
    
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
  	完成情况
    	1.SSM框架的搭建，能够连接数据库查看数据库信息
    	2.创建jdbc.properties文件  连接池中的信息从该文件中获取
    	3.在web.xml中捕获错误代码页面 如：404 500  跳转到自定义的错误页面
    	4.使用MD5加密算法对注册的密码进行加密
    	5.使用httpClient和Jsoup来解析豆瓣网的电影信息，并将数据一一对应写入到数据库中。
    	6.将保存的电影信息中的类型使用数组来存储，便于添加和修改。
    	7.画出主页的静态html5页面，并改为jsp文件
    	8.完成主页的巨幕图片显示
    	9.完成主页的电影信息的分页显示
    	10.完成用户的登录/注册
    	11.完成数据库文档，并创建数据库    2018-02-14
  </body>
</html>
