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
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/reset.css">
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
</head>
<style type="text/css">
    .form-x .form-group .label{
        width:100px;
    }
    .left{
    	float:left;
    }
    td{
    	vertical-align:middle;
    }
</style>
<body>
<div class="panel admin-panel" style="width:830px;margin:20px auto">
    <div class="panel-head"><strong><span class="icon-key"></span>我的评论</strong></div>
    <table class="table table-hover text-center">
        <tr>
        	<th width="7%">序号</th>
            <th width="12%">影片</th>
            <th width="15%">影片名</th>
            <th width="12%">评论内容</th>
            <th width="10%">审核状态</th>
            <th width="15%">点赞数</th>
            <th width="15%">评论时间</th>
        </tr>
 		<c:forEach items="${evaluateList }" var="evaluate" varStatus="s">
         <tr onclick="evaluateDetail('${evaluate.id}',event)">
         	 <td style="vertical-align:middle;">${s.count }</td>
             <td style="vertical-align:middle;"><img src="${evaluate.filmDetail.picture}" height="60px"></td>
			 <td style="vertical-align:middle;">${evaluate.filmDetail.title}</td>
			 <td style="vertical-align:middle;">${evaluate.content}</td>
			 <td style="vertical-align:middle;">
			 	<c:if test="${evaluate.reviewStatus == '1'}">未审核</c:if>
			 	<c:if test="${evaluate.reviewStatus == '0'}">已通过</c:if>
			 	<c:if test="${evaluate.reviewStatus == '2'}">未通过</c:if>
			 </td>
			 <td style="vertical-align:middle;">
			 	${evaluate.likes}
			 </td>
			 <td style="vertical-align:middle;">
			 	<fmt:formatDate value="${evaluate.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
			 </td>
         </tr>
        </c:forEach>
    </table>
</div>
</body>
  <script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
  <script type="text/javascript">
  		function evaluateDetail(id,e){
  			if(e.target.cellIndex <= 7){
  				location.href="evaluate/specifyEvaluate?id="+id;
  			}
  		}
  </script>
</html>