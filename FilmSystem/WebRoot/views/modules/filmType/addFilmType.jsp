<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'specifyFilm.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
  </head>
  <style type="text/css">
  		body{
  			font-size:18px;
  		}
	    .form-x .form-group .label{
	        width:100px;
	    }
	    .right{
	    	float:right;
	    }
	    td{
	    	vertical-align: middle;
	    }
	    #frm{
	    	margin-left:20px;
	    }
	</style>
  <body>
    <div class="panel admin-panel" style="width:800px;margin:20px auto">
	    <div class="panel-head"><strong><span class="icon-key"></span>新增影片类型</strong></div>
	    <div class="body-content">
	        <div class="form-group">
	           	 <form action="filmType/addFilmType" method="post" id="frm">
	           	 	<table>
	           	 		<tr style="margin-top:10px;">
	           	 			<td>类型名称：</td>
	           	 			<td>
	           	 				<input type="text" class="input input-mid" name="typeName" onblur="checkType()">
	           	 				<span id="msg"></span>
	           	 			</td>
	           	 		</tr>
	           	 		<tr style="margin-top:10px;">
	           	 			<td></td>
	           	 			<td>
	           	 				<button type="button" onclick="add()" class="btn btn-info" style="margin-top:10px">新增</button>
	           	 			</td>
	           	 		</tr>
	           	 	</table> 
	           	 </form>
	        </div>
	    </div>
	</div>
  </body>
    <script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
    	function checkType(){
    		var typeName = $("input[name='typeName']").val();
    		if(typeName != ''){
    			$.ajax({
    				url:"filmType/checkType",
    				data:{typeName:typeName},
    				dataType:"json",
    				type:"post",
    				success:function(data){
    					if(data == '1'){
    						$("#msg").text("");
    					}else if(data == '2'){
    						$("#msg").text("类型名已存在");
    						$("#msg").css("color","red");
    					}
    				}
    			});
    		}
    	}
    	
    	function add(){
    		var typeName = $("input[name='typeName']").val();
    		if(typeName == ''){
    			alert("请填写类型名称");
    		}else{
    			var msg = $("#msg").text();
    			console.log(msg);
    			if(msg == ''){
    				$("#frm").submit();
    			}
    		}
    	}
    </script>
</html>
