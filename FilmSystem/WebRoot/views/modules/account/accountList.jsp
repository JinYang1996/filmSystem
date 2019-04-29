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
    	body{
    		font-size:12px;
    	}
        table {
            table-layout: fixed;
        }
        td { white-space: nowrap;overflow: hidden;text-overflow: ellipsis;}
    </style>
</head>
<body>
<div>
    <div class="panel admin-panel">
        <div class="panel-head"><strong><span class="icon-key"></span>用户列表</strong></div>
        <div class="container-fluid">
        	<form action="account/selAccount" method="post" id="frm">
        		<div class="form-group" style="margin-top:5px;margin-left:13px;">
        			<input type="hidden" name="pageNo" value="0">
        			<label>用户名：</label>
        			<input type="text" class="form-control" name="userName" value="${account.userName }" style="width:150px;display:inline-block;">
        			
        			<label>真实姓名：</label>
        			<input type="text" class="form-control" name="trueName" value="${account.trueName }" style="width:150px;display:inline-block">
        			
        			<label>电话：</label>
        			<input type="text" class="form-control" name="phone" value="${account.phone }" style="width:150px;display:inline-block">
        		
        			<label>是否会员：</label>
        			<select name="isMember" class="form-control" style="width:150px;display:inline-block">
        				<option value="">--请选择--</option>
        				<option value="0">是</option>
        				<option value="1">否</option>
        			</select>
        		</div>
        		
        		<div class="form-group">
        			<label>上次登录：</label>
        			<input type="date" class="form-control" name="lastLogin" style="width:160px;display:inline-block">
        			<p style="display:none" id="last"><fmt:formatDate value="${account.lastLogin }" pattern="yyyy-MM-dd"/></p>
        			
        			<button onclick="sub()" class="btn btn-success" style="margin:-5px 0 0 40px">查询</button>
        			<c:if test="${user.role.id == '3' }">
        				<button type="button" onclick="addAdmin()" class="btn btn-danger" style="margin:-5px 0 0 40px">添加管理员</button>
        			</c:if>
        		</div>
        	</form>
        </div>
        <table class="table table-hover text-center">
            <tr>
            	<th width="6%">序号</th>
                <th width="10%">用户名</th>
                <th width="10%">真实姓名</th>
                <th width="15%">电话</th>
                <th width="8%">性别</th>
                <th width="15%">生日</th>
                <th width="10%">身份</th>
                <th width="19%">上次登录时间</th>
                <th width="15%">操作</th>
            </tr>
     		<c:forEach items="${page.data }" var="account" varStatus="s">
	            <tr>
	            	<td style="vertical-align: middle">${s.count }</td>
	                <td style="vertical-align: middle">${account.userName }</td>
	                <td style="vertical-align: middle">${account.trueName }</td>
	                <td style="vertical-align: middle">${account.phone }</td>
	               	<td style="vertical-align: middle">
	               		<c:if test="${account.sex == '1'}">女</c:if>
	               		<c:if test="${account.sex == '0'}">男</c:if>
	               	</td>
	                <td style="vertical-align: middle">${account.birthday }</td>
	                <td style="vertical-align: middle">
	                	<c:if test="${account.isMember == '1' }">
	                		<c:if test="${account.role.id == '1'}">
	                			用户
	                		</c:if>
	                		<c:if test="${account.role.id == '2'}">
	                			管理员
	                		</c:if>
	                	</c:if>
	                	<c:if test="${account.isMember == '0' }">
	                		vip用户
	                	</c:if>
	                </td>
	                <td style="vertical-align: middle">
	                	<fmt:formatDate value="${account.loginDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
	                </td>
	                <td style="vertical-align: middle">
	                	<button type="button" onclick="upd('${account.id}')" class="btn btn-info">修改</button>
	                	<c:if test="${user.role.id == '3' }">
	                		<button type="button" onclick="del('${account.id}')" class="btn btn-danger">删除</button>
	                	</c:if>
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
		location.href="account/selAccountDetail?id="+id;
	}
	
	function del(id){
		if(confirm("确定要删除吗？")){
			var paNo = $("#page_no").val();
			location.href="account/delAccount?id="+id + "&pageNo="+ paNo;
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
		
		var isMember = '${account.isMember}';
		console.log(isMember);
		$("select[name='isMember'] option").each(function(index,item){	
			console.log($(item).val());
			if($(item).val() == isMember){
				$(item).prop("selected","selected");
			}
		});
		
		var date = $("#last").text();
		console.log(date);
		$("input[name='lastLogin']").val(date);
	});
	
	function toPage(p) {
		var paNo = $(p).attr("data-page");
		$("input[name='pageNo']").val(paNo);
		$("#frm").submit();
	}
	
	function addAdmin(){
		location.href="views/modules/account/addAccount.jsp";
	}
</script>
</html>