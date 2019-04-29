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
    <div class="panel-head"><strong><span class="icon-key"></span> 修改密码</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="views/success/subSuccess.jsp">
            <div class="form-group">
                <div class="label">
                    <label>帐号：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                        ${user.userName }
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>原始密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input w50" id="password" onblur="checkPwd()" name="mpass" size="50" placeholder="请输入原始密码" data-validate="required:请输入原始密码" />
                    <span class="msg">&nbsp;&nbsp;</span>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>新密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input w50" id="newpassword" name="newpass" size="50" placeholder="请输入新密码" data-validate="required:请输入新密码,length#>=5:新密码不能小于5位" />
               		<span class="newmsg">&nbsp;&nbsp;</span>
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
                    <button class="button bg-main icon-check-square-o" onclick="changePwd(this.form)" type="button"> 提交</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function changePwd(frm){
		var userName = "${user.userName}";
		var newpassword = $("#newpassword").val();
		var password = $("#password").val();
		var renewpass = $("input[name='renewpass']").val();
		if(newpassword != '' && newpassword == password){
			$(".newmsg").html("新密码不能与旧密码相同");
			$(".newmsg").css("color","red");
		}else if(newpassword != '' && newpassword == renewpass){
			$.ajax({
				url:"account/updateUser",
				data:{userName:userName,pwd:newpassword},
				type:"post",
				dataType:"json",
				success:function(data){
					if(data == '1'){
						alert("修改成功！");
						frm.submit();
					}else{
						alert("请输入正确信息");
					}
				}
			});
		}else if(newpassword.length < 5){
			alert("密码长度要大于5！");
		}else if(newpassword != renewpass){
			alert("输入新密码和确认密码不同");
		}else{
			alert("输入有误");
		}
	}
	function checkPwd(){
		var password = $("#password").val();
		var userName = "${user.userName}";
		if(password != ''){
			$.ajax({
				url:"account/checkPwd",
				data:{userName:userName,pwd:password},
				type:"post",
				dataType:"json",
				success:function(data){
					if(data == "2"){
						$(".msg").html("密码有误");
						$(".msg").css("color","red");
					}else if(data == "1"){
						$(".msg").html("");
					}
				}
			});
		}
	}
</script>
	
</html>