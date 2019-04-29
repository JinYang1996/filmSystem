<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder"%>  
<%@ page language="java" import="javax.servlet.http.Cookie,java.net.URLEncoder"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%  
String name="";//设置从cookie接受登录名的变量  
String pwd="";//设置从cookie接受密码的变量  
String check ="";//设置是否有勾选记住密码的标识  
Cookie[] cookies = request.getCookies();//从request中获取cookie 这里拿到的是一个cookie对象数组  
for(int i=0;cookies!=null&&i<cookies.length;i++){  
    Cookie cookie = cookies[i];  
    if(URLDecoder.decode(cookie.getName(), "UTF-8").equals("name")){  
        name=URLDecoder.decode(cookie.getValue(), "UTF-8");  
        check="checked";  
    }  
/*  /*前面的时候我们对用户的登录名进行了编码，因为这样才可以写入cookie当中  
    *当然如果你是英文字母则不需要这样做，我指的是中文 所以这里还要对用户名进行解码  
    *然后判断是不是cookie的名字是不是等于name 是的话就把值付给变量name  
    *注意这里的两个name不是同一个变量，只是我刚好用了相同的标识而已 如果获取到了用户名  
    *说面这个用户上次是勾选了记住密码的 所以这次要给check赋值为checked  
    *至于为什么要赋值为checked 你如果了解html当中的复选框的话 我相信你会明白的  
    *下面的密码同理  
    */  
      
    if(cookie.getName().equals("pwd")){  
        pwd=cookie.getValue();  
    }  
      
      
}  
  
