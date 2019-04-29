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
    <div class="panel-head"><strong><span class="icon-key"></span>我的预约</strong></div>
    <table class="table table-hover text-center">
        <tr>
        	<th width="7%">序号</th>
            <th width="12%">影片</th>
            <th width="15%">影片名</th>
            <th width="12%">预约时间</th>
            <th width="10%">审核状态</th>
            <th width="15%">创建时间</th>
            <th width="30%">操作</th>
        </tr>
 		<c:forEach items="${applyList }" var="apply" varStatus="s">
         <tr onclick="orderDetail('${apply.filmDetail.id}',event)">
         	 <td style="vertical-align:middle;">${s.count }</td>
             <td style="vertical-align:middle;"><img src="${apply.filmDetail.picture}" height="60px"></td>
			 <td style="vertical-align:middle;">${apply.filmDetail.title}</td>
			 <td style="vertical-align:middle;">${apply.applyTime}</td>
			 <td style="vertical-align:middle;">
			 	<c:if test="${apply.reviewStatus == '1'}">未审核</c:if>
			 	<c:if test="${apply.reviewStatus == '0'}">已通过</c:if>
			 	<c:if test="${apply.reviewStatus == '2'}">未通过</c:if>
			 </td>
			 <td style="vertical-align:middle;">
			 	<fmt:formatDate value="${apply.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
			 </td>
             <td style="vertical-align:middle;">
             	<c:choose>
             		<c:when test="${apply.reviewStatus == '1' }">
             			<div class="button-group">
		          			<a class="button border-red left" style="width:100px;" href="javascript:void(0)" onclick="del('${apply.id}')">
		                       <span class="icon-trash-o"></span> 取消
		                    </a>
		                 </div>
             		</c:when>
             		<c:otherwise>
		             	 <div class="button-group">
		          			<a class="button border-yellow left" style="width:100px;" href="javascript:void(0)">
		                       <span class="icon-delicious"></span> 已完成
		                    </a>
		                 </div>
	             	</c:otherwise>
             	</c:choose>
             </td>
         </tr>
        </c:forEach>
    </table>
</div>
</body>
  <script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
  <script type="text/javascript">
  		function del(id){
  			if(confirm("确定要取消预约吗？")){
  				location.href="applyArrange/cancelApply?id="+id;
  			}
  		}
  		
  		function orderDetail(id,e){
			if(e.target.cellIndex <= 6){
				top.location.href="filmDetail/selectedFilm?id="+id;
			}
		}
  </script>
</html>