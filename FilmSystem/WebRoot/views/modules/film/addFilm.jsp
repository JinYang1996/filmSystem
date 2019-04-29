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
    
    <title>My JSP 'specifyFilm.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
  </head>
  <style type="text/css">
  		body{
  			font-size:18px;
  		}
	    .form-x .form-group .label{
	        width:100px;
	    }
	    .right{
	    	float:right;
	    }
	    td{
	    	vertical-align: middle;
	    }
	    .loading{
	  		width:96px;
	  		height:96px;
	  		/* border:1px solid red; */
	  		background:url(images/loading2.gif) no-repeat;
	  		position:fixed;
	  		top:100;
	  		left:300;
	  		border-radius:50%;
	  		display:none;
	  	}
	  	.loading_text{
	  		position:fixed;
	  		top:140;
	  		left:420;
	  		font-size:20px;
	  		font-weight: bold; 
	  		color: #535e66;
	  		display:none;
	  	}
	  	.showTicket{
			width:350px;
			height:330px;
			border:1px solid grey;
			border-radius:5px;
			position:fixed;
			top:80;
	  		left:250;
	  		background-color:#fff;
	  		display:none;
	  	}
	  	.showTicket button{
	  		position:fixed;
	  		top:330;
	  		left:390;
	  		font-size:20px;
	  		font-weight: bold; 
	  		color: #535e66;
	  		display:none;
	  	}
	</style>
  <body>
    <div class="panel admin-panel" style="width:800px;margin:20px auto">
	    <div class="panel-head"><strong><span class="icon-key"></span>获取豆瓣电影信息</strong></div>
	    <div class="body-content">
	        <div class="form-group">
	           	 第一步：<button onclick="addFilm()" class="btn btn-success" style="margin:-5px 0 0 40px">获取影片信息</button>
	                                     第二步：<button onclick="changeType()" class="btn btn-info" style="margin:-5px 0 0 40px">更改影片类型</button>
	        </div>
	    </div>
	</div>
	<div class="showTicket">
   		<span class="loading"></span> 
   		<span class="loading_text">请稍后！</span>
   		<button class="btn btn-warning" id="subBtn" onclick="toSubmit()">确认</button>
   	</div>
  </body>
    <script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
    	function addFilm(){
    		$(".all").css("opacity","0.6");
	  		$(".showTicket").show();
	  		$(".loading").show();
	  		$(".loading_text").show();
    		$.get("filmDetail/addFilm",function(data){
    			$(".loading").css("background","url(images/icons.png) no-repeat");
		  		$(".loading").css("background-position","0 -96px");
		  		$(".loading").css("background-size","192px 276px");
		  		$(".loading_text").text("已完成！");
		  		$("#subBtn").show();
    		});
    	}
    	
    	function toSubmit(){
    		$(".showTicket").hide();
    	}
    	
    	function changeType(){
    		location.href="filmType/changeFilmType";
    	}
    	
    	
    </script>
</html>
