<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
	<base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/reset.css">
    <link rel="stylesheet" type="text/css" href="css/homePage.css">
    <link rel="stylesheet" type="text/css" href="css/admin.css">
    <style type="text/css">
    	body{
		    color:#fff;
		    background-color:grey;
		    font-size:16px;
		}
		.logoCenter ul li a{
			border:0;
		}
    	.showHot{
			width:100%;
			height:820px;
		}
		.pageList{
			width:100%;
			height:80px;
			float:left;
			margin-top:20px;
		}
		.showHot{
			border:1px solid #fff;
		}
		.notice{
			width:98%;
			height:32%;
			border:1px solid #F2F2F2;
		}
		.right{
			float:right;
		}
		.newFight li{
			height:100px;
			border-bottom:1px dotted grey;
			font-size:14px;
		}
		.newFight li p:nth-child(1),p:nth-child(2){
			display:block;
			width:40%;
			height:50px;
			line-height:50px;
			white-space:nowrap; 
			text-overflow:ellipsis; 
			overflow:hidden;
			float:left;
		}
		.newFight li p:nth-child(3),p:nth-child(4){
			display:block;
			width:40%;
			height:50px;
			line-height:50px;
			white-space:nowrap; 
			text-overflow:ellipsis; 
			overflow:hidden;
			float:left;
		}
		.newFight li p:last-child{
			display:block;
			width:12%;
			height:50px;
			line-height:50px;
			padding-top:8px;
			float:left;
		}
		.state{
			width:100%;
			height:30px;
		}
		.state span{
			width:15%;
			height:30px;
			line-height:30px;
			display:inline-block;
			text-align:center;
			background-color:#F5F5DC;
			margin-left:5px;
		}
		.state span a{
			color:black;
			text-decoration:none;
			cursor:pointer;
		}
    </style>
