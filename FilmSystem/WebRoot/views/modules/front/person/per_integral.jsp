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
    <style type="text/css">
        table {
            table-layout: fixed;
        }
        td { white-space: nowrap;overflow: hidden;text-overflow: ellipsis;}
    </style>
</head>
<body>
<div>
    <div class="panel admin-panel">
        <div class="panel-head"><strong><span class="icon-key"></span> 积分记录</strong></div>
        <table class="table table-hover text-center">
            <tr>
            	<th width="6%">序号</th>
                <th width="47%">使用情况</th>
                <th width="13%">积分</th>
                <th width="20%">记录时间</th>
            </tr>
     		<c:forEach items="${integralList }" var="integral" varStatus="s">
	            <tr>
	            	<td>${s.count }</td>
	                <td>${integral.integralSource }</td>
	                <td>${integral.score}</td>
	                <td><fmt:formatDate type="both" value="${integral.achieveTime }"></fmt:formatDate></td>
	               
	            </tr>
            </c:forEach>
        </table>
        </div>
    </div>
    
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	
</script>
</html>