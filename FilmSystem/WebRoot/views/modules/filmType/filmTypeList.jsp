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
	</style>
  <body>
    <div class="panel admin-panel" style="width:800px;margin:20px auto">
	    <div class="panel-head"><strong><span class="icon-key"></span>影片类型表</strong></div>
	    <div class="body-content">
        	<form action="filmType/selFilmType" method="post" id="frm">
        		<div class="form-group" style="margin-top:5px;margin-left:5px">
        			<label>类型名：</label>
        			<input type="text" class="form-control" name="typeName" value="${filmType.typeName }" style="width:150px;display:inline-block">
        			
        			<button onclick="sub()" class="btn btn-success" style="margin:-5px 0 0 40px">查询</button>
        			<button class="btn btn-primary" style="margin-right:10px;margin:-5px 0 0 40px" onclick="toAddType()">新增</button>
        		</div>
        	</form>
        </div>
	    <div class="body-content">
	        <div class="form-group">
	            <table class="table table-hover text-center">
	            	<tr>
	            		<th>编号</th>
	            		<th>类型名</th>
	            	</tr>
	            	<c:forEach items="${typeList }" var="type">
	            		<tr>
		            		<td>${type.id }</td>
		            		<td>${type.typeName }</td>
		            	</tr>
	            	</c:forEach>
	            </table>
	        </div>
	    </div>
	</div>
  </body>
    <script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
    	function toAddType(){
    		location.href="views/modules/filmType/addFilmType.jsp";
    	}
    </script>
</html>
