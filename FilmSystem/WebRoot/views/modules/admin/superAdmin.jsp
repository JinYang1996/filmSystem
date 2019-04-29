<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>管理界面</title>

    <!-- BOOTSTRAP STYLES-->
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <!-- FONTAWESOME STYLES-->
    <link href="../css/font-awesome.css" rel="stylesheet" />
       <!--CUSTOM BASIC STYLES-->
    <link href="../css/basic.css" rel="stylesheet" />
    <!--CUSTOM MAIN STYLES-->
    <link href="../css/custom.css" rel="stylesheet" />
    <!-- GOOGLE FONTS-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <style type="text/css">
    	::-webkit-scrollbar {
		   width: 0.2em;
		}
    </style>
</head>
<body>
    <div id="wrapper">
        <nav class="navbar navbar-default navbar-cls-top " role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand">管理中心</a>
            </div>

            <div class="header-right">

                <a href="../fightTicket/selSales" class="btn btn-info" target="toright" title="New Message"><b>销量</b><i class="fa fa-envelope-o fa-2x"></i></a>
                <a href="../views/modules/integral/integral.jsp" id="task" class="btn btn-primary" title="New Task" target="toright"><b>规则 </b><i class="fa fa-bars fa-2x"></i></a> 
                <a id="logout" class="btn btn-danger" title="Logout"><i class="fa fa-exclamation-circle fa-2x"></i></a>

            </div>
        </nav>
        <!-- /. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
                    <li>
                        <div class="user-img-div">
                            <img src="../${user.photo }" class="img-thumbnail" />

                            <div class="inner-text">
                              		 超级管理员
                            <br />
                                <small>上次登录时间 : <fmt:formatDate value="${user.lastLogin }" pattern="yyyy-MM-dd HH:mm:ss"/> </small>
                            </div>
                        </div>
                    </li>
                    <li>
                    	<a href="#"><i class="fa fa-dashboard " ></i>影片信息管理<span class="fa arrow"></span></a>
                         <ul class="nav nav-second-level">
                            <li>
                                <a href="../filmDetail/selByFilm?pageNo=0" target="toright" ><i class="fa fa-toggle-on"></i>电影列表</a>
                            </li>
                            <li>
                                <a href="../filmDetail/toAddFilm" target="toright" ><i class="fa fa-bell "></i>获取豆瓣影片信息</a>
                            </li>
                            <li>
                                <a href="../filmType/selFilmType" target="toright" ><i class="fa fa-edit "></i>电影类型管理</a>
                            </li>
                            <li>
                                <a href="../filmDetail/toAddNewFilm" target="toright" ><i class="fa fa-bell "></i>添加影片信息</a>
                            </li>
                        </ul>
                        
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-desktop " ></i>审核列表<span class="fa arrow"></span></a>
                         <ul class="nav nav-second-level">
                            <li>
                                <a href="../review/selReview?pageNo=0&type=1" target="toright" ><i class="fa fa-toggle-on"></i>审核拼单申请</a>
                            </li>
                            <li>
                                <a href="../review/selReview?pageNo=0&type=3" target="toright" ><i class="fa fa-bell "></i>审核取消拼单申请</a>
                            </li>
                            <li>
                                <a href="../review/selReview?pageNo=0&type=4" target="toright" ><i class="fa fa-edit "></i>审核取消参与拼单申请</a>
                            </li>
                            <li>
                                <a href="../applyArrange/selAllApply?pageNo=0" target="toright" ><i class="fa fa-eyedropper "></i>审核添加时间安排申请</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="../videoHall/selAllVideoHall" target="toright" ><i class="fa fa-yelp "></i>影院列表</a>
                    </li>
                    <li>
                        <a href="../theaterArrange/showAllArrange?pageNo=0" target="toright" ><i class="fa fa-coffee "></i>放映安排列表</a>
                    </li>
                    <li>
                        <a href="../coupon/showAllCoupon?pageNo=0" target="toright" ><i class="fa fa-flask "></i>优惠券列表</a>
                    </li> 
                   <li>
                        <a href="../account/selAccountBySuper?pageNo=0" target="toright" ><i class="fa fa-user "></i>用户管理列表</a>
                    </li>
                    <li>
                        <a href="../evaluate/selEvaluateByTerm?pageNo=0" target="toright" ><i class="fa fa-user "></i>评论管理列表</a>
                    </li>
                    <li>
                        <a href="../fightTicket/selAllFightByAdmin?pageNo=0" target="toright" ><i class="fa fa-user "></i>订单管理列表</a>
                    </li>
                </ul>

            </div>

        </nav>
        <div class="right_content" style="float:right">
   			<iframe scrolling="auto" frameborder="0" width="1090px" height="580px" name="toright" src="../filmDetail/selByFilm?pageNo=0"></iframe>
   		</div>
    </div>
    <!-- JQUERY SCRIPTS -->
    <script src="../js/jquery-1.10.2.js"></script>
    <!-- BOOTSTRAP SCRIPTS -->
    <script src="../js/bootstrap.js"></script>
    <!-- METISMENU SCRIPTS -->
    <script src="../js/jquery.metisMenu.js"></script>
       <!-- CUSTOM SCRIPTS -->
    <script src="../js/custom.js"></script>
    


</body>
<script type="text/javascript">
	$("#logout").click(function(){
		if(confirm("确定要退出吗？")){
			location.href="../account/logOff";
		}
	});
	$.getJSON("../review/getReviewCount",function(data){
		$("#message b").text(data+" ");
	});
</script>
</html>
