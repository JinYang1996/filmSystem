<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<jsp:include page="../../modal/modal.jsp"></jsp:include>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/reset.css">
    <link rel="stylesheet" type="text/css" href="css/person_page.css">
</head>
<style type="text/css">
    .all{
        background:url(images/119.jpg) no-repeat ;
        background-color:#067CAA;
        position:relative;
    }
    .backbg{
    	width:180px;
    	height:800px;
    	position:absolute;
    	top:0;
    	left:0;
    	background:url(images/picbg2.png) no-repeat;
    }
    .active{
        color:white ;
        background-color: #00aaee;
    }
    .content{
	    width:1000px;
	    height:1100px;
	   /*  margin:50px auto 0; */
	    margin:0 auto 0;
	}
	.content_head{
		height:240px;
	}
	.per_detail{
	    width:863px;
	    height:800px;
	    margin-left: 4px;
	}
	.list_func{
	    width:130px;
	    height:830px;
	    border:1px solid #71c2ff;
	    background-color: #FFFFFF;
	}
    .memcard{
    	width:134px;
    	height:80px;
    	line-height:80px;
    	display:block;
    	text-align:center;
    	margin-left:-32px;
    	margin-top:-30px;
    	background-image:url(images/卡背景.jpg);
    	color:#ff392b;
    }
    .pop{
	    width:400px;
	    height:300px;
	    border:3px solid #eff4ff;
	    position:fixed;
	    background-color: #fff;
	    top:100px;
	    left: 500px;
	    display: none;
	    z-index: 1;
	}
	.pop_title{
	    height:40px;
	    line-height: 40px;
	    background-color: #cccccc;
	}
	.pop_title h3{
	    height:40px;
	    line-height: 40px;
	    font-size:16px;
	    font-weight:bold;
	    text-indent:1em;
	}
	.content_head .myinfo .wal, .mem{
		height:120px;
	}
