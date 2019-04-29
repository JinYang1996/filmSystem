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
    .right{
    	float:right;
    }
    .table{
    	text-align:center;
    }
    .content td{
    	font-size:14px;
    }
</style>
<body>
<div class="panel admin-panel" style="width:1000px;margin:20px auto">
    <div class="panel-head"><strong><span class="icon-key"></span>优惠券表</strong></div>
    	<div class="container-fluid">
        	<form action="coupon/showAllCoupon" method="post" id="frm">
        		<div class="form-group" style="margin-top:20px;margin-left:5px">
        			<input type="hidden" name="pageNo" value="0">
        			<label>优惠名：</label>
        			<input type="text" class="form-control" name="couponName" value="${coupon.couponName }" style="width:150px;display:inline-block">
        			
        			<label>类型</label>
        			<select class="form-control" id="type" name="type" style="width:150px;display:inline-block">
        				<option value="">-----请选择-----</option>
        				<option value="0">通用</option>
        				<option value="1">专用</option>
        			</select>
        			
        			<label>影片名：</label>
        			<input type="text" class="form-control" name="filmDetail.title" value="${coupon.filmDetail.title }" style="width:150px;display:inline-block">  			
        			<button onclick="sub()" class="btn btn-success" style="margin:-5px 0 0 40px">查询</button>
        			<button type="button" class="btn btn-primary" onclick="toAddCoupon()" style="margin:-5px 0 0 40px">新增</button>
        		</div>
        	</form>
        </div>
    <div class="body-content">
            <div class="form-group">
            	
                <table class="table">
                	<tr>
                		<td>序号</td>
                		<td>优惠券名</td>
                		<td>优惠价格</td>
                		<td>类型</td>
                		<td>影片名</td>
                		<td>操作</td>
                	</tr>
                	<c:forEach items="${page.data }" var="coupon" varStatus="s">
	                	<tr class="content">
	                		<td style="line-height:33px;">${s.count }</td>
	                		<td style="line-height:33px;">${coupon.couponName }</td>
	                		<td style="line-height:33px;"><fmt:formatNumber value="${coupon.couponPrice }" pattern="#.00"/></td>
	                		<td style="line-height:33px;">
	                			<c:if test="${coupon.type == '1' }">
	                				专用
	                			</c:if>
	                			<c:if test="${coupon.type == '0' }">
	                				通用
	                			</c:if>
	                		</td>
	                		<td style="line-height:33px;">${coupon.filmDetail.title }</td>
	                		<td>
	                			<button type="button" onclick="update('${coupon.id}')" class="btn btn-info">修改</button>
	                			<button type="button" onclick="del('${coupon.id}')" class="btn btn-danger">删除</button>
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
             <input type="hidden" id="page_no" value="${page.pageNo}"/>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	function update(id){
		location.href="coupon/toUpdateCoupon?id="+id;
	}
	
	function del(id){
		if(confirm("确认要删除该条优惠券吗？")){
			/* var paNo = $("#page_no").val();
			location.href="coupon/delCoupon?id="+id + "&pageNo="+ paNo; */
			$.ajax({
				url:"coupon/delCoupon",
				data:{id:id},
				dataType:"json",
				type:"post",
				success:function(data){
					if(data == '2'){
						alert("该优惠券被占用，删除失败");
					}
					window.location.reload();
				}
			});
		}
	}
	
	$(function(){
		var status = '${coupon.type}';
		console.log(status);
		$("#type option").each(function(index,item){	
			console.log($(item).val());
			if($(item).val() == status){
				$(item).prop("selected","selected");
			}
		});
		var date = $("#createD").text();
		console.log(date);
		$("input[name='applyTime']").val(date);
		
		var sumPage = '${page.sumPage}';
		for (i = 1; i <= sumPage; i++) {
			$("#pNo").append('<a id="num'+i+'" onclick="toPage(this)" data-page="'+i+'">'+i+'</a>');
		}
		var paNo = $("#page_no").val();
		$("#num"+paNo).css("background","#1CB2EF");
		
		$("#message b",parent.document).text('${count}'+" ");
	});
	
	function toPage(p) {
		var paNo = $(p).attr("data-page");
		$("input[name='pageNo']").val(paNo);
		$("#frm").submit();
	}
	
	function toAddCoupon(){
		location.href="coupon/toAddCoupon";
	}
</script>
</html>