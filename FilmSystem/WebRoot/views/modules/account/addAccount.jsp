<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head> 
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <style type="text/css">
        .form-x .form-group .label{
            width:100px;
        }
        .msg{
        	line-height:40px;
        }
        .newmsg{
        	line-height:40px;
        }
    </style>
</head>
<body>
<div class="panel admin-panel" style="width:800px;margin:20px auto">
    <div class="panel-head"><strong><span class="icon-key"></span> 添加管理员</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="account/addAdmin" id="frm">
        	<input type="hidden" name="role.id" value="2">
        	<input type="hidden" name="photo" value="images/user2.jpg">
            <div class="form-group">
                <div class="label">
                    <label>用户名：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       <input type="text" name="userName" id="userName" class="form-control" onblur="validate()" placeholder="请输入用户名">
                    </label>
                    <span id="msg"></span>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>密码：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       <input type="password" name="pwd" id="pwd" class="form-control" onblur="checkPwd()" placeholder="请输入密码">
                    </label>
                    <span id="pwdMsg"></span>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>真实姓名：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       <input type="text" name="trueName" id="trueName" class="form-control" placeholder="请输入真实姓名">
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>电子邮箱：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       <input type="text" name="email" id="email" class="form-control" onblur="checkEmail(this)" placeholder="请输入邮箱">
                    </label>
                    <span id="emsg"></span>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>电话：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       <input type="text" name="phone" id="phone" class="form-control" onblur="isPossible()" placeholder="请输入电话">
                    </label>
                    <span id="phoneMsg"></span>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>性别：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       	<input type="radio" name="sex" value="0" checked="checked">男
                    	<input type="radio" name="sex" value="1">女
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>生日：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       <input type="date" name="birthday" id="birthday" class="form-control">
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label" style="margin-left:100px">
                    <label>
                    	<button type="button" onclick="sub()" class="btn btn-info">提交</button>
                    </label>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function validate(){
		var userName = $("#userName").val();
		if(userName != "" && userName != null){
			$.ajax({
				url:"account/validateUsername",
				type:"POST",
				data:{userName:userName},
				dataType:"json",
				success:function(data){
					if(data==2){
						$("#msg").html("");
					}else if(data==1){
						$("#msg").html("用户名已存在");
						$("#msg").css("color","red");
					}
				}
			});
		}
	}
	
	function isPossible(){
		var phone = $("#phone").val();
		console.log(phone);
		if(isPhoneAvailable(phone)){
			$("#phoneMsg").text("");
		}else{
			$("#phoneMsg").text("不可用");
			$("#phoneMsg").css("color","red");
		}
	}
	
	function isPhoneAvailable(phone){
		var reg =/^1\d{10}$/;
		if(!reg.test(phone)){
			return false;
		}else{
			return true;
		}
	};
	
	function checkPwd(){
		var pwd = $("#pwd").val();
		if(pwd.length < 5){
			$("#pwdMsg").text("不能小于5位");
			$("#pwdMsg").css("color","red");
		}else{
			$("#pwdMsg").text("");
		}
	}
	
	function checkEmail(email){
		var reg = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
		var emailVal = $(email).val();
		if(!reg.test(emailVal) && emailVal != ''){
			$("#emsg").text("请输入有效邮箱地址");
			$("#emsg").css("color","red");
			$(email).css("border-color","red");
		}else{
			$("#emsg").text("");
			$(email).css("border-color","#22CC77");
			$(email).css("background-color","#fff");
		}
	}
	
	function sub(){
		var  userName = $("input[name='userName']").val();
		var  pwd = $("input[name='pwd']").val();
		var  trueName = $("input[name='trueName']").val();
		var  email = $("input[name='email']").val();
		var  phone = $("input[name='phone']").val();
		var  birthday = $("input[name='birthday']").val();
		
		var emsg = $("#emsg").text();
		var pwdMsg = $("#pwdMsg").text();
		var phoneMsg = $("#phoneMsg").text();
		var msg = $("#msg").text();
		if(userName != '' && pwd != '' && trueName != '' && email != '' && phone != '' && birthday != '' && emsg == '' && pwdMsg == '' && phoneMsg == '' && msg == ''){
			$("#frm").submit();
		}else{
			alert("请填写完整信息");
		}
	}
</script>
	
</html>