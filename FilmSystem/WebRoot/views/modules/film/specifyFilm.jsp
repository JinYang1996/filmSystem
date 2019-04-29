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
	    	width:10px;
	    	vertical-align: middle;
	    }
	</style>
  <body>
    <div class="panel admin-panel" style="width:1000px;margin:20px auto">
    <div class="panel-head"><strong><span class="icon-key"></span>影片详情表</strong></div>
    <div class="body-content">
        <div class="form-group">
            
            <form id="frm1" action="filmDetail/saveFilmPrice" method="post">
	            <div class="field">
	            	<input type="hidden" name="id" value="${film.id }">
	            	<table class="table table-hover text-center">
	            		<tr>
	            			<td>影片：</td>
	            			<td><img alt="" src="${film.picture }" width="100px"></td>
	            		</tr>
	            		<tr>
	            			<td>电影名：</td>
	            			<td>${film.title }</td>
	            		</tr>
	            		<tr>
	            			<td>导演：</td>
	            			<td>${film.direct }</td>
	            		</tr>
	            		<tr>
	            			<td>编剧：</td>
	            			<td>${film.screenWriter }</td>
	            		</tr>
	            		<tr>
	            			<td>主演：</td>
	            			<td>${film.leadingRole }</td>
	            		</tr>
	            		<tr>
	            			<td>类型：</td>
	            			<td>${type }</td>
	            		</tr>
	            		<tr>
	            			<td>制片国家/地区：</td>
	            			<td>${film.state }</td>
	            		</tr>
	            		<tr>
	            			<td>语言：</td>
	            			<td>${film.language }</td>
	            		</tr>
	            		<tr>
	            			<td>上映日期：</td>
	            			<td>${film.releaseDate }</td>
	            		</tr>
	            		<tr>
	            			<td>片长：</td>
	            			<td>${film.filmLength }</td>
	            		</tr>
	            		<tr>
	            			<td>又名：</td>
	            			<td>${film.alternateName }</td>
	            		</tr>
	            		<tr>
	            			<td>简介：</td>
	            			<td><p style="text-align:left">${film.brief }</p></td>
	            		</tr>
	            		<tr>
	            			<td>豆瓣评分：</td>
	            			<td>${film.score }</td>
	            		</tr>
	            		<tr>
	            			<td>销量：</td>
	            			<td>${film.sales }</td>
	            		</tr>
	            		<tr>
	            			<td>价格：</td>
	            			<td><input type="number" class="input input-big"  name="price" onblur="checkPrice(this)" value="${film.price }" style="width:120px;margin:0 auto"></td>
	            		</tr>
	            	</table>
	            	
	            </div>
	        </form>
        </div>
        <button onclick="savePrice()" class="btn btn-success" style="margin-left:500px;">保存</button>
	    </div>
	</div>
  </body>
    <script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
    	function checkPrice(price){
    		var reg = /^[0-9]+.?[0-9]*$/;
    		if(reg.test($(price).val())){
    			if(parseFloat($(price).val()) >= 0){
    				$(price).val(parseFloat($(price).val()).toFixed(2));
    			}
    		}else{
    			alert("请输入正确的价格");
    		}
    	}
    	function savePrice(){
    		$("#frm1").submit();
    	}
    </script>
</html>