</head>
<body>
    <div class="all">
        <div class="container giantScreen">
            <div class="head">
                <div class="logoLeft">
                    <a class="navbar-brand" href="#"><img alt="Brand" id="logo"  src="images/logo.png"></a>
                </div>
               <div class="logoCenter">
                   <!-- <ul>
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
            <div id="myCarousel" class="carousel slide">
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="item active"  >
                    	<div id="giant1">
	                        <img src="images/banner.jpg" height="496">
	                        <div class="button">
	                            <a href="#" class="hvr-shutter-out-horizontal">Watch Now</a>
	                        </div>
	                        <div class="carouselbg"></div>
			                <div class="carouselInf">
			                    <div class="col-md-8">
			                        <ul class="list_1">
			                            <li>Published <span class="m_1">Feb 20 2017</span></li>
			                            <li>Updated <span class="m_1">Feb 20 2017</span></li>
			                            <li>Rating <span class="m_1"><img src="images/rating.png" alt=""/></span></li>
			                        </ul>
			                    </div>
			                   <!--  <div class="col-md-4 grid_1">
			                        <ul class="list_1 list_2">
			                            <li><i class="icon1"> </i><p>2,548</p></li>
			                            <li><i class="icon2"> </i><p>215</p></li>
			                            <li><i class="icon3"> </i><p>546</p></li>
			                        </ul>
			                    </div> -->
			                </div>
		                </div>
                    </div>
                    <div class="item"  >
                    	<div id="giant2">
	                        <img src="images/banner1.jpg" height="496">
	                        <div class="button">
	                            <a href="#" class="hvr-shutter-out-horizontal">Watch Now</a>
	                        </div>
	                        <div class="carouselbg"></div>
			                <div class="carouselInf">
			                    <div class="col-md-8">
			                        <ul class="list_1">
			                            <li>Published <span class="m_1">Feb 20 2017</span></li>
			                            <li>Updated <span class="m_1">Feb 20 2017</span></li>
			                            <li>Rating <span class="m_1"><img src="images/rating.png" alt=""/></span></li>
			                        </ul>
			                    </div>
			                    <!-- <div class="col-md-4 grid_1">
			                        <ul class="list_1 list_2">
			                            <li><i class="icon1"> </i><p>2,548</p></li>
			                            <li><i class="icon2"> </i><p>215</p></li>
			                            <li><i class="icon3"> </i><p>546</p></li>
			                        </ul>
			                    </div> -->
			                </div>
		                </div>
                    </div>
                    <div class="item"  >
                    	<div id="giant3">
	                        <img src="images/banner2.jpg" height="496">
	                        <div class="button">
	                            <a href="#" class="hvr-shutter-out-horizontal">Watch Now</a>
	                        </div>
	                        <div class="carouselbg"></div>
			                <div class="carouselInf">
			                    <div class="col-md-8">
			                        <ul class="list_1">
			                            <li>Published <span class="m_1">Feb 20 2017</span></li>
			                            <li>Updated <span class="m_1">Feb 20 2017</span></li>
			                            <li>Rating <span class="m_1"><img src="images/rating.png" alt=""/></span></li>
			                        </ul>
			                    </div>
			                    <!-- <div class="col-md-4 grid_1">
			                        <ul class="list_1 list_2">
			                            <li><i class="icon1"> </i><p>2,548</p></li>
			                            <li><i class="icon2"> </i><p>215</p></li>
			                            <li><i class="icon3"> </i><p>546</p></li>
			                        </ul>
			                    </div> -->
			                </div>
		                </div>
                    </div>
                </div>
                
            </div>
        </div>
        <div class="container showFilm">
            <div class="col-md-9">
                <div class="hotFilm">
                    <h2>正在热映</h2>
                    <div class="search">
                    	<div class="state">
                    		<span style="background-color:#EE9A49" onclick="search(this)"><a>全部</a></span>
                    		<span onclick="search(this)"><a>大陆</a></span>
                    		<span onclick="search(this)"><a>台湾</a></span>
                    		<span onclick="search(this)"><a>英国</a></span>
                    		<span onclick="search(this)"><a>美国</a></span>
                    		<span onclick="search(this)"><a>韩国</a></span>
                    	</div>
                   		<table>
							<tr>
								<td style="width:45%;text-align:right"><p style="color:#000;margin-top:20px;">搜索条件：</p></td>
								<td style="width:30%"><input type="text" name="title" style="width:180px;height:30px;margin-top:20px;border:1px solid #5BC0DE"></td>
								<td style="width:16%;text-align:center">
									<select id="type" name="type" style="width:75px;height:30px;border:1px solid #5BC0DE">
										<option value="">请选择</option>
									</select>
								</td>
								<td><button class="btn btn-info"style="margin-top:-5px;" onclick="search()">搜索</button></td>
							</tr>
						</table>
                    </div>
                    <div class="showHot">
                        <ul id="showHotFilm">
                          
                        </ul>
                        <div class="pageList">
	                        <a onclick="toPage(this)" id="pageOn" data-page="">上一页</a>
    						<a onclick="toPage(this)" id="pageDown" data-page="">下一页</a>
    						<input type="hidden" id="savePage" value="1" />
    						<input type="hidden" id="sumPage"/>
                        </div>
                    </div>
                    <div class="notice">
	                	<h2>最新拼单消息</h2>
	                	<ul class="newFight">
	                		
	                	</ul>
	                	
	                </div>
	                <div style="text-align:center">
		                <button class="btn btn-info" onclick="toNew(this)" id="up">上一页</button>
		                <button class="btn btn-info" onclick="toNew(this)" id="down">下一页</button>
	                </div>
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
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </div>
        </footer>
    </div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script>
    $("#myCarousel").carousel(
            {interval:2000}
    );
    $(".logoCenter ul li span").mouseover(function(){
        $(this).children("a").show(120);
    });
    $(".logoCenter ul li span").mouseout(function(){
        $(this).children("a").hide(120);
    });
    var state ;
    $(function(){
    	$(".state span").each(function(index,item){
    		if($(item).css("background-color") == "rgb(238, 154, 73)"){
    			state = $(item).children().text();
    			return false;
    		}
    	});
    	
    });
    $.getJSON("filmDetail/selAll",function(data){
  		var film = [];
  		var i = 0;
  		console.log(data);
  		$(data).each(function(index,item){
  			 if(!item.giantScreen == "" && i < 4){
            	film.push(item);
            	i++;
            }
  		});
  		console.log($("#giant1 img").attr("src"));
       	$(film).each(function(index,item){
    		console.log(item.giantScreen);
    		$("#giant"+(index+1)+" img").attr("src",item.giantScreen);
    		$("#giant"+(index+1)+" .button a").attr("href","filmDetail/selectedFilm?id="+item.id);
    		console.log($("#giant"+(index+1)+" .list_1 li").eq(0).html("上映日期 <span class='m_1'>"+item.releaseDate.substr(0,10)+"</span>"));
    		console.log($("#giant"+(index+1)+" .list_1 li").eq(1).html("豆瓣评分 <span class='m_1'>"+item.score.toFixed(1)+"</span>"));
    		/* $("#giant"+(index+1)+" .m_1").eq(0).text(item.); */
       	});
  	});
    
    $.getJSON("filmDetail/getAllFilm?pageNo=0&title="+""+"&type="+""+"&state="+state,function(data){
    	$("#sumPage").attr("value",data.sumPage);
    	$(data.data).each(function(index,item){
    		$("#showHotFilm").append(
    		'<li>'+
                '<img src="'+item.picture+'" alt="..." width="200px" height="280px">'+
                '<h3>'+item.title+'</h3>'+
                '<p>豆瓣评分：'+item.score.toFixed(1)+'</p>'+
                '<p style="margin-left:72px"><a href="filmDetail/selectedFilm?id='+item.id+'" class="btn btn-danger" role="button">立即拼单</a></p>'+
            '</li>');
       	}); 
       	$("#pageOn").hide();
       	for(i = 1; i < data.sumPage ; i++){
       		$("#pageOn").append();
       	}
    });
    
    $.getJSON("filmDetail/selFilmByScore",function(data){
    	$(data).each(function(index,item){
    		$(".ranking ul").append('<li>'+(index+1)+'.<a href="filmDetail/selectedFilm?id='+item.id+'">'+item.title+'</a></li>');
    	});
    });
    
    $.getJSON("filmDetail/getAllFilmType",function(data){
    	console.log(data+"type");
    	$(data).each(function(index,item){
    		$("#type").append('<option value="'+item.typeName+'">'+item.typeName+'</option>');
    	});	
    });
    
    function toPage(page){
   	 	$(".state span").each(function(index,item){
    		if($(item).css("background-color") == "rgb(238, 154, 73)"){
    			state = $(item).children().text();
    			return false;
    		}
    	});
    	var pageNo = $("#savePage").attr("value");
    	var pageSum = $("#sumPage").val();
    	if($(page).text() == "上一页"){
    		pageNo = parseInt(pageNo)-1;
    		$("#savePage").attr("value",pageNo);
    	}else if($(page).text() == "下一页"){
    		pageNo = parseInt(pageNo)+1;
    		$("#savePage").attr("value",pageNo);
    	}
    	if(pageNo == "1"){
    		$("#pageOn").hide();
    	}else if(pageNo >= pageSum){
    		$("#pageDown").hide();
    	}else{
    		$("#pageOn").show();
    		$("#pageDown").show();
    	}
    	var title = $("input[name='title']").val();
  		var type = $("select[name='type'] option:selected").val();
  		$.ajax({
  			url:"filmDetail/getAllFilm",
  			data:{title:title,type:type,pageNo:pageNo,state:state},
  			dataType:"json",
  			type:"post",
  			success:function(data){
  				$("#showHotFilm").children().remove();
  				$(data.data).each(function(index,item){
  					console.log(item);
  					$("#sumPage").attr("value",data.sumPage);
		    		$("#showHotFilm").append(
		    		'<li>'+
		                '<img src="'+item.picture+'" alt="..." width="200px" height="280px">'+
		                '<h3>'+item.title+'</h3>'+
		                '<p>豆瓣评分：'+item.score.toFixed(1)+'</p>'+
		                '<p style="margin-left:72px"><a href="filmDetail/selectedFilm?id='+item.id+'" class="btn btn-danger" role="button">立即拼单</a></p>'+
		            '</li>');
		       	}); 
  			}
  		});
  	} 
  	
  	$("#logOff").click(function(){
  		if(confirm("是否要注销此账号？")){
  			$("#logOff").attr("href","account/logOff");
  		}
  	});
  	
  	function search(st){
  		var title = $("input[name='title']").val();
  		var type = $("select[name='type'] option:selected").val();
  		if(st != undefined){
	  		$(".state span").each(function(index,item){
	  			console.log($(item).css("background-color"));
	    		if($(item).css("background-color") == "rgb(238, 154, 73)"){
	    			$(item).css("background-color","rgb(245, 245, 220)");
	    		}
	    	});
	    	$(st).css("background-color","rgb(238, 154, 73)");
	    	state = $(st).children().text();
    	}else{
	    	$(".state span").each(function(index,item){
	    		console.log(item);
	    		if($(item).css("background-color") == "rgb(238, 154, 73)"){
	    			state = $(item).children().text();
	    			return false;
	    		}
	    	});
    	}
  		$.ajax({
  			url:"filmDetail/getAllFilm",
  			data:{title:title,type:type,pageNo:0,state:state},
  			dataType:"json",
  			type:"post",
  			success:function(data){
  				$("#showHotFilm").children().remove();
  				console.log(data);
  				if(data.sumPage == 1){
  					$("#pageOn").hide();
					$("#pageDown").hide();
				}else{
					$("#pageOn").hide();
					$("#pageDown").show();
				}
  				$(data.data).each(function(index,item){
  					console.log(item);
		    		$("#showHotFilm").append(
		    		'<li>'+
		                '<img src="'+item.picture+'" alt="..." width="200px" height="280px">'+
		                '<h3>'+item.title+'</h3>'+
		                '<p>豆瓣评分：'+item.score.toFixed(1)+'</p>'+
		                '<p style="margin-left:72px"><a href="filmDetail/selectedFilm?id='+item.id+'" class="btn btn-danger" role="button">立即拼单</a></p>'+
		            '</li>');
		       	}); 
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
		if(month < 10){
			month = "0"+month;
		}
		if(date < 10){
			date = "0"+date;
		}
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
	
	function formatDate(newDate){
		var dt = new Date(parseInt(newDate));
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
		return hour + ":" + minute + ":" + second;
	}
	
	var paNo=1;
    var sumPage;
  	$.getJSON("fightTicket/selNewFight?pageNo="+paNo,function(data){
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
  			var filmId = "'" + item.filmDetail.id + "'";
  			console.log(filmId);
  			var release = formatDay(item.theaterArrange.releaseTime).substr(0,11)+formatDate(item.theaterArrange.startTime);
  			console.log(release);
  			$(".newFight").append('<li>'+
	                			'<p>发起者：'+item.fightPeople+'</p>'+
	                			'<p>影片名：'+item.filmDetail.title+'</p>'+
	                			'<p>放映时间：'+release+'</p>'+
	                			'<p>发起时间：'+formatDay(item.createDate)+'</p>'+
	                			'<p><button class="btn btn-success" onclick="attend('+filmId+')">立即参与</button></p>'+
	                		'</li>');
  		});
  	});
  	
  	function toNew(p){
		var text = $(p).text();
		if(text=='下一页'){
			paNo++;
		}
		if(text=='上一页'){
			paNo--;
		}
		console.log(paNo);
		$.ajax({
			url:"fightTicket/selNewFight",
			data:{pageNo:paNo},
			type:"post",
			dataType:"json",
			success:function(data){
				console.log(data);
				if(data!=null){
					$(".newFight").children().remove();
					$(data.data).each(function(index,item){
						console.log("111111");
						var filmId = "'" + item.filmDetail.id + "'";
			  			console.log(filmId);
			  			var release = formatDay(item.theaterArrange.releaseTime).substr(0,11)+formatDate(item.theaterArrange.startTime);
			  			console.log(release);
			  			$(".newFight").append('<li>'+
	                			'<p>发起者：'+item.fightPeople+'</p>'+
	                			'<p>影片名：'+item.filmDetail.title+'</p>'+
	                			'<p>放映时间：'+release+'</p>'+
	                			'<p>发起时间：'+formatDay(item.createDate)+'</p>'+
	                			'<p><button class="btn btn-success" onclick="attend('+filmId+')">立即参与</button></p>'+
	                		'</li>');
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
  	
  	function attend(id){
  		location.href="filmDetail/selectedFilm?id="+id;
  	}
</script>
</html>