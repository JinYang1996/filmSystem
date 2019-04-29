<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>管理员界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="css/admin_manage.css">
  </head>
  <style type="text/css">
  	.inul li a{
  		font-size:16px;
  	}
  </style>
  
  <body>
    <!-- <div class="all">
    	<div class="head">后台管理</div>
    	<div class="content">
    		<div class="left_list left">
				<ul>
					<li><a href="filmDetail/showFilm" target="toright" id="showFilm">电影列表</a>
					<li><a href="javascript:void(0)" target="toright" id="showReview">审核列表</a>
						<ul class="inul">
							<li><a href="javascript:void(0)" target="toright">审核拼团申请</a></li>
							<li><a href="javascript:void(0)" target="toright">审核取消拼团申请</a></li>
							<li><a href="javascript:void(0)" target="toright">审核取消参团申请</a></li>
						</ul>
					</li>
					<li><a href="videoHall/selAllVideoHall" target="toright">影院列表</a></li>
					<li><a href="theaterArrange/showAllArrange" target="toright">影院安排列表</a></li>
					<li><a href="javascript:void(0)">收藏列表</a></li>
					<li><a href="views/modules/front/film/homePage.jsp">返回主页</a></li>
				</ul>
			</div>
    		<div class="right_content right">
    			<iframe scrolling="auto" width="1099px" height="600px" name="toright" src="filmDetail/showFilm"></iframe>
    		</div>
    	</div>
    </div> -->
  </body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$("#showReview").click(function(){
		$(".inul").slideToggle();
	});
</script>
</html>
