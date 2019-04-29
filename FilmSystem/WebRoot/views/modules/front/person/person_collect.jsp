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
        <div class="panel-head"><strong><span class="icon-key"></span> 收藏列表</strong></div>
        <table class="table table-hover text-center">
            <tr>
            	<th width="6%">序号</th>
                <th width="20%">影片</th>
                <th width="37%">影片名</th>
                <th width="20%">收藏时间</th>
                <th width="20%">操作</th>
            </tr>
     		<c:forEach items="${collectList }" var="collect" varStatus="s">
	            <tr onclick="orderDetail('${collect.filmDetail.id}',event)">
	            	<td>${s.count }</td>
	                <td><img src="${collect.filmDetail.picture }" height="100px"/></td>
	                <td>${collect.filmDetail.title}</td>
	                <td><fmt:formatDate type="both" value="${collect.collectTime }"></fmt:formatDate></td>
	                <td>
	                    <div class="button-group">
	                        <a class="button border-red" href="javascript:void(0)" onclick="del('${collect.id}')">
	                            <span class="icon-trash-o"></span> 取消收藏
	                        </a>
	                    </div>
	                </td>
	            </tr>
            </c:forEach>
        </table>
        </div>
    </div>
    
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	
	function del(id){
		if(confirm("确定要删除吗？")){
			location.href="collect/delCollect?id="+id;
		}	
	}
	
	function orderDetail(id,e){
		if(e.target.cellIndex <= 4){
			top.location.href="filmDetail/selectedFilm?id="+id;
		}
	}
</script>
</html>