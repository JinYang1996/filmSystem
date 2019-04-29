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
        <div class="panel-head"><strong><span class="icon-key"></span> 电影列表</strong></div>
        <div class="container-fluid">
        	<form action="filmDetail/selByFilm" method="post" id="frm">
        		<div class="form-group" style="margin-top:5px;">
        			<input type="hidden" name="pageNo" value="0">
        			<label>电影名称：</label>
        			<input type="text" class="form-control" name="title" value="${filmDetail.title }" style="width:150px;display:inline-block">
        			
        			<label>上映日期：</label>
        			<input type="text" class="form-control" name="releaseDate" value="${filmDetail.releaseDate }" style="width:150px;display:inline-block">
        			
        			<label>导演：</label>
        			<input type="text" class="form-control" name="direct" value="${filmDetail.direct }" style="width:150px;display:inline-block">
        		</div>
        		
        		<div class="form-group" style="margin-top:5px;margin-left:5px">
        			<label>演&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;员：</label>
        			<input type="text" class="form-control" name="leadingRole" value="${filmDetail.leadingRole }" style="width:150px;display:inline-block">
        			
        			<label>&nbsp;&nbsp;类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：</label>
        			<%-- <input type="text" class="form-control" name="type" value="${filmDetail.type }" style="width:150px;display:inline-block"> --%>
        			<select class="form-control" name="type" style="width:150px;display:inline-block">
        				<option>-----请选择-----</option>
        				<c:forEach items="${typeList }" var="type">
        					<c:choose>
	 							<c:when test="${type.typeName == filmDetail.type }">
	 								<option value="${filmDetail.type }" selected>${filmDetail.type }</option>
	 							</c:when> 
	 							<c:otherwise>
	 								<option value="${type.typeName }">${type.typeName }</option>
	 							</c:otherwise>      				
	        				</c:choose>
        				</c:forEach>
        			</select>
        			
        			<label>语言：</label>
        			<input type="text" class="form-control" name="language" value="${filmDetail.language }" style="width:150px;display:inline-block">
        			
        			<button onclick="sub()" class="btn btn-success" style="margin:-5px 0 0 40px">查询</button>
        		</div>
        	</form>
        </div>
        <table class="table table-hover text-center">
            <tr>
            	<th width="6%">序号</th>
                <th width="15%">影片</th>
                <th width="20%">影片名</th>
                <th width="15%">导演</th>
                <th width="20%">上映日期</th>
                <th width="20%">语言</th>
                <th width="20%">价格</th>
                <th width="20%">操作</th>
            </tr>
     		<c:forEach items="${page.data }" var="film" varStatus="s">
	            <tr>
	            	<td style="vertical-align: middle">${s.count }</td>
	                <td style="vertical-align: middle"><img src="${film.picture }" height="100px"/></td>
	                <td style="vertical-align: middle">${film.title}</td>
	                <td style="vertical-align: middle">${film.direct}</td>
	                <td style="vertical-align: middle">${film.releaseDate}</td>
	                <td style="vertical-align: middle">${film.language}</td>
	                <td style="vertical-align: middle">
	                	<c:if test="${film.price != 0.0 }">
	                		<fmt:formatNumber value="${film.price }" pattern="#.00"/>
	                	</c:if>
	                	<c:if test="${film.price == 0.0 }">
	                		0
	                	</c:if>
	                </td>
	                <td style="vertical-align: middle">
	                	<button type="button" onclick="upd('${film.id}')" class="btn btn-info">修改</button>
	                	<button type="button" onclick="del('${film.id}')" class="btn btn-danger">删除</button>
	                </td>
	            </tr>
            </c:forEach>
        </table>
        <div class="pagelist"> 
	    	<a onclick="toPage(this)" data-page="1" id="home" class="home left">首页</a>
	    	<c:if test="${page.pageNo>1 }">
	    		<a onclick="toPage(this)" data-page="${page.pageNo-1 }">上一页</a>
	    	</c:if>
	   		<span id="pNo"></span>
	   		<c:if test="${page.pageNo<page.sumPage }">
	   			<a onclick="toPage(this)" data-page="${page.pageNo+1 }">下一页</a>
	   		</c:if>
	   		<a onclick="toPage(this)" data-page="${page.sumPage }">尾页</a> 
	   	</div>
        </div>
        <input type="hidden" id="page_no" value="${page.pageNo}"/>
    </div>
    
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	
	function upd(id){
		location.href="filmDetail/getFilmDetail?id="+id;
	}
	
	function del(id){
		if(confirm("确定要删除吗？")){
			/* var paNo = $("#page_no").val();
			location.href="filmDetail/delFilm?id="+id + "&pageNo="+ paNo; */
			$.ajax({
				url:"filmDetail/delFilm",
				data:{id:id},
				dataType:"json",
				type:"post",
				success:function(data){
					if(data == '2'){
						alert("该影片被占用，删除失败");
					}
					window.location.reload();
				}
			});
		}
	}
	
	function sub(){
		$("#frm").submit();
	}
	
	$(function() {
		var sumPage = '${page.sumPage}';
		if(sumPage > 10){
			for (i = 1; i <= 10; i++) {
				$("#pNo").append('<a id="num'+i+'" onclick="toPage(this)" data-page="'+i+'">'+i+'</a>');
			}
			$("#pNo").append('<a>...</a>');
		}else{
			for (i = 1; i <= sumPage; i++) {
				$("#pNo").append('<a id="num'+i+'" onclick="toPage(this)" data-page="'+i+'">'+i+'</a>');
			}
		}
		var paNo = $("#page_no").val();
		$("#num"+paNo).css("background","#1CB2EF");
	});
	
	function toPage(p) {
		var paNo = $(p).attr("data-page");
		$("input[name='pageNo']").val(paNo);
		$("#frm").submit();
	}
</script>
</html>