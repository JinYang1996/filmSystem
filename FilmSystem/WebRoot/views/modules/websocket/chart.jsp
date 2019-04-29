<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.neusoft.modules.account.model.Account"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	Account account = (Account)session.getAttribute("user");
	session.setAttribute("userName", account.getUserName());
	session.setAttribute("roleId", account.getRole().getId());
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'chat.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		.head{
			height:300px;
		}
		#context{
			width:500px;
			height:295px;
			border:1px solid red;
			float:left;
		}
		#nameList{
			width:150px;
			height:295px;
			border:1px solid black;
			float:left;
		}
	</style>
  </head>
  <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
  <script type="text/javascript">
  	var username = "${userName}";
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
        console.log(event);
       		$("#context").append(event.data);
       		
       		/* var content1 = event.data.indexOf("说:");
       		var content2 = event.data.indexOf("</br>");
       		console.log(content1 + "  " +content2);
       		if(content1 > 0){
	       		var content = event.data.substring(content1+2,content2);
	       		console.log(content);
	       		$.ajax({
	       			url:"message/sendMessage",
	       			data:{content:content},
	       			dataType:"json",
	       			type:"post",
	       			success:function(data){
	       				if(data == '1'){
	       					console.log("发送成功");
	       				}
	       			}
	       		});
       		} */
       		
        	/* eval("var msg = "+event.data+";");
        	console.info(msg["msg"]);
        	if(undefined!=msg["msg"].welcome)
        		$("#context").append(msg["msg"].welcome);
        	if(undefined!=msg["msg"].usernames){
        		$("#nameList").html("");
        		$(msg["msg"].usernames).each(function(){
        			$("#nameList").append("<input type='checkbox' value='"+this+"'/>"+this+"</br>");
        		});
        	} */
        };
        
  	};
  	function onSend(){
  		var msg = $("#msg").val();
  		ws.send(msg);
  		$("#msg").val("");
  		/* /*私聊要有：from 发送者  to 发给谁  message 发什么
  		var msg = $("#msg").val();
  		var cc = $("#nameList :checked").val();
  		var check_count = $("#nameList :checked").size();
  		if(check_count==0){//广播
	  		var obj = {
	  			message:msg,
	  			type:1  //1代表广播   2代表私聊
	  		};
  		}else{
  			var obj = {
	  			to:cc,
	  			message:msg,
	  			type:2  //1代表广播   2代表私聊
	  		};
  		}
  		var mm = JSON.stringify(obj);
  		console.log(mm);
  		ws.send(mm);
  		$("#msg").val(""); */
  	}
  </script>
  <body>
    <div class="head">
    	<div id="context"></div>
    	<div id="nameList"></div>
    </div>
    <div id="chart">
    	<textarea rows="" cols=""></textarea>
    	<input type="text" id="msg"><button onclick="onSend()">发送</button>
    </div>
  </body>
</html>
