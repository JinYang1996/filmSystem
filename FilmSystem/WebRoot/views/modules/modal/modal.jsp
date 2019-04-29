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
	<meta charset="utf-8"> 
	<title>Bootstrap 实例 - 模态框（Modal）插件</title>
	<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					联系管理员
				</h4>
			</div>
			<div class="modal-body">
				<div id="context" style="height:300px;overflow:scroll"></div>
				<textarea rows="4" cols="68" id="msg"></textarea>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="onSend()">
					发送
				</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>