</style>
<body>
    <div class="all">
        <!-- <nav class="nav navbar-default navbar-fixed-top" style="background-image:url(images/bg3.jpg)">
            <div class="container">
                <a class="navbar-brand" href="#"><img alt="Brand" id="logo" height="50px" src="images/pic5.jpg"></a>
                <ul class="nav navbar-nav" id="icon">
                    <li><a href="homepage.jsp">论坛</a></li>
                    <li><a href="#">聚焦</a></li>
                    <li><a href="#">天涯榜</a></li>
                    <li class="dropdown">
                        <a href="" data-toggle="dropdown"><span class="glyphicon glyphicon-align-justify"></span></a>
                        <ul class="dropdown-menu">
                            <li class="one">
                                <span><a href="#">问答</a></span>
                                <span><a href="#">部落</a></span>
                                <span><a href="#">博客</a></span>
                                <span><a href="#">文学</a></span>
                            </li>
                            <li class="two">
                                <span class="title left">主题</span>
                                <div class="two_one">
                                    <span><a href="#">民生</a></span>
                                    <span><a href="#">娱乐</a></span>
                                    <span><a href="#">人文</a></span>
                                    <span><a href="#">股票</a></span>
                                </div>
                                <div class="two_one">
                                    <span><a href="#">汽车</a></span>
                                    <span><a href="#">时尚</a></span>
                                    <span><a href="#">游戏</a></span>
                                    <span><a href="#">旅游</a></span>
                                </div>
                            </li>
                            <li class="two">
                                <span class="title left">区域</span>
                                <div class="two_one">
                                    <span><a href="#">海南</a></span>
                                    <span><a href="#">三亚</a></span>
                                    <span><a href="#">重庆</a></span>
                                    <span><a href="#">四川</a></span>
                                </div>
                                <div class="two_one">
                                    <span><a href="#">北京</a></span>
                                    <span><a href="#">上海</a></span>
                                    <span><a href="#">深圳</a></span>
                                    <span><a href="#">山东</a></span>
                                </div>
                            </li>
                            <li class="three"><span class="glyphicon glyphicon-earphone">&nbsp;<a href="#">联系客服</a></span></li>
                        </ul>
                    </li>
                </ul>
                <form class="navbar-form navbar-left" method="post">
                    <div class="form-group">
                        <input type="text" class="form-control" id="search" list="article_list" placeholder="搜帖、找人、搜模块">
                        <datalist id="article_list">
                        	
                        </datalist>
                    </div>
                    <button type="button" onclick="searchArticle(this.form)" class="btn btn-default">搜索</button>
                </form>
                <ul class="nav navbar-nav navbar-right">
                	<li><a href="register.jsp">登录</a></li>
                    <li><a href="register.jsp">注册</a></li>
                </ul>
            </div>
        </nav> -->
        <div class="backbg"></div>
        <div class="content">
            <div class="content_head">
                <div class="per_picture">
                	<c:if test="${not empty user.photo }">
                		  <img src="${user.photo}" width="150px" class="img-thumbnail">
                	</c:if>
                  	<c:if test="${empty user.photo }">
                		  <img src="images/user2.jpg" width="150px" class="img-thumbnail">
                	</c:if>
                    <span class="per_name"><a>${user.account }</a></span>
                </div>
                <div class="myinfo left">
                    <div class="wal left">
                        <span class="wallet"><a id="mywal">我的钱包<span class="glyphicon glyphicon-chevron-down"></span></a></span>
                        <div class="wal_bg"><div class="mywallet"></div><span class="word"><a>我的积分：${user.integral }分</a></span></div>
                    </div>
                    <div class="mem left">
                        <span class="member"><a id="mymem">我的会员服务<span class="glyphicon glyphicon-chevron-down"></span></a></span>
                        <div class="mem_bg"><div class="mymember"></div>
                        	<span class="memword">
                        		<c:if test="${user.isMember == '1' }">
                        			<a onclick="createmem(this)" target="right">开通会员</a>
                        		</c:if>
                        		<c:if test="${user.isMember == '0' }">
                        			<a class="memcard">普通会员</a>
                        		</c:if><%-- 
                        		<c:if test="${user2.powerInfo.name=='普通用户' }">
                        			<a onclick="createmem2(this)" target="right">开通会员</a>
                        		</c:if>
                        		<a onclick="createmem2(this)" target="right">开通会员</a> --%>
                        	</span>
                        </div>
                    </div>

                </div>
                <div class="head_bottom">
                    <!-- <p><a href="#" target="right" onclick="sign(this)" class="sbtn btn btn-primary right" role="button">签到</a></p> -->
                    <p><a href="account/toPerfect" target="right" id="perfect" class="sbtn btn btn-default right" role="button">完善资料</a></p>
                </div>
                <div>
                    <span class="right"><a onclick="changeBg()"><img src="images/选肤1.jpg" width="40px"></a></span>
                </div>
            </div>
            <div class="per_whole">
                <div class="list_func left">
                    <ul>
                        <li><a href="views/modules/front/person/person_detail.jsp" class="glyphicon glyphicon-home" target="right">个人首页</a></li>
                        <li><a href="collect/selAllCollect?accountId=${user.id }" class="glyphicon glyphicon-edit" target="right">我的收藏</a></li>
                        <li><a href="views/modules/front/person/per_password.jsp" class="glyphicon glyphicon-wrench" target="right">修改密码</a></li>
                        <li><a href="fightTicket/toPersonOrder" class="glyphicon glyphicon-credit-card" target="right">我的订单</a></li>
                        <li><a href="applyArrange/selApplyByUser" class="glyphicon glyphicon-bullhorn" target="right">我的预约</a></li> 
                        <li><a href="integralInfo/selIntegral" class="glyphicon glyphicon-paperclip" target="right">积分记录</a></li> 
                        <li><a href="evaluate/selEvaluateByUser" class="glyphicon glyphicon-text-color" target="right">我的评论</a></li> 
                        <li><a href="javascript:void(0)" onclick="showModal()" class="glyphicon glyphicon-text-color" target="right">联系管理员</a></li>
                        <li><a onclick="history.go(-1)" class="glyphicon glyphicon-arrow-left" target="right">返回</a></li>
                    </ul>
                </div>
                <ul class="bread">
                    <li><a href="views/modules/front/film/homePage.jsp" class="icon-home"> 首页</a></li>
                    <li><span id="a_leader_txt">个人首页</span></li>
                </ul>
                <div class="per_detail left">
                    <iframe id="right" scrolling="auto" frameborder="0" src="<%=request.getRequestURI().substring(0, request.getRequestURI().lastIndexOf("/")) %>/person_detail.jsp" name="right" width="100%" height="100%"></iframe>
                </div>
            </div>
        </div>
        <div class="pop">
            <div class="pop_title">
                <h3>皮肤选择<span><a class="right" onclick="closeBg()"><img src="images/close.jpg" width="30px" style="margin:6px 8px 0 0"></a></span></h3>

            </div>
            <div>
                <a onclick="choseBg(this)"><img src="images/109.jpg" width="100px" height="100px"></a>
                <a onclick="choseBg(this)"><img src="images/112.jpg" width="100px" height="100px"></a>
                <a onclick="choseBg(this)"><img src="images/119.jpg" width="100px" height="100px"></a>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function createmem(s){
        var message = confirm("确定要开通会员吗？");
        if(message){
            $.ajax({
            	url:"account/toMember",
            	data:{id:'${user.id}'},
            	dataType:"json",
            	success:function(data){
            		console.log(data);
            		if(data == '1'){
            			/* s.href="views/success/subSuccess.jsp"; */
            			$(s).hide();
            			$(".memword").append('<a class="memcard">普通会员</a>');
            		}else if(data == '2'){
            			alert("开通失败");
            		}
            	}
            });
        }
    }
     /*搜索文章*/
    function searchArticle(frm){
		var title = $("#search").val();
		location.href="articleInfoController/searchArticle?title="+title;
	}
    function sign(aa){
        aa.href="success.jsp";
    }
    $(function(){
    	var uid = '${user.id}';
    	
    	<%-- var fightList = '${fightList}';
    	console.log(fightList);
    	if(fightList != ""){
    		console.log("<%=request.getRequestURI().substring(0, request.getRequestURI().lastIndexOf('/')) %>/person_order.jsp");
    		$("#right").attr("src","account/toPersonOrder");
    	} --%>
    	
        $(".wallet").mouseover(function(){
        	$.getJSON("account/selScore?id="+uid,function(data){
	    		$(".word a").html('我的积分：'+data+'分');
	    	});
            $(".wal_bg").css("display","block");
        });
        $(".wal_bg").mouseover(function(){
            $(".wal_bg").show();
        });
        $(".wallet").mouseout(function(){
            $(".wal_bg").css("display","none");
        });
        $(".wal_bg").mouseout(function(){
            $(".wal_bg").hide();
        });
        $(".member").mouseover(function(){
            $(".mem_bg").show();
        });
        $(".mem_bg").mouseover(function(){
            $(".mem_bg").show();
        });
        $(".member").mouseout(function(){
            $(".mem_bg").hide();
        });
        $(".mem_bg").mouseout(function(){
            $(".mem_bg").hide();
        });
        $(".list_func ul li a").first().addClass("active");
        $(".list_func ul li a").click(function(){
            var t = $(this).text();
            $("#a_leader_txt").text(t);
            /* if(t=="个人首页"){
                $("#a_leader_txt").attr("href","per_list.jsp");
            }else if(t=="我的博客"){
                $("#a_leader_txt").attr("href","per_article_list.jsp");
            }else if(t=="我的收藏"){
                $("#a_leader_txt").attr("href","per_collect.jsp");
            }else if(t=="修改密码"){
                $("#a_leader_txt").attr("href","per_password.jsp");
            } */

            $(".list_func ul li a").removeClass("active");
            $(this).addClass("active");
        });
        $("#perfect").click(function(){
            $("#a_leader_txt").text($(this).text());
            $("#a_leader_txt").attr("href","per_perfect.jsp");
        });
        
        $.get("message/selAllMessage",function(data){
  			$(data).each(function(index,item){
  				console.log(item.role);
  				if(item.role == '1'){
  					$("#context").append("用户 "+item.sender+" 说:"+item.content+"</br>");
  				}else{
  					$("#context").append("管理员 "+item.sender+" 说:"+item.content+"</br>");
  				}
  				
  			});
  		});
    });
    function changeBg(){
        $(".pop").show();
        $(".all").css("opacity","0.9");
    }
    function closeBg(){
        $(".pop").hide();
        $(".all").css("opacity","1");
    }
    function choseBg(pic){
       var changePic = $(pic).children("img").attr("src");
       $(".all").css("background","url("+changePic+") no-repeat");
       if(changePic.indexOf("112")!=-1){
       		$(".all").css("background-color","#6CB0C5");
       }
       if(changePic.indexOf("109")!=-1){
       		$(".all").css("background-color","#BCA847");
       }
       if(changePic.indexOf("119")!=-1){
       		$(".all").css("background-color","#067CAA");
       };
    }
    
    function showModal(){
		$("#myModal").modal('show');
	};
	
	var username = "${userName}";
	var roleName = username ;
  	console.log(username);
  	var ws;//一个ws就是一个通信管道
  	var target = "ws://localhost:8080/FilmSystem/echo?userName="+username;
  	window.onload = function(){
  		if ('WebSocket' in window) {
            ws = new WebSocket(target);
        } else if ('MozWebSocket' in window) {
            ws = new MozWebSocket(target);
        } else {
            alert('WebSocket is not supported by this browser.');
            return;
        }
        ws.onmessage = function(event){
        	console.log(username);
        	console.log(event);
       		$("#context").append(event.data);
       		
       		var content1 = event.data.indexOf("说:");
       		var content2 = event.data.indexOf("</br>");
       		
       		var sendName = event.data.substring(4,content1-1);
       		console.log(content1 + "  " +content2);
       		
       		if(content1 > 0 && roleName == sendName){
	       		var content = event.data.substring(content1+2,content2);
	       		console.log(content);
	       		$.ajax({
	       			url:"message/sendMessage",
	       			data:{content:content,roleName:roleName},
	       			dataType:"json",
	       			type:"post",
	       			success:function(data){
	       				if(data == '1'){
	       					console.log("发送成功");
	       				}
	       			}
	       		});
       		}
        };
        ws.onclose = function(evt){
		  console.log("WebSocketClosed!");
		};
	  	ws.onerror = function(evt){
	 	 	console.log("WebSocketError!");
	    };
        
  	};
  	
  	function onSend(){
  		var msg = "     "+$("#msg").val()+"     ";
  		/* var str = [];
  		if(msg.length >= 4){
  			for(i=0;i<msg.length;i++){
  				if(i%3 != 0){
  					continue;
  				}
  				var sendMsg = msg.substring(i,i+3);
  				str.push(sendMsg);
  				
  			};
  		}; */
	  	ws.send(msg);
	  	
  		
  		/* ws.send(msg); */
  		$("#msg").val("");
  		
  	};
</script>
</html>