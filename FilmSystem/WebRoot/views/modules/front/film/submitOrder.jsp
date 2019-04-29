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
    
    <title>My JSP 'submitOrder.jsp' starting page</title>
    
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
  		height:900px;
  	}
  	.showFilm h1{
  		width:300px;
  		margin:0 auto;
  		text-align:center;
  		/* border:1px solid #000111; */
  		font-size:20px;
  		padding:5px;
  		margin-top:20px;
  	}
  	.showOrder{
  		width:900px;
  		height:500px;
  		/* border:1px solid blue; */
  		margin:0 auto;
  		margin-top:10px;
  	}
  	.film,.arrange,.seat{
  		width:298px;
  		height:200px;
  		/* border:1px solid red; */
  		text-align:center;
  		padding-left:10px;
  		float:left;
  	}
  	.film p:nth-child(2){
  		line-height:80px;
  	}
  	.left{
  		float:left;
  	}
  	.right{
  		float:right;
  	}
  	.arrange_text{
  		text-align:left;
  	}
  	.arrange_text p{
  		height:30px;
  		line-height:30px;
  	}
  	.seat p{
  		line-height:130px;
  	}
  	.sub{
  		width:100px;
  		height:50px;
  		/* border:1px solid red; */
  		margin:0 auto;
  		padding:30px 0 0 10px;
  	}
  	.loading{
  		width:96px;
  		height:96px;
  		/* border:1px solid red; */
  		background:url(images/loading2.gif) no-repeat;
  		position:fixed;
  		top:250;
  		left:550;
  		border-radius:50%;
  		display:none;
  	}
  	.loading_text{
  		position:fixed;
  		top:290;
  		left:670;
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
		top:220;
  		left:500;
  		background-color:#fff;
  		display:none;
  	}
  	.showCode1{
  		position:fixed;
  		top:410;
  		left:590;
  		font-size:20px;
  		font-weight: bold; 
  		color: #535e66;
  		display:none;
  	}
  	.showCode2{
  		position:fixed;
  		top:410;
  		left:550;
  		font-size:20px;
  		font-weight: bold; 
  		color: #535e66;
  		display:none;
  	}
  	.showTicket button{
  		position:fixed;
  		top:490;
  		left:640;
  		font-size:20px;
  		font-weight: bold; 
  		color: #535e66;
  	}
  	.score{
  		width:100%;
  		height:200px;
  		border:1px solid #B0E0E6;
  		text-align:right;
  	}
  	.allPrice{
  		width:100px;
  		height:30px;
  		padding:5px;
  	}
  	s{
  		color:grey;
  	}
  	#useIntegral{
  		display:none;
  	}
  	#timer{
  		font-family: 'Yesteryear', cursive;
		text-shadow: -1px -1px 1px rgba(0, 0, 0, 0.8),-2px -2px 1px rgba(0, 0, 0, 0.3);
		font-size:30px;
	}
	#timer p{
		width:100%;
		text-align:center;
		margin-top:20px;
	}
	.message{
		width:100%;
		height:280px;
		border:1px solid grey;
		margin-top:30px;
	}
	.message p{
		font-size:15px;
		line-height:20px;
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
                		<c:when test="${not empty user.userName} and ${not empty user.photo}">
	                		<a href="#"><img src="${user.photo }" width="35px" height="35px"></a>
		                    <div class="personal_name"><a href="views/modules/front/person/person_pa.jsp">${user.userName }</a></div>
                		</c:when>
                		<c:when test="${not empty user.userName}">
                			<a href="#"><img src="images/p1.png" width="35px" height="35px"></a>
			                <div class="personal_name"><a href="views/modules/front/person/person_pa.jsp">${user.userName }</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id="logOff">注销</a></div>
                		</c:when>
                		<c:otherwise>
	                    	<a href="#"><img src="images/p1.png" width="35px" height="35px"></a>
			                <div class="personal_name"><a href="account/toLogin">请登录</a></div>
	                    </c:otherwise>
                	</c:choose>
                </div>
            </div>
        </div>
        <div class="container showFilm">
                <h1 style="font-size:30px">拼单订单确认并支付</h1>
                <div id="timer">
                	<p>欢迎使用享影网</p>
                </div>
                <div class="showOrder">
                	<div class="film">
                		<h2>影片</h2>
                		<div>
                			<img alt="${fightTicket.filmDetail.picture }" src="${fightTicket.filmDetail.picture }" width="100px" class="left">	
                			<p>${fightTicket.filmDetail.title }</p>
                			<p style="font-size:14px;color:grey">${fightTicket.filmDetail.language }</p>
                		</div>
                	</div>
                	<div class="arrange">
                		<h2>影院/场次</h2>
                		<div class="arrange_text">
                			<p style="margin-top:20px">影院：光明电影院</p>
                			<p style="color:red">场次：<fmt:formatDate value="${fightTicket.theaterArrange.releaseTime }" pattern="yyyy-MM-dd E"/>
                			 <fmt:formatDate value="${fightTicket.theaterArrange.startTime }" pattern="HH:mm"/> ${fightTicket.theaterArrange.videoHall.hallName }</p>
                			<p style="font-size:14px;color:grey">预计<fmt:formatDate value="${fightTicket.theaterArrange.endTime }" pattern="HH:mm"/>散场</p>
                		</div>
                	</div>
                	<div class="seat">
                		<h2>座位</h2>
                		<div>
                			<p>${rowCol }</p>
                		</div>
                	</div>
                	<p style="clear:both"></p>
                	<div class="score">
                		<h1 style="border:0">${fightTicket.favorable }元</h1>
                		<h1 style="font-weight:bold;color:red;border:0">总金额:<fmt:formatNumber value="${fightTicket.price }" pattern="#.00"/>元<s>(<fmt:formatNumber value="${fightTicket.originalPrice }" pattern="#.00"/>)</s></h1>
                		<p style="text-align:center">
                			<input type="checkbox" id="select-mark" class="icheck-checkbox" onclick="checkIs()"/>是否使用积分 
                		    <span id="useIntegral" style="text-align:center">
                		    	可使用积分：${user.integral }分  使用：<input type="number" id="usedScore" style="width:80px" onblur="checkIntegral(this)">
                		    </span>
                		</p>
                		<input type="hidden" id="leaveScore">
                		<h1 style="border:0">最终金额：<span id="finalPrice"><fmt:formatNumber value="${fightTicket.price }" pattern="#.00"/></span>元</h1>
                	</div>
                	<div class="sub">
	                	<button class="btn btn-success" onclick="subOrder()">订单确认</button>
	                	
	                </div>
	                <div class="message">
	                	<div class="col-md-6">
	                		<h2>观影提醒</h2>
	                		<p>1、根据影院要求，拼单总人数达到60%以上则无法取消订单！</p>	
	                		<p>2、根据影院要求，本场次订票截止时间为电影开场前 30分钟 ， 请勿错过订票时间</p>	
	                		<p>3、建议提前半小时至影院，使用影院取票机取票。</p>
	                	</div>
	                	<div class="col-md-6">
	                		<h2>使用说明</h2>
	                		<p>1、每笔订单最多可选购5张电影票</p>	
	                		<p>2、点击“完成选座”后，请在15分钟内完成支付，超时系统将释放你选定的座位。</p>	
	                		<p>3、如因影院场次变化，设备故障，影片调整等不可抗拒因素，导致已购票的场次无法观看，享影网客服会提前通知您改订或退积分。 </p>
	                		<p>4、划线价格：划线价格可能是影院的零售价、指导价或该影院曾经展示过的销售价等，仅供您参考。 未划线价格：未划线的价格是电影票正在处于销售期或者促销活动期的销售标价，具体的成交价格可能因会员使用优惠券、积分等发生变化，最终以订单结算页价格为准。</p>
	                	</div>
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
    <div class="showTicket">
   		<span class="loading"></span> 
   		<span class="loading_text">请稍后！</span>
   		<span class="showCode1">请等待管理员审核！</span>
   		<span class="showCode2">该订单已提交，请勿重复提交！</span>
   		<button class="btn btn-warning" onclick="toSubmit()">确认</button>
   	</div>
  </body>
  <script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
  <script type="text/javascript">
  	function subOrder(){
  		$(".all").css("opacity","0.6");
  		$(".showTicket").show();
  		$(".loading").show();
  		$(".loading_text").show();
  		var usedScore = $("#usedScore").val();
  		usedScore = usedScore == "" ? 0 : usedScore;
  		var finalPrice = $("#finalPrice").text();
  		var leaveScore = parseInt('${user.integral}')-parseInt(usedScore);
  		/* var t = setTimeout("changeLoading();",500); */
  		$.ajax({
  			url:"fightTicket/submitOrder",
  			type:"post",
  			dataType:"json",
  			data:{fightId:'${fightTicket.id}',finalPrice:finalPrice,usedScore:usedScore,leaveScore:leaveScore},
  			success:function(data){
  				if(data == '1'){
  					var t = setTimeout("changeLoading();",200);
  					$(".showCode1").show();
  				}else if(data == '3'){
  					alert("未登录，请先登录！");
  					location.href="views/modules/front/login/login.jsp";
  				}else if(data == '4'){
  					$(".showCode2").show();
  				}
  			}
  		});
  		
  	}
  	
  	function changeLoading(){
  		$(".loading").css("background","url(images/icons.png) no-repeat");
  		$(".loading").css("background-position","0 -96px");
  		$(".loading").css("background-size","192px 276px");
  		$(".loading_text").text("已完成！");
  		
  	}
  	
  	function checkIs(){
  		if($("#select-mark").prop("checked")){
  			$("#useIntegral").show();
  		}else{
  			$("#useIntegral").hide();
  		}
  	}
  	
  	function checkIntegral(Integral){
   		var reg = /^(0|[1-9][0-9]*)$/;
   		if($(Integral).val() != ""){
   			if(reg.test($(Integral).val())){
   				console.log(parseInt($(Integral).val()));
   				console.log(parseInt('${user.integral}'));
	   			if(parseInt($(Integral).val()) > parseInt('${user.integral}')){
	   				alert("积分不足！");
	   				$(Integral).val("");
	   			}else{
	   				console.log(parseInt($("#finalPrice").text()) * 100);
	   				var finalPrice = ((parseInt('${fightTicket.price }') * 100) - parseInt($(Integral).val()));
	   				console.log(finalPrice);
	   				if(finalPrice < 0){
	   					alert("超出总金额！");
	   					$(Integral).val(parseInt('${fightTicket.price }') * 100);
	   					$("#finalPrice").text('0.00');
	   					console.log("积分无法使用过多");
	   				}else{
	   					$("#finalPrice").text((finalPrice/100).toFixed(2));
	   				}
	   				console.log("正确");
	   			}
	   		}else{
	   			alert("请输入正确的价格");
	   			$(Integral).val("");
	   		}
   		}
   	}
    
    function toSubmit(){
    	location.href="account/toPerson";
    }
    
    $("#logOff").click(function(){
  		if(confirm("是否要注销此账号？")){
  			$("#logOff").attr("href","account/logOff");
  		}
  	});
  	
  	var maxtime,minutes,seconds,msg;
    if(window.name==''){
        testCountDown();

    }
    else{
//        maxtime=window.name;
        testCountDown();
    }

    function testCountDown() {
        $.ajax({
            type:"post",
            url:"filmDetail/countDownTime" ,
            async: "false",
            data:{id:'${fightTicket.id}'} ,
            success:function (data) {
            	data = eval('('+data+')');
                if (data.seconds){
                    maxtime =  data.seconds;
                }else {
                    alert("kong");
                }
            }
        });
    }
    function CountDown(){
        var div = $("#timer p");
        if(maxtime>=0){
            minutes=Math.floor(maxtime/60);
            seconds=Math.floor(maxtime%60);
            msg="距离结束还有:"+minutes+"分"+seconds+"秒";
			
            div[0].innerHTML=msg;
            --maxtime;
            window.name=maxtime;
        }
        else{
            clearInterval(timer);
            alert("订单超时未支付，已被取消！");
            location.href="fightTicket/cancelFightTicket?id="+'${fightTicket.id}'+"&filmId="+'${fightTicket.filmDetail.id}';
        }
    }
    timer=setInterval("CountDown()",1000);
    
    
   /* 	var d = new Date(new Date().getTime() + maxtime); */

    
  </script>
</html>
