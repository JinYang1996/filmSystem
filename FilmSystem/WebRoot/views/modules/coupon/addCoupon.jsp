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
    
    <!-- <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/datepicker-1.4.0/css/bootstrap-datepicker3.min.css">
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap-datetimepicker.min.css"> -->
     <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/jquery.datetimepicker.css">
</head>
<style type="text/css">
    .form-x .form-group .label{
        width:100px;
    }
    .right{
    	float:right;
    }
    #frm1{
    	margin-left:20px;
    }
    #frm1 table{
    	border-collapse:   separate; 
    	border-spacing:   10px;
    }
</style>
<body>
<div class="panel admin-panel" style="width:800px;margin:20px auto">
    <div class="panel-head"><strong><span class="icon-key"></span>添加优惠券</strong></div>
    <div class="body-content">
        <form id="frm1" action="coupon/addCoupon" method="post" style="float:left">
        	<table>
        		<tr style="margin-top:10px;">
        			<td>优惠券名称：</td>
        			<td>
        				<input class="input input-mid" type="text" name="couponName">
        			</td>
        		</tr>
        		<tr style="margin-top:10px;">
        			<td>优惠价格：</td>
        			<td>
        				<input type="number" class="input input-mid"  name="couponPrice" onblur="checkPrice(this)">
        			</td>
        		</tr>
        		<tr style="margin-top:10px;">
        			<td>类型：</td>
        			<td>
        				<select class="input input-mid" id="type" name="type" onblur="checkType()">
        					<option value="">请选择</option>
        					<option value="0">通用</option>
        					<option value="1">专用</option>
        				</select>
        			</td>
        		</tr>
        		<tr>
        			<td>影片：</td>
        			<td>
        				<select class="input input-mid" id="filmId" name="filmDetail.id" disabled="disabled">
        					<option value="0">请选择</option>
        					<c:forEach items="${filmList }" var="film">
        						<option value="${film.id }">${film.title }</option>
        					</c:forEach>
        				</select>
        			</td>
        		</tr>
        		<tr>
        			<td>
        				<button type="button" class="btn btn-primary"  id="subtn">提交</button>
        			</td>
        		</tr>
        	</table>
        </form>
    </div>
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<!-- datetimepicker -->
<!-- <script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap-datetimepicker.zh-CN.js"></script> -->
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">
	function checkPrice(price){
   		var reg = /^[0-9]+.?[0-9]*$/;
   		if(reg.test($(price).val())){
   			if(parseFloat($(price).val()) >= 0){
   				$(price).val(parseFloat($(price).val()).toFixed(2));
   			}
   		}else{
   			alert("请输入正确的价格");
   			return;
   		}
   	}
   	
   	function checkType(){
   		type = $("#type option:selected").val();
   	    if(type == '1'){
   			$("#filmId").prop("disabled",false);
   		}else if(type == '0'){
   			$("#filmId").find("option[value='0']").prop("selected",true);
   			$("#filmId").prop("disabled",true);
   		}
   	}
	
	$("#subtn").click(function(){
		var couponName = $("input[name='couponName']").val();
		var type = $("#type option:selected").val();
		var filmId = $("#filmId option:selected").val();
		var price = $("input[name='couponPrice']").val();
		if(couponName.length == 0){
			alert("请填写优惠名称");
			return;
		}else if(price.length == 0){
			alert("请填写价格！");
			return;
		}else if(type.length == 0){
			alert("请选择类型！");
			return;
		}else if(type == '1' && filmId == 0){
			alert("请选择影片名！");
			return;
		}
		
		$.ajax({
			url:"coupon/addCoupon",
			dataType:"json",
			data:$("#frm1").serialize(),
			type:"post",
			success:function(data){
				/* if(data == "1"){
					alert("已有优惠，已覆盖");
				}else if(data == "2"){
					alert("新优惠信息");
				} */
				location.href="coupon/showAllCoupon?pageNo=1";
			}
		});
	});
</script>
</html>