%>  
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/register.css">
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>  
    <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
	<style type="text/css">
		#msg,#phoneMsg,#pwdMsg{
			height:38px;
			line-height:38px;
			color:red;
			font-size:12px;
		}
		#mes{
    		color:red;
    	}
		.bg{
			background: url("images/restaurant.jpg") no-repeat center;
			
			/* box-shadow:0 0 30px #fff inset; */
			position:relative;
			
		}
		.reg{
			position:absolute;
			top:80px;
			left:620px;
		}
		.log{
			position:absolute;
			top:80px;
			left:720px;
		}
		.right{
			float:right;
		}
		.loginbox { background:url(images/tmbg-white.png); border:0px;}
		.chooseHead{
			width:400px;
			height:300px;
			border:1px solid #CDCDC1;
			border-radius:5px;
			position:fixed;
			top:200;
			left:500;
			z-index:9999;
			display:none;
			background:#fff;
			padding-top:80px;
		}
		.chooseHead a{
			margin-left:20px;
			z-index:19999;
		}
		.cover-bg{
			width:100%;
			height:100%;
			background-color: rgba(0,0,0,.5);
		}
	</style>


  </head>
  
  <body>
  <div class="bg">
  	<div class="cover-bg"></div>
  	<div class="reg">
  		<input type="button" onclick="reg()" class="btn btn-info" value="注册">
  	</div>
  	<div class="log">
  		<input type="button" onclick="log()" class="btn btn-info" value="登录">
  	</div>
    <div style="width:500px;position:absolute;top:150px;left:430px;">
    	<div class="span loginbox" style="padding-top:10px" id="registe">
	    	<h3 style="padding-left:42%;padding-bottom:20px;font-size:28px;font-weight:bold;">账号注册</h3>
		    <form name="frm" id="frm" action="account/register" method="post" enctype="multipart/form-data">
			  <div class="form-group" style="height:30px;padding-left:21%;margin-bottom:25px">
			  	<div class="field field-icon-right">
				    <label style="width:52;height:35px;line-height:35px;float:left">昵称：</label>
				    <input type="text" class="input input-mid" name="account" id="account" placeholder="请输入昵称" data-validate="required:请输入昵称" style="width:250px;float:left">
				</div> 	
			  </div>
			  <div style="clear:both"></div>
			  <div class="form-group" style="height:30px;padding-left:21%;margin-bottom:25px">
			  	<div class="field field-icon-right">
				    <label style="height:35px;line-height:35px;float:left">用户名：</label>
				    <input type="text" class="input input-mid" name="userName" id="userName" onblur="validate()" placeholder="请输入用户名"  data-validate="required:请输入用户名"  style="width:250px;float:left">
					<p id="msg"></p>
				</div>  
			  </div>
			  <div style="clear:both"></div>
			  <div class="form-group" style="height:30px;padding-left:21%;margin-bottom:25px">
				  <div class="field field-icon-right">
				    <label style="width:52;height:35px;line-height:35px;float:left">密码：</label>
				    <input type="password" class="input input-mid" name="pwd" id="pwd" onblur="checkPwd()" placeholder="请输入密码" data-validate="required:请输入密码" style="width:250px;float:left">
				  	<p id="pwdMsg"></p>
				  </div>
			  </div> 
			  <div style="clear:both"></div>
			  <div class="form-group" style="height:30px;padding-left:21%;margin-bottom:25px">
				  <div class="field field-icon-right">
				    <label style="height:35px;line-height:35px;float:left">手机号：</label>
				    <input type="text" class="input input-mid" name="phone" id="phone" onblur="isPossible()" placeholder="请输入手机号" data-validate="required:请输入手机号" style="width:250px;float:left">
				  	<p id="phoneMsg"></p>
				  </div>
			  </div>
			  <div style="clear:both"></div>
			  <div class="form-group" style="height:30px;padding-left:21%;margin-bottom:25px;display:none">
				  <div class="field field-icon-right">
				    <label style="width:52;height:35px;line-height:35px;float:left">身份：</label>
				    <select class="input input-mid" name="role.id" id="role" placeholder="请选择身份" data-validate="required:请选择身份" style="width:250px;float:left">
				    	<option value="1">用户</option>
				    	<option value="2">管理员</option>
				    	<option value="3">超级管理员</option>
				    </select>
				  </div>
			  </div>
			  <div style="clear:both"></div>
			  <div class="form-group" style="padding-left:21%">
			    <label style="padding-top:30px;float:left">上传头像：</label>
			    <a id="changeHead"><img name="pic" src="images/user2.jpg" width="80px" height="80px" id="pic" class="img-circle" style="border-radius:50%"></a>
			    <input type="hidden" name="photo" id="photo" value="images/user2.jpg"/>
			    <p class="help-block"></p>
			  </div>
			  
			  <!-- <div style="clear:both"></div>
			  <div class="form-group" style="padding-left:25%">
			    <label style="padding-top:30px;float:left">上传图片：</label>
			    <img name="pic" width="80px" height="80px" id="pic" class="img-circle" style="border-radius:50%">
			    <input type="file" class="btn btn-default" name="photo" id="head" onchange="headPic()" style="width:235px;padding-top:10px;margin-left:55px" data-validate="required:请选择头像">
			    <p class="help-block"></p>
			  </div> -->
			  <div class="form-group" style="padding-left:46%;">
			    <input type="button" onclick="toRegiste()" class="btn btn-success" style="margin-bottom:20px" value="提交信息">
			  </div>
			</form>
		</div>
    </div>
    <div style="width:500px;position:absolute;top:150px;left:430px;">
    	<div class="span loginbox" style="padding-top:10px;display:none" id="login">
		    <form id="frm1" action="account/toJump" method="post" enctype="multipart/form-data">
			  <div class="text-center margin-big padding-big-top"><h1 style="font-size:40px;font-weight:bold;color:#fff">登录</h1></div>
                    <div class="panel-body" style="padding:30px; padding-bottom:10px; padding-top:10px;">
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <input type="text" class="input input-big" id="userName1" name="userName" value="<%=name %>" placeholder="登录账号" data-validate="required:请填写账号" />
                                <span class="icon icon-user margin-small" style="padding-top:8px"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <input type="password" class="input input-big" id="pwd1" name="pwd" value="<%=pwd %>" placeholder="登录密码" data-validate="required:请填写密码" />
                                <span class="icon icon-key margin-small" style="padding-top:8px"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div id="mes"></div>
                        </div>
                       
                        <div>
                        	<span class="right"><a href="views/modules/front/login/forget_password.jsp">忘记密码？</a></span>
                        </div>
                        
                        <div>
                        	<span class="left"><input type="checkbox" name="remember" <%=check %>>记住密码</span>
                        </div> 
                    </div>
                    <div>
                    	<button type="button" onclick="toLogin(this.form)" class="btn btn-success" style="width:100px;margin-left:150px;margin-bottom:20px">登录</button>
                    	<button type="button" onclick="reg()" class="btn btn-warning" style="width:100px;margin-bottom:20px">注册</button>
                    </div>
			</form>
		</div>
    </div>
 </div>
 
 <div class="chooseHead">  	
 		<a onclick="subHead(this)"><img src="images/headImg1.jpg" width="100px" height="100px" class="img-circle" style="border-radius:50%"></a>
 		<a onclick="subHead(this)"><img src="images/headImg2.jpg" width="100px" height="100px" class="img-circle" style="border-radius:50%"></a>
 		<a onclick="subHead(this)"><img src="images/headImg3.jpg" width="100px" height="100px" class="img-circle" style="border-radius:50%"></a>
 </div>
  </body>
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
							$("#msg").html("用户名可用");
							$("#msg").css("color","green");
						}else if(data==1){
							$("#msg").html("用户名已存在");
							$("#msg").css("color","red");
						}
					}
				});
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
		
		function isPossible(){
			var phone = $("#phone").val();
			console.log(phone);
			if(isPhoneAvailable(phone)){
				$("#phoneMsg").text("可用");
				$("#phoneMsg").css("color","green");
			}else{
				$("#phoneMsg").text("不可用");
				$("#phoneMsg").css("color","red");
			}
		}
		
		$("#changeHead").click(function(){
			$(".bg").css("opacity","0.6");
			$(".chooseHead").show();
		});
		
		function subHead(head){
			$(".chooseHead").hide();
			$(".bg").css("opacity","1");
			var head = $(head).children().attr("src");
			$("#changeHead img").attr("src",head);
			$("#photo").val(head);
		}
		
		/* function headPic(){
			var path = $("#head").val();
			console.log(path);
			var str = "images/"+path.substring(12); 
			console.log(str);
			console.log(str);
			 $("#pic").attr("src",str);
		} */
		
		function checkPwd(){
			var pwd = $("#pwd").val();
			if(pwd.length < 5){
				$("#pwdMsg").text("不能小于5位");
				$("#pwdMsg").css("color","red");
			}else{
				$("#pwdMsg").text("");
			}
		}
		
		function toRegiste(){
			var s = $("#msg").text();
			var phone = $("#phoneMsg").text();
			var role = $("#role option:selected").val();
			var pwd = $("#pwd").val();
			var account = $("#account").val();
			var pwdMsg = $("#pwdMsg").text();
			if(s=="用户名可用" && phone=="可用" && pwd != '' && pwdMsg == '' && account != ''){
				$("#frm").submit();
				if(role == '1'){
					alert("恭喜！成功注册  将赠送您2000积分！");
				}
			}else if(s=="用户名已存在"){
				$("#msg").text("用户名已存在");
			}else if(s=="不可用"){
				$("#phoneMsg").text("不可用");
			}else{
				alert("请填写完整信息！");
			}
		}
		$(function(){
			var uname = "${user.userName}";
			if(uname!=""){
				log();
			}else{
				log();
			}
		});
		function reg(){
			$("#login").hide();
			$("#registe").show(400);
		}
		function log(){
			$("#registe").hide();
			$("#login").show(400);
		}
		function toLogin(form){
    		var userName = $("#userName1").val();
			var pwd = $("#pwd1").val();
			console.log(userName);
			console.log(pwd);
			if(userName.length != 0 && pwd.length != 0){
	    		$.ajax({
	    			type:"post",
					dataType:"json",
					url:"account/validate",
					data:$("#frm1").serialize(),
					success:function(result){
						if(result == "1"){
							$("#frm1").submit();
						}else if(result == "2"){
							alert("密码错误！");
						}else if(result == "3"){
							alert("该账号不存在");
						}
					}
	    		});
    		}
    	}
	</script>
</html>
