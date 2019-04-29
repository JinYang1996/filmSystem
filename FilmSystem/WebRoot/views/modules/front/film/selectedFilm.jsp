<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'selected.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/reset.css">
    <link rel="stylesheet" type="text/css" href="css/homePage.css">
    <link rel="stylesheet" type="text/css" href="css/admin.css">
  </head>
  <style>
  	.giantScreen{
  		height:90px;
  		border-radius:5px 5px 0 0;
  	}
  	.showFilm{
  		background-color:rgb(237, 239, 240);
  		border-radius:0 0 5px 5px;
  		border:0;
  		position:relative;
  		height:2000px
  	}
  	.filmDetail{
  		width:100%;
  		height:27%;
  		/* border:1px solid red; */
  	}
  	.hotFilm{
  		border-right:0px;
  	}
  	.hotFilm h2{
  		font-size:18px;
  	}
  	.left{
  		float:left;
  	}
  	.filmIntroduce{
  		width:66%;
  		height:48%;
  		/* border:1px solid black; */
  	}
  	.logoCenter ul li a{
		border:0;
	}
  	.filmIntroduce li{
  		width:90%;
  		line-height:20px;
  		margin-left:20px;
  		margin-top:10px;
  		/* border:1px solid red; */
  	}
  	.arrange{
  		width:95%;
  		height:500px;
  		/* border:1px solid red; */
  		float:left;
  		margin:0 0 0 20px;
  	}
  	.arrange ul{
  		height:65px;
  		/* border:1px solid red; */
  		padding-left:70px;
  	}
  	.arrange ul li{
  		width:105px;
  		height:55px;
  		line-height:55px;
  		text-align:center;
  		border:1px solid #B0C4DE;
  		border-radius:5px;
  		float:left;
  		margin:5px 0 15px 10px;
  	}
  	.arrange ul li a{
  		color:#000;
  		text-decoration:none;
  		font-size:18px;
  	}
  	.arrange ul li:hover{
  		background-color:#D1EEEE;
  	}
  	.arrange table{
  		width:100%;
  	}
  	.arrange table tr{
  		text-align:center;
  	}
  	.arrangeHead{
  		height:45px;
  		line-height:45px;
  		background-color:#DEDEDE;
  	}
  	.arrangeHead td{
  		color:#000;
  		font-size:18px;
  		/* font-weight:bold; */
  	}
  	.arrangeContent td{
  		height:35px;
  		line-height:35px;
  	}
  	#seats{
  		width:50%;
  		height:80%;
  		position:fixed;
  		top:10%;
  		left:27%;
  		border:1px solid black;
  		background-color:#fff;
  		border-radius:5px;
  		display: none;
  	}
  	.seats_head{
  		width:100%;
  		height:40px;
  		line-height:40px;
  		border-bottom:1px solid grey;
  	}
  	.seats_head h2{
  		font-size:18px;
  		font-weight:bold;
  		line-height:40px;
  		margin-left:5px;
  		float:left;
  	}
  	.right{
  		float:right;
  	}
  	#closeChoose{
  		cursor:pointer;
  	}
  	#seat{
  		width:500px;
  		height:400px;
  		margin:0 auto;
  		padding-left:80px;
  		/* border:1px solid red; */
  		padding-top:30px;
  	}
  	.seatBorder{
    	display:block;
    	width:28px;
    	height:28px;
    	line-height:28px;
    	text-indent:5px;
    	background-color:#90EE90;
    	border-radius:5px;
    	margin-left:10px;
    	margin-top:10px;
    	float:left;
    }
    .seatRow{
    	display:block;
    	width:28px;
    	height:28px;
    	line-height:28px;
    	text-indent:7.5px;
    	border:1px solid blue;
    	margin-left:10px;
    	margin-top:10px;
    	border-radius:20px;
    	float:left;
    }
    .seatNull{
    	display:block;
    	width:28px;
    	height:28px;
    	line-height:28px;
    	text-indent:7.5px;
    	margin-left:10px;
    	margin-top:10px;
    	float:left;
    }
    a:hover{
    	cursor:pointer;
    }
    .screen{
    	width:100%;
    	height:30px;
    	text-align:center;
    }
    .screen h1{
    	font-size:16px;
    	color:#000;
    	line-height:30px;
    }
    .yes{
    	text-align:center;
    }
    .active{
    	background:#9AC0CD;
    }
    #brief{
    	width:100%;
    	height:15%;
    	/* border:1px solid red; */
    }
    #brief p{
    	font-size:16px;
    	line-height:28px;
    }
    #comment{
    	width:100%;
    	height:30%;
    	/* border:1px solid blue; */
    	margin-top:-300px;
    }
    .comment_all{
    	margin-top:10px;
    }
    .comment_head{
    	height:30px;
    	/* border:1px solid red; */
    	border-bottom:1px solid grey;
    }
    .comment_head span{
    	width:180px;
    	height:30px;
    	display:inline-block;
    	line-height:30px;
    	text-align:center;
    }
    .comment_content{
    	width:100%;
    	height:80px;
    	/* border:1px solid red; */
    }
    .comment_content p{
    	font-size:15px;
    	line-height:23px;
    	overflow : hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 3;
		-webkit-box-orient: vertical;
    }
    .create_comment{
    	width:499px;
    	height:300px;
    	border:1px solid grey;
    	position:fixed;
    	top:100px;
    	left:440px;
    	display:none;
    	z-index:2;
    	background-color:#fff;
    	border-radius:5px;
    }
    .comment_title h3{
    	height:40px;
    	line-height:40px;
    	border-bottom:1px solid grey;
    }
    .comment_title .go_comment{ 
    	font-size:18px;
    	font-weight:bold;
    	margin:15px 0 0 15px;
    }
    .seatBorder a{
    	opacity:0;
    }
    .demo{
		padding: 2em 0;
		background: linear-gradient(to right, #2c3b4e, #4a688a, #2c3b4e);
	  }
	  .progress{
		  height: 25px;
		  background: #262626;
		  padding: 5px;
		  overflow: visible;
		  border-radius: 20px;
		  border-top: 1px solid #000;
		  border-bottom: 1px solid #7992a8;
		  margin-top: 50px;
	  }
	  .progress .progress-bar{
		  border-radius: 20px;
		  position: relative;
		  animation: animate-positive 2s;
	  }
	  .progress .progress-value{
		  display: block;
		  padding: 3px 7px;
		  font-size: 13px;
		  color: #fff;
		  border-radius: 4px;
		  background: #191919;
		  border: 1px solid #000;
		  position: absolute;
		  top: -40px;
		  right: -10px;
	  }
	  .progress .progress-value:after{
		  content: "";
		  border-top: 10px solid #191919;
		  border-left: 10px solid transparent;
		  border-right: 10px solid transparent;
		  position: absolute;
		  bottom: -6px;
		  left: 26%;
	  }
	  .progress-bar.active{
		  animation: reverse progress-bar-stripes 0.40s linear infinite, animate-positive 2s;
	  }
	  @-webkit-keyframes animate-positive{
		  0% { width: 0; }
	  }
	  @keyframes animate-positive{
		  0% { width: 0; }
	  }
  </style>
  <body>
  	 <div class="all">
        <div class="container giantScreen">
            <div class="head">
                <div class="logoLeft">
                    <a class="navbar-brand" href="#"><img alt="Brand" id="logo"  src="images/logo.png"></a>
                </div>
               <div class="logoCenter">
                  <!--  <ul>
                       <li><span class="comic"><a href="#">comic</a></span></li>
                       <li><span class="movie"><a href="#">movie</a></span></li>
                       <li><span class="video"><a href="#">video</a></span></li>
                       <li><span class="game"><a href="#">game</a></span></li>
                       <li><span class="tv"><a href="#">tv</a></span></li>
                       <li><span class="more"><a href="#">more</a></span></li>
                   </ul> -->
               </div>
                <div class="personal">
                	<c:choose>
                		<c:when test="${not empty user.userName and not empty user.photo and user.role.id == '1'}">
	                		<a href="views/modules/front/person/person_pa.jsp"><img src="${user.photo }" width="45px" height="45px" style="border-radius:50%"></a>
		                    <div class="personal_name"><a href="views/modules/front/person/person_pa.jsp">${user.userName }</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id="logOff">注销</a></div>
                		</c:when>
                		<c:when test="${not empty user.userName and user.role.id == '2'}">
                			<a href="account/toJumpPage">
                				<c:if test="${empty user.photo }">
                					<img src="images/user2.jpg" width="45px" height="45px" style="border-radius:50%">
                				</c:if>
                				<c:if test="${not empty user.photo }">
                					<img src="${user.photo }" width="45px" height="45px" style="border-radius:50%">
                				</c:if>
                			</a>
			                <div class="personal_name"><a href="account/toJumpPage">${user.userName }</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id="logOff">注销</a></div>
                		</c:when>
                		<c:otherwise>
	                    	<a href="#"><img src="images/p1.png" width="45px" height="45px" style="border-radius:50%"></a>
			                <div class="personal_name"><a href="account/toLogin">请登录</a></div>
	                    </c:otherwise>
                	</c:choose>
                </div>
            </div>
        </div>
        <div class="container showFilm">
            <div class="col-md-9" style="border-right: 1px solid grey">
                <div class="hotFilm">
                    <h2>${film.title }（${film.releaseYear}）</h2>
                    <div class="filmDetail">
                    	<div class="left">
                    		<img src="${film.picture }"/>
                    	</div>
                    	<ul class="filmIntroduce left">
                    		<li>导演：${film.direct }</li>
                    		<li>编剧：${film.screenWriter }</li>
                    		<li>主演：${film.leadingRole }</li>
                    		<li>类型：${type }</li>
                    		<c:if test="${not empty film.state}"><li>制片国家/地区：${film.state }</li></c:if>
                    		
                    		<c:if test="${not empty film.language }"><li>语言：${film.language }</li></c:if>
                    		
                    		<c:if test="${not empty film.releaseDate }"><li>上映日期：${film.releaseDate }</li></c:if>
                    		
                    		<c:if test="${not empty film.filmLength }"><li>片长：${film.filmLength }</li></c:if>
                    		
                    		<c:if test="${not empty film.alternateName }"><li>又名：${film.alternateName }</li></c:if>
                    		<c:if test="${not empty film.score }"><li>豆瓣评分：${film.score }</li></c:if>
                    		<li>
                    			<c:if test="${not empty collect }">
                    				<button class="btn btn-success" id="collect">已收藏</button>
                    			</c:if>
                    			<c:if test="${empty collect }">
                    				<button class="btn btn-success" id="collect" onclick="collect('${film.id}')">收藏本影片</button>
                    			</c:if>
                    		</li>
                    	</ul>
                    	
                    </div>
                    <div id="brief">
                   		<h2>剧情简介</h2>
                   		<p>
	                   		<c:if test="${film.brief == null }">
	                   			暂无
	                   		</c:if>
	                   		<c:if test="${film.brief != null }">
	                   			${film.brief }
	                   		</c:if>
                   		</p>
                   	</div>
                   	<div class="arrange">
                   		<ul id="arrangeTime">
                   		</ul>
                   		<table id="arr">
                   			<tr class="arrangeHead">
                   				<td>时间</td>
                   				<td>语言</td>
                   				<td>放映厅</td>
                   				<td>优惠</td>
                   				<td>价格</td>
                   				<td>选座/预览</td>
                   			</tr>                 
                   			<c:if test="${not empty arrangeList }"> 			
                    			<c:forEach items="${arrangeList }" var="arrange">
                    				<tr class="arrangeContent">
	                    				<td><fmt:formatDate value="${arrange.startTime }" pattern="HH:mm"/>-<fmt:formatDate value="${arrange.endTime }" pattern="HH:mm"/></td>
	                    				<td>原版</td>
	                    				<td>${arrange.videoHall.hallName }</td>
	                    				<td>${coupon.couponName }:<fmt:formatNumber type="number" value="${coupon.couponPrice }" pattern="#.00"/>元</td>
	                    				<td><fmt:formatNumber type="number" value="${film.price-coupon.couponPrice }" pattern="#.00"/>元</td>
	                    				<td>
	                    					<c:if test="${arrange.isFight == '0' }">
	                    						<button onclick="chooseSeat('${arrange.videoHall.id}','${arrange.id }','${arrange.isFight }')" class="btn btn-danger">发起拼单</button>
	                    					</c:if>
	                    					<c:if test="${arrange.isFight == '1' }">
	                    						<button onclick="chooseSeat('${arrange.videoHall.id}','${arrange.id }','${arrange.isFight }')" class="btn btn-warning">参与拼单</button>
	                    					</c:if>
	                    				</td>
                    				</tr>
                    			</c:forEach>
                   			</c:if>  
                   			<c:if test="${empty arrangeList }"> 
                   				<tr><td colspan="6"><h1 style="font-size:30px;margin-top:30px">今日已无安排</h1></td></tr>
                   			</c:if>
                   		</table>
                  	</div>
                </div>
                <div id="comment">
                	<h2 style="font-size:16px">影片短评<a onclick="toComment()" class="right">我来写短评</a></h2>
                	
                </div>
                <div style="text-align:center">
	                <button class="btn btn-info" onclick="toPage(this)" id="up">上一页</button>
	                <button class="btn btn-info" onclick="toPage(this)" id="down">下一页</button>
                </div>
            </div>
            <div class="col-md-3">
                <div class="ranking">
                    <h2>电影排行榜</h2>
                    <ul>
                        
                    </ul>
                </div>
            </div>
        </div>
        <div id="seats">
        	<div class="seats_head">
        		<h2>影片选座</h2>
        		<a class="right" id="closeChoose"><img src="images/close.jpg" width="30px" style="margin:6px 8px 0 0"></a>
        		<p style="clear:both"></p>
        		<div class="screen">
        			
          		</div>
        		<div id="seat">
        			
        		</div>
        		<div class="col-md-offset-3 col-md-6" style="margin-top:-100px">
        			<div class="progress">
						<div class="progress-bar progress-bar-danger progress-bar-striped active" id="bar">
							<div class="progress-value"></div>
						</div>
					</div>
				</div>
        		<div class="yes">
        			<input type="hidden" id="arrangeId">
        			<input type="hidden" id="isFight">
        			<button class="btn btn-warning" onclick="submitInfo()">提交信息</button>
        		</div>
        	</div>
        </div>
        
    </div>
    <div class="container">
        <footer id="footer">
            <div id="footer-3d">
                <div class="gp-container">
                    <span class="first-widget-bend"></span>
                </div>
            </div>
            <div id="footer-widgets" class="gp-footer-larger-first-col">
                <div class="gp-container">
                    <div class="footer-widget footer-1">
                        <div class="wpb_wrapper">
                            <img src="images/f_logo.png" alt=""/>
                        </div>
                        <br>
                        <p>享影网 分享优质影片</p>
                        <br>
                        <p class="text" style="font-size:13px">SSL证书服务商 网站安全联盟 </p>
                        <p style="font-size:13px">Copyright 2017-2018 © 享影网 版权所有</p>
                    </div>
                    <div class="footer_box">
                        <div class="col_1_of_3 span_1_of_3">
                            <h3>Categories</h3>
                            <ul class="first">
                                <li><a href="#">Dance</a></li>
                                <li><a href="#">History</a></li>
                                <li><a href="#">Specials</a></li>
                            </ul>
                        </div>
                        <div class="col_1_of_3 span_1_of_3">
                            <h3>Information</h3>
                            <ul class="first">
                                <li><a href="#">New products</a></li>
                                <li><a href="#">top sellers</a></li>
                                <li><a href="#">Specials</a></li>
                            </ul>
                        </div>
                        <div class="col_1_of_3 span_1_of_3">
                            <h3>Follow Us</h3>
                            <ul class="first">
                                <li><a href="#">Facebook</a></li>
                                <li><a href="#">Twitter</a></li>
                                <li><a href="#">Youtube</a></li>
                            </ul>
                            <div class="copy">
                                <p>Copyright &copy; 2018.Company name All rights reserved.</p>
                            </div>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </div>
        </footer>
    </div>
    <div class="create_comment">
		<div class="comment_title">
            <h3><span class="go_comment">发表评论</span>
            	<span>
            		<a class="right" onclick="closeBg()">
            			<img src="images/close.jpg" width="30px" style="margin:6px 8px 0 0">
            		</a>
            	</span>
            </h3>
        </div>
        <div class="create_context">
        	<form action="" method="post">
	        	<textarea rows="20" cols="72" name="content" style="height:220px"></textarea>
	            <button type="button" onclick="tocreateComment()" class="btn btn-primary right" >发表</button>
        	</form>
        </div>
	</div>
  </body>
  <script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  	
    $(".logoCenter ul li span").mouseover(function(){
        $(this).children("a").show(120);
    });
    $(".logoCenter ul li span").mouseout(function(){
        $(this).children("a").hide(120);
    });
    
    var paNo=1;
    var sumPage;
    
    $(function(){
    	var myDate = new Date();
    	var today = myDate.getFullYear()+"-"+(myDate.getMonth() + 1)+"-"+myDate.getDate();
    	$("#arrangeTime").append('<li class="active"><a onclick="chooseTime(this)">'+today+'</a></li>');
    	
    	myDate.setDate(myDate.getDate()+1);
    	var tomorrow = myDate.getFullYear()+"-"+(myDate.getMonth() + 1)+"-"+myDate.getDate();
    	$("#arrangeTime").append('<li><a onclick="chooseTime(this)">'+tomorrow+'</a></li>');
    	
    	myDate.setDate(myDate.getDate()+1);
    	var threeDay = myDate.getFullYear()+"-"+(myDate.getMonth() + 1)+"-"+myDate.getDate();
    	$("#arrangeTime").append('<li><a onclick="chooseTime(this)">'+threeDay+'</a></li>');
    	
    	myDate.setDate(myDate.getDate()+1);
    	var fourDay = myDate.getFullYear()+"-"+(myDate.getMonth() + 1)+"-"+myDate.getDate();
    	$("#arrangeTime").append('<li><a onclick="chooseTime(this)">'+fourDay+'</a></li>');
    	
    	myDate.setDate(myDate.getDate()+1);
    	var fiveDay = myDate.getFullYear()+"-"+(myDate.getMonth() + 1)+"-"+myDate.getDate();
    	$("#arrangeTime").append('<li><a onclick="chooseTime(this)">'+fiveDay+'</a></li>');
    	
    	console.log(today);
    	console.log(tomorrow);
    	console.log(threeDay);
    	console.log(fourDay);
    	console.log(fiveDay);
    	
    	
    	$.get("evaluate/selAllComment?pageNo="+paNo+"&filmId="+'${film.id}',function(data){
    		console.log(data);
    		sumPage = data.sumPage;
    		console.log(sumPage);
    		if(paNo=1){
				$("#up").attr("disabled",true);
			}
			if(sumPage == 1){
				$("#down").attr("disabled",true);
			}
			if(sumPage == 0){
				console.log(sumPage);
				$("#up").attr("disabled",true);
				$("#down").attr("disabled",true);
			}
    		$(data.data).each(function(index,item){
    			var commentDate = formatDay(item.createDate);
    			var id = "'" + item.id + "'";
    			console.log(id);
    			$("#comment").append('<div class="comment_all">'+
	                		'<div class="comment_head">'+
	                			'<span>评论人:'+item.account.account+'</span>'+
	                			'<span>评论时间：'+commentDate+'</span> '+
	                			'<span class="right"><a onclick="likeEvaluation('+id+')">赞</a><a id="like'+item.id+'">('+item.likes+')</a></span>'+
							'</div>'+
							'<div class="comment_content">'+
								'<p>'+item.content+'</p>'+
							'</div></div>');
    		});
    	});
    });
    
    function likeEvaluation(id){
    	$.ajax({
    		url:"evaluate/likeEvaluation",
    		data:{"id":id},
    		dataType:"json",
    		type:"post",
    		success:function(data){
    			$("#like"+id).text("("+data.likes+")");
    		}
    	});
    }
    
    /*日期格式转换*/
	function formatDay(NewDtime) {
		var dt = new Date(parseInt(NewDtime));
		var year = dt.getFullYear();
		var month = dt.getMonth() + 1;
		var date = dt.getDate();
		var hour = dt.getHours();
		var minute = dt.getMinutes();
		var second = dt.getSeconds();
		if(hour < 10){
			hour = "0"+hour;
		}
		if(minute < 10){
			minute = "0"+minute;
		}
		if(second < 10){
			second = "0"+second;
		}
		return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
	}
    
    function toPage(p){
		var text = $(p).text();
		if(text=='下一页'){
			paNo++;
		}
		if(text=='上一页'){
			paNo--;
		}
		console.log(paNo);
		$.ajax({
			url:"evaluate/selAllComment",
			data:{filmId:'${film.id}',pageNo:paNo},
			type:"post",
			dataType:"json",
			success:function(data){
				console.log(data);
				if(data!=null){
					$(".comment_all").remove();
					$(data.data).each(function(index,item){
						var commentDate = formatDay(item.createDate);
						var id = "'" + item.id + "'";
						$("#comment").append('<div class="comment_all">'+
	                		'<div class="comment_head">'+
	                			'<span>评论人:'+item.account.account+'</span>'+
	                			'<span>评论时间：'+commentDate+'</span> '+
	                			'<span class="right"><a onclick="likeEvaluation('+id+')">赞</a><a id="like'+item.id+'">('+item.likes+')</a></span>'+
							'</div>'+
							'<div class="comment_content">'+
								'<p>'+item.content+'</p>'+
							'</div></div>');
					});
				}
			},
			error:function(data){
				alert(data);
			}
		});
		if(paNo<=1){
			$("#up").attr("disabled",true);
			$("#down").attr("disabled",false);
		}
		if(paNo>=sumPage){
			$("#up").attr("disabled",false);
			$("#down").attr("disabled",true);
		}
		if(paNo>1&&paNo<sumPage){
			$("#up").attr("disabled",false);
			$("#down").attr("disabled",false);
		}
	}
    
    function chooseTime(time){
    	var releaseTime = $(time).text();
    	$("#arrangeTime").children().each(function(index,item){
    		$(item).attr("class","");
    	});
    	$(time).parent().attr("class","active");
    	$(".arrangeContent").remove();
    	$(".arrangeContent").children().remove();
    	$.ajax({
    		url:"theaterArrange/getCorrectArrange",
    		data:{filmId:'${film.id}',releaseTime:releaseTime},
    		dataType:"json",
    		type:"post",
    		success:function(data){
    			console.log(data.length);
    			if(data.length > 0){
    				$("#arr tr").nextAll().remove();
    				$(data).each(function(index,item){
	    				if($(".arrangeContent"+index).attr("class") == undefined){	
		   					$("#arr").append('<tr class="arrangeContent'+index+'"><td>'+formatDate(item.startTime)+'-'+formatDate(item.endTime)+'</td>'+
		                    				'<td>原版</td>'+
		                    				'<td>'+item.videoHall.hallName+'</td>'+
		                    				'<td>'+item.coupon.couponName+':'+item.coupon.couponPrice+'元</td>'+
		                    				'<td>'+(parseInt(item.filmDetail.price)-parseInt(item.coupon.couponPrice)).toFixed(2)+'元</td></tr>');
		    				$(".arrangeContent"+index+" td").css("line-height","35px");
		    				var videoId = "'"+item.videoHall.id+"'";
		    				var arrangeId = "'"+item.id+"'";
		    				console.log(arrangeId);
		    				$(".arrangeContent"+index+" button").remove();
		    				if(item.isFight == '0'){
			    				$(".arrangeContent"+index).append('<button onclick="chooseSeat('+videoId+','+arrangeId+','+item.isFight+')" class="btn btn-danger">发起拼单</button>');
			    			}
			    			if(item.isFight == '1'){
			    				$(".arrangeContent"+index).append('<button onclick="chooseSeat('+videoId+','+arrangeId+','+item.isFight+')" class="btn btn-warning">参与拼单</button>');
			    			}	
	    				}else{
	    					$(".arrangeContent"+index).remove();
	    				}
	    			});
    			}else{
    				console.log($("#arr tr").next());
    				$("#arr tr").nextAll().remove();
    				var myDate = new Date();
    				var today = myDate.getFullYear()+"-"+(myDate.getMonth() + 1)+"-"+myDate.getDate();
    				if(today == releaseTime){
    					$("#arr").append('<tr><td colspan="6"><h1 style="font-size:30px;margin-top:30px">今日已无安排</h1></td></tr>');
    				}else{
    					releaseTime = "'"+releaseTime+"'";
    					$("#arr").append('<tr><td colspan="6"><button class="btn btn-danger" style="margin-top:35px;" type="button" onclick="appoint('+releaseTime+')">预约</button></td></tr>');
    				}
    				
    			}
    		}
    	});
    }
    
    function appoint(releaseTime){
    	$.ajax({
    		url:"applyArrange/addApply",
    		data:{filmId:'${film.id}',releaseTime:releaseTime},
    		dataType:"json",
    		type:"post",
    		success:function(data){
    			if(data == '2'){
    				alert("请先登录！");
					location.href="views/modules/front/login/login.jsp";
    			}else if(data == '1'){
    				alert("已提交申请,请等候处理！");
    			}else if(data == '3'){
    				alert("申请审核中,请耐心等候！");
    			}
    		}
    	});
    }
    
    $.getJSON("filmDetail/selFilmByScore",function(data){
    	$(data).each(function(index,item){
    		$(".ranking ul").append('<li>'+(index+1)+'.<a href="filmDetail/selectedFilm?id='+item.id+'">'+item.title+'</a></li>');
    	});
    });
    
    function formatDate(NewDtime) {
		var dt = new Date(parseInt(NewDtime));
		var year = dt.getFullYear();
		var month = dt.getMonth() + 1;
		var date = dt.getDate();
		var hour = dt.getHours();
		var minute = dt.getMinutes();
		var second = dt.getSeconds();
		if(hour < 10){
			hour = "0"+hour;
		}
		if(minute < 10){
			minute = "0"+minute;
		}
		return hour + ":" + minute;
	}
    
    function chooseSeat(hallId,arrangeId,isFight){
    	$("#arrangeId").val(arrangeId);
    	$("#seats").css("display","block");
    	$("#isFight").val(isFight);
    	console.log(hallId);
    	console.log(arrangeId);
    	console.log(isFight);
    	
    	$.ajax({
    		type:"post",
    		url:"videoHall/getVideoSeat",
    		dataType:"json",
    		data:{hallId:hallId,arrangeId:arrangeId},
    		success:function(data){
    			if(data != null){
    				var row = data.hall.hallRow;
    				var col = data.hall.hallCol;
    				createSeat(row,col);
    				
    				var seats = 0;/*总座位数*/
    				var selSeats = 0;/*被选座位数*/
    				
    				$(data.seat).each(function(index,item){
						/* console.log(item); */
						$("#"+item.seatRow+item.seatNumber).css("background","rgb(255,239,213)");
						$("#"+item.seatRow+item.seatNumber).attr("data-choose","1");
						seats++;
					});
					$("#seat").children().each(function(index,item){
						if($(item).attr("data-choose") != 1 && $(item).attr("class") == "seatBorder"){
							$(item).attr("class","seatNull");
							$(item).text("");
						}
					});
					
					$(data.rowCol).each(function(index,item){
						$("#"+item).css("background","rgb(255,48,48)");
						$("#"+item+" a").attr("onclick","");
						selSeats += 1;
					});
					console.log(selSeats);
					$(".screen").append('<h1>'+data.hall.hallName+'荧幕     座位数:'+seats+'   剩余座位数:'+(seats-selSeats)+'</h1>');
					var payStatus ;
					if(data.payStatus == '1'){
						payStatus = "未支付";
					}else{
						payStatus = "已支付";
					}
					if(data.fightPeople != null){
						$(".screen").append('<h1>发起拼单人：'+data.fightPeople+'   支付状态：'+payStatus+'</h1>');
					}
					var percent = ((selSeats/seats)*100).toFixed(2)+"%";
					console.log(percent);
					$("#bar").css("width",percent);
					$(".progress-value").text(percent);
    			}
    		}
    	});
    };
    
    function createSeat(row,col){
		for(i=1 ; i<=row ; i++){
			$("#seat").append('<span class="seatRow">'+i.toString()+'</span>');
			for(j=1 ; j<=col ; j++){
				$("#seat").append('<span id="'+'row'+i.toString()+'col'+j.toString()+'" class="seatBorder">'+
				'<a onclick="changColor(this)">'+i.toString()+j.toString()+'</a></span>');
			}
			$("#seat").append('<br>');
		}
		$("#seat").append('<span class="seatNull"></span>');
		for(k=1 ; k<j ; k++){
			$("#seat").append('<span class="seatRow">'+k.toString()+'</span>');
		}
	}
    
    $("#closeChoose").click(function(){
    	$("#seats").css("display","none");
    	$("#seat").children().remove();
    	$(".screen").children().remove();
    });
    
    function changColor(seat){
		var isColor = $(seat).parent().css("background-color");
		console.log(isColor);
		if(isColor == "rgb(255, 239, 213)"){
			$(seat).parent().css("background","rgb(50,205,50)");
			$(seat).parent().attr("data-choose","0");
		}else{
			$(seat).parent().css("background","rgb(255,239,213)");
			$(seat).parent().attr("data-choose","1");
		}
	}
	
	function submitInfo(){
		var seatList = [];
		$("#seat .seatBorder").each(function(index,item){
			/* console.log($(item).attr("data-choose")); */
			if($(item).attr("data-choose") == 0){
				seatList.push($(item).attr("id"));
			}
		});
		if(seatList.length == 0){
			alert("请选择座位信息");
		}else if(seatList.length > 5){
			alert("最多可选择5个座位");
		}else{
			console.log();
			$.ajax({
				url:"fightTicket/addFightTicket",
				data:{arrangeId:$("#arrangeId").val(),seatList:seatList.toString(),isFight:$("#isFight").val()},
				dataType:"json",
				type:"post",
				success:function(data){
					if(data.flag == '2'){
						alert("请先登录！");
						location.href="views/modules/front/login/login.jsp";
					}else if(data.flag == '1'){
						alert("请尽快确认订单！");
						location.href="fightTicket/toSubmitOrder?fightId="+data.fightTicket.id;
					}else if(data.flag == '3'){
						alert("座位已被预约！请刷新重试！");
					}
				}
			});
		}
	}
	
	function collect(id){
		$.ajax({
			url:"collect/addCollect",
			data:{filmId:'${film.id}'},
			type:"post",
			dataType:"json",
			success:function(data){
				if(data == '1'){
					alert("请先登录！");
					location.href="views/modules/front/login/login.jsp";
				}else if(data == '2'){
					alert("添加成功！");
					$("#collect").text("已收藏");
				}else if(data == '3'){
					$("#collect").removeAttr("onclick");
				}
			}
		});
	}
	
	$("#logOff").click(function(){
  		if(confirm("是否要注销此账号？")){
  			$("#logOff").attr("href","account/logOff");
  		}
  	});
  	
  	function toComment(){
  		var user = '${user.userName}';
		if(user == ''){
			alert("请先登录！");
			location.href="views/modules/front/login/login.jsp";
		}else{
			$(".create_comment").show();
			$(".bg").css("opacity","0.9");
		}
	}
	function closeBg(){
		$(".create_comment").hide();
		$(".bg").css("opacity","1");
	}
	
	function tocreateComment(){
		var content = $("textarea[name='content']").val();
		if(content != ''){
			$.ajax({
				url:"evaluate/addComment",
				data:{filmId:'${film.id}',content:content},
				type:"post",
				dataType:"json",
				success:function(data){
					if(data != null){
						closeBg();
						console.log(data);
						
					}
				}
			});
			window.location.reload();
		}else{
			alert("评论内容不能为空");
		}
	}
  </script>
</html>
