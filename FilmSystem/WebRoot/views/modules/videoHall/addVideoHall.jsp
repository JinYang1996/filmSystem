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
</head>
<style type="text/css">
    .form-x .form-group .label{
        width:100px;
    }
    #frm{
    	margin-left:20px;
    }
</style>
<body>
<div class="panel admin-panel" style="width:800px;margin:20px auto">
    <div class="panel-head"><strong><span class="icon-key"></span>影院详情表</strong></div>
    <div class="body-content">
        <form id="frm" method="post" class="form-x" action="videoHall/addVideoHall">
        	<table>
        		<tr>
        			<td>&nbsp;&nbsp;&nbsp;&nbsp;影院名：</td>
        			<td>
        				<input type="text" class="input input-mid" name="hallName" id="hallName" onblur="checkHallName()">
        				
        			</td>
        			<td><span id="msg"></span></td>
        		</tr>
        		<tr>
        			<td>影厅规格：行 &nbsp;&nbsp;&nbsp;&nbsp; </td>
        			<td>
        				<label style="line-height:33px;">
	                    	<select name="hallRow" class="input input-mid" style="width:50px">
	                    		<option value="5">5</option>
	                    		<option value="6">6</option>
	                    		<option value="7">7</option>
	                    		
	                    	</select>
	                    </label>
        			</td>
        		</tr>
        		<tr>
        			<td>影厅规格：列  &nbsp;&nbsp;&nbsp;&nbsp;</td>
        			<td>
        				<label style="line-height:33px;">
	                    	<select name="hallCol" class="input input-mid" style="width:50px">
	                    		<option value="5">5</option>
	                    		<option value="6">6</option>
	                    		<option value="7">7</option>
	                    		<option value="8">8</option>
	                    		
	                    	</select>
	                    </label>
        			</td>
        		</tr>
        		<tr>
        			<td></td>
        			<td>
        				<input type="button" id="sbt" class="btn btn-primary" value="提交">
        			</td>
        		</tr>
        	</table>
            
        </form>
    </div>
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	function checkHallName(){
		var hallName = $("#hallName").val();
		if(hallName != ""){
			$.ajax({
				type:"post",
				dataType:"json",
				url:"videoHall/validateHallName",
				data:{hallName:hallName},
				success:function(data){
					if(data == "1"){
						$("#msg").text("影院名称可用");
						$("#msg").css("color","green");
					}else{
						$("#msg").text("该影院名称已存在！");
						$("#msg").css("color","red");
					}
				}
			});
		}else{
			$("#msg").text("影院名称不能为空！");
			$("#msg").css("color","red");
		}
		
	}
	$("#sbt").click(function(){
		var msg = $("#msg").text();
		if(msg == "影院名称可用")
			$("#frm").submit();
	});
</script>
</html>