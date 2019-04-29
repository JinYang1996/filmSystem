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
    <div class="panel-head"><strong><span class="icon-key"></span>影院安排</strong></div>
    <div class="body-content">
        <form id="frm1" action="theaterArrange/addArrange" method="post" style="float:left">
        	<table>
        		<tr style="margin-top:10px;">
        			<td>放映时间：</td>
        			<td>
        				<input class="input input-mid datetimepicker" id="datetimepicker" type="text" name="filmTime" onblur="checkTime(this)">
        			</td>
        		</tr>
        		<tr style="margin-top:10px;">
        			<td>影厅：</td>
        			<td>
        				<select class="input input-mid" id="hallId" name="videoHall.id">
        					<option value="0">请选择</option>
        					<c:forEach items="${hallList }" var="hall">
        						<option value="${hall.id }">${hall.hallName }</option>
        					</c:forEach>
        				</select>
        			</td>
        		</tr>
        		<tr>
        			<td>影片：</td>
        			<td>
        				<select class="input input-mid" id="filmId" name="filmDetail.id" onchange="changeFilm()">
        					<option value="0">请选择</option>
        					<c:forEach items="${filmList }" var="film">
        						<option value="${film.id }">${film.title }</option>
        					</c:forEach>
        				</select>
        			</td>
        		</tr>
        		<tr>
        			<td>优惠：</td>
        			<td>
        				<select class="input input-mid" name="coupon.id" onchange="changeCoupon()">
        					<option value="0">请选择</option>
        					<c:forEach items="${couponList }" var="coupon">
        						<c:if test="${coupon.type == '0' }">
        							<option value="${coupon.id }">----通用优惠券----</option>
        						</c:if>
        						<c:if test="${coupon.type == '1' }">
        							<option value="${coupon.id }">${coupon.couponName }  --${coupon.filmDetail.title }</option>
        						</c:if>
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
	$(function(){
		$("#datetimepicker").datetimepicker({
			dayOfWeekStart : 1,
			lang:'en',
			minDate:'${today}'
		});
		$('#datetimepicker').datetimepicker({step:10});
		
		if('${title}' != ""){
			$("#filmId option").each(function(index,item){
				if($(item).text() == '${title}'){
					$(item).prop("selected",true);
				}
			});
			changeFilm();
		}
	});
	
	function checkTime(time){
		var date = new Date();
		var str = date.getFullYear()+"/";
		if((date.getMonth()+1)<10){
			str += "0"+(date.getMonth()+1)+"/";
		}else{
			str += (date.getMonth()+1)+"/";
		}
		if(date.getDate()<10){
			str += "0"+date.getDate();
		}else{
			str += date.getDate();
		}
		var today = $(time).val().substr(0,10);
		if(str == today){
			alert("选择日期不能为当日");
			$(time).val("");
		}
		console.log(today);
		console.log(str);
	}
	
	$("#subtn").click(function(){
		var hallId = $("#hallId option:selected").val();
		var filmId = $("#filmId option:selected").val();
		var title = $("#filmId option:selected").text();
		var coupon = $("select[name='coupon.id'] option:selected").val();
		var text = $("select[name='coupon.id'] option:selected").text();
		console.log(coupon);
		/* if(coupon == 0){
			alert("")
		} */
		var checkTime = $("#datetimepicker").val();
		console.log(hallId);
		console.log(filmId);
		console.log(checkTime);
		if(checkTime.length == 0){
			alert("放映时间不能为空！");
			return;
		}else if(hallId == '0'){
			alert("请选择影厅！");
			return;
		}else if(filmId == '0'){
			alert("请选择影片！");
			return;
		}else if(coupon == '0'){
			alert("请选择优惠！");
			return;
		}
		if(text != '----通用优惠券----' && text.indexOf(title) < 0){
			alert("请选择正确的优惠券");
		}
		$.ajax({
			url:"theaterArrange/checkTime",
			dataType:"json",
			data:{"hallId":hallId,"filmId":filmId,"checkTime":checkTime},
			type:"post",
			success:function(data){
				if(data == "1"){
					alert("所选被占用，请重新选择！");
				}else{
					$("#frm1").submit();
				}
			}
		});
	});
	
	function changeFilm(){
		var filmId = $("#filmId option:selected").val();
		var title = $("#filmId option:selected").text();
		console.log(title);
		var commonCoupon;
		$("select[name='coupon.id'] option").each(function(index,item){
			var text = $(item).text();
			if(text == '----通用优惠券----'){
				commonCoupon = $(item).val();
			}
		});
		$("select[name='coupon.id']").find("option[value='"+commonCoupon+"']").prop("selected",true);
		$("select[name='coupon.id'] option").each(function(index,item){
			var text = $(item).text();
			console.log(text.indexOf(title));
			if(text.indexOf(title) >= 0){
				$(item).prop("selected",true);
			}
		});
		
	}
	
	function changeCoupon(){
		var couponId = $("select[name='coupon.id'] option:selected").val();
		console.log(couponId);
		$.ajax({
			url:"coupon/getCoupon",
			data:{id:couponId},
			dataType:"json",
			type:"post",
			success:function(data){
				console.log(data.filmDetail.id);
				console.log(data.filmDetail.title);
				$("#filmId").find("option[value='"+data.filmDetail.id+"']").prop("selected",true);
			}
		});
	}
</script>
</html>