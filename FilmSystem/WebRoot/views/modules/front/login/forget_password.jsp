<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <link type="text/css" rel="stylesheet" href="css/forget_password.css">
    <style type="text/css">
		#msg{
			color:red;
			font-size:14px;
			display:none;
		}
		#pwdmsg{
			line-height:40px;
			color:red;
			font-size:14px;
			display:none;
		}
		#tb2,#tb3{
			padding-left:530px;
		}
    </style>
</head>
<body>
    <div>
        <div class="head">
            <h1>忘记密码</h1>
        </div>
        <div class="content">
            <table id="tb1">
                <tr>
                    <td>用户名：</td>
                    <td>
                        <input type="text" class="input input-big left" id="username" onfocus="clearMsg()">
                        <span id="msg"></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button type="button" onclick="checkName()" class="btn btn-success">确认</button>
                    </td>
                </tr>
            </table>
            <div id="tb2"  class="form-x">
                <div class="form-group">
		                <div class="label">
		                    <label>密保问题：</label>
		                </div>
		                <div class="field">
		                    <select id="question" name="securityQu" class="input w50" data-validate="required:请输入问题">
		                    	<option>----请选择密保问题----</option>
		                    	<option value="最喜欢的人">最喜欢的人</option>
		                    	<option value="最喜欢吃的水果">最喜欢吃的水果</option>
		                    	<option value="出生地">出生地</option>
		                    	<option value="妈妈的生日">妈妈的生日</option>
		                    	<option value="最喜欢的动物">最喜欢的动物</option>
		                    </select>
		                </div>
	            	</div>
                	<div class="form-group">
		                <div class="label">
		                    <label>答案：</label>
		                </div>
		                <div class="field">
		                    <input type="text" id="answer" class="input w50" size="50" data-validate="required:请输入答案"/>
		                    <span id="ansmsg"></span>
		                    
		                </div>
	            	</div>
	            	<div style="padding-left:200px"> 
	                    <label><a id="noQuestion">暂无密保</a></label>
	                </div>
                	<div class="form-group">
		                <div class="label">
		                    <label></label>
		                </div>
		                <div class="field">
		                    <button class="button bg-main icon-check-square-o" type="button" onclick="checkQuestion()"> 确认</button>
		                </div>
            		</div>
            </div>
            <div id="tb3">
            	<form action="views/modules/front/login/login.jsp" method="post" class="form-x">
		            <div class="form-group">
		                <div class="label">
		                    <label>新密码：</label>
		                </div>
		                <div class="field">
		                    <input type="password"  class="input w50" id="newpassword" name="newpass" size="50" placeholder="请输入新密码" data-validate="required:请输入新密码,length#>=5:新密码不能小于5位" />
		                </div>
		            </div>
		            <div class="form-group">
		                <div class="label">
		                    <label>确认新密码：</label>
		                </div>
		                <div class="field">
		                    <input type="password" class="input w50" name="renewpass" size="50" placeholder="请再次输入新密码" data-validate="required:请再次输入新密码,repeat#newpass:两次输入的密码不一致" />
		                </div>
		            </div>
                	<div class="form-group">
		                <div class="label">
		                    <label></label>
		                </div>
		                <div class="field">
		                    <button class="button bg-main icon-check-square-o" type="button" onclick="changePwd(this.form)"> 提交</button>
		                </div>
            		</div>
            	</form>
        	</div>
    </div>
</body>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function checkName(){
		var username = $("#username").val();
		if(username != ''){
			$.ajax({
				url:"account/validateUsername",
				type:"post",
				data:{userName:username},
				dataType:"json",
				success:function(data){
					if(data == '2'){//用户不存在
						$("#msg").html("用户不存在");
						$("#msg").css("display","block");
					}else if(data == '1'){//用户存在
						$("#tb1").hide();
						$("#tb3").hide();
						$("#tb2").show();
					}
				}
			});
		}else{
			alert("请输入用户名！");
		}
		
	}
	
	function changePwd(frm){
		var mess = $("#pwdmsg").text();
		if(mess=="原密码错误"){
			
		}else{
			var username = $("#username").val();
			var newpassword = $("#newpassword").val();
			var renewpass = $("input[name='renewpass']").val();
			if(newpassword >= 5 && newpassword == renewpass){
				$.ajax({
					url:"account/updateUser",
					data:{userName:username,pwd:newpassword},
					type:"post",
					dataType:"json",
					success:function(data){
					console.log(data);
						if(data=="1"){
							alert("修改成功！请登录");
							frm.submit();
						}else{
							alert("信息有误");
						}
					}
				});
			}else{
				alert("信息有误");
			}
		}
	}
	function checkQuestion(){
		var username = $("#username").val();
		var question = $("#question").val();
		var answer = $("#answer").val();
		if(question != "" && answer != ""){
			$.ajax({
				url:"account/selQueAndAnswer",
				data:{userName:username,question:question,answer:answer},
				type:"post",
				dataType:"json",
				success:function(data){
					if(data==2){
						alert("验证失败，请重新输入！");
					}else if(data==1){
						$("#tb1").hide();
						$("#tb2").hide();
						$("#tb3").show();
					}
				}
			});
		}else{
			
		}
	}
	
	function clearMsg(){
		$("#msg").html("");
	}
	$(function(){
		$("#tb2").hide();
		$("#tb3").hide();
		$("#noQuestion").click(function(){
			var username = $("#username").val();
			$.ajax({
				url:"account/checkQuestion",
				data:{userName:username},
				type:"post",
				dataType:"json",
				success:function(data){
					if(data == 1){
						alert("请验证密保");
					}else if(data == 2){
						$("#tb1").hide();
						$("#tb2").hide();
						$("#tb3").show();
					}
				}
			});
		});
	});
</script>
</html>