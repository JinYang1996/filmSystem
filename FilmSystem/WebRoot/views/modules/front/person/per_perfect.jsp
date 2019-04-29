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
        .panel{
        	position:relative;
        }
        /* .addScore{
        	width:80px;
        	height:40px;
        	line-height:40px;
        	font-size:20px;
        	position:fixed;
        	top:100px;
        	left:350px;
        	z-index:2;
        	background-color:rgb(223,225,225);
        	text-align:center;
        	display:none;
        } */
    </style>
</head>
<body>
<div class="panel admin-panel" style="width:800px;margin:20px auto">
	<!-- <div class="addScore">+20</div> -->
    <div class="panel-head"><strong id="title"><span class="icon-key"></span> 完善个人信息</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="account/perfectPerson">
        	<input type="hidden" name="id" value="${user.id }">
        	<input type="hidden" name="userName" value="${user.userName }">
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
                    <label>昵称：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       	${user.account }
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>真实姓名：</label>
                </div>
                <div class="field">
                	<c:if test="${user.trueName == null }">
                   		<input type="text" class="input w50" name="trueName" size="50" placeholder="请输入真实姓名" data-validate="required:请输入真实姓名" />
                	</c:if>
                	<c:if test="${user.trueName != null }">
                   		<label style="line-height:33px;">
                       	${user.trueName }
                    </label>
                	</c:if>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>邮箱：</label>
                </div>
                <div class="field">
	                <c:if test="${user.email == null }">
	                    <input type="text" class="input w50" name="email" size="50" placeholder="请输入邮箱" data-validate="required:请输入邮箱" onblur="checkEmail(this)"/>
	                    <span style="width:150px;height:18px;display:inline-block;margin:10px 0 0 10px;color:red" id="msg"></span>
	                </c:if>
                	<c:if test="${user.email != null }">
                   		<label style="line-height:33px;">
                       		${user.email }
                    	</label>
                	</c:if>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>电话：</label>
                </div>
                <div class="field">
                 	<label style="line-height:33px;">
                     	${user.phone }
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>性别：</label>
                </div>
                <div class="field">
                	
	                <c:if test="${user.sex == null }">
	                    <input type="radio" name="sex" value="1">男
                    	<input type="radio" name="sex" value="0">女
	                </c:if>
	                <c:if test="${user.sex != null }">
	                    <label style="line-height:33px;" id="showSex">
	                       	
	                    </label>
	                </c:if>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>出生日期：</label>
                </div>
                <div class="field">
                	<c:if test="${user.birthday == null }">
	                    <input type="date" class="input w50" name="birthday" size="50" data-validate="required:请输入生日"/>
                    </c:if>
                    <c:if test="${user.birthday != null }">
                    	<label style="line-height:33px;">
                       		${user.birthday }
                       	</label>
                    </c:if>
                </div>
            </div>
            <c:if test="${user.securityQu == null }">
	            <div class="form-group">
	                <div class="label">
	                    <label>密保问题：</label>
	                </div>
	                <div class="field">
	                	<c:if test="${user.securityQu == null }">
		                    <select name="securityQu" class="input w50">
		                    	<option>----请选择密保问题----</option>
		                    	<option value="最喜欢的人">最喜欢的人</option>
		                    	<option value="最喜欢吃的水果">最喜欢吃的水果</option>
		                    	<option value="出生地">出生地</option>
		                    	<option value="妈妈的生日">妈妈的生日</option>
		                    	<option value="最喜欢的动物">最喜欢的动物</option>
		                    </select>
	                    </c:if>
	                    <c:if test="${user.securityQu != null }">
	                    	<label style="line-height:33px;">
	                       		${user.securityQu }
	                       	</label>
	                    </c:if>
	                </div>
	            </div>
	            <div class="form-group">
	                <div class="label">
	                    <label>密保答案：</label>
	                </div>
	                <div class="field">
	                	<c:if test="${user.securityAnswer==null }">
	                   		<input type="text" class="input w50" name="securityAnswer" size="50" placeholder="请输入密保答案" data-validate="required:请输入密保答案" />
	                	</c:if>
	                	<c:if test="${user.securityAnswer!=null }">
	                		<label style="line-height:33px;">
	                       		${user.securityAnswer }
	                       	</label>
	                	</c:if>
	                </div>
	            </div>
            </c:if>
            <div class="form-group">
                <div class="label">
                    <label></label>
                </div>
                <div class="field">
                    <button class="button bg-main icon-check-square-o" id="btn" type="button" onclick="perfect(this.form)"> 提交</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function perfect(frm){
		var  trueName = $("input[name='trueName']").val();
		var  email = $("input[name='email']").val();
		var  sex = $("input[name='sex']").val();
		var  securityQu= $("select[name='securityQu']").val();
		var  securityAnswer= $("input[name='securityAnswer']").val();
		var birthday = $("input[name='birthday']").val();
		var msg = $("#msg").text();
		console.log(trueName+","+email+","+sex+","+securityQu+","+securityAnswer+","+birthday);
		if(trueName!='' && email != '' && msg != '请输入有效邮箱地址' && sex != '' && birthday !='' && securityQu != '----请选择密保问题----' && securityAnswer!=''){
			alert("完善个人信息成功！赠送5000积分");
			frm.submit();
		}else{
			alert("请填写完整信息");
		}
	}
	$(function(){
		var sex = "${user.sex}";
		if(sex == 0){
			$("#showSex").append('女');
		}else if(sex==1){
			$("#showSex").append('男');
		}
		if(sex != ''){
			$("#title").html("个人信息");
			$("#btn").css("display","none");
		}
	});
	
	function checkEmail(email){
		var reg = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
		var emailVal = $(email).val();
		if(!reg.test(emailVal) && emailVal != ''){
			$("#msg").text("请输入有效邮箱地址");
			$("#emsg").css("color","red");
			$(email).css("border-color","red");
		}else{
			$("#msg").text("");
			$(email).css("border-color","#22CC77");
			$(email).css("background-color","#fff");
		}
	}
</script>
</html>