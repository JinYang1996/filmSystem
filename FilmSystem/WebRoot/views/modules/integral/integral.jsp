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
    <div class="panel-head"><strong><span class="icon-key"></span>影院规则</strong></div>
    <div class="body-content">
       	<div>
       		<p>1.100积分可抵扣1元钱</p>
       		<p>2.根据影院要求，拼单总人数达到60%以上则无法取消订单！</p>
       		<p>3.根据影院要求，本场次订票截止时间为电影开场前 30分钟 </p>
       		<p>4.每笔订单最多可选购5张电影票</p>
       		<p>5.点击“完成选座”后，请在15分钟内完成支付，超时系统将释放你选定的座位</p>
       		<p>6.发起拼单后，影片放映前一小时管理员未审核，系统自动将该影片拼单及参与拼单的订单置为全部失效，并退还使用积分
       		(只有拼单总人数已经达到60%才会通过这一操作)</p>
       		<p>7.发起拼单后，影片放映前两小时还未达到指定人数比例，系统自动将该影片拼单及参与拼单的订单置为全部失效，并退还使用积分，
       		并将该时间段取消，防止用户再次发起拼单(人数未达到60%，不执行第6步)</p>
       		<p>8.系统自动将已支付，审核通过，到达指定拼单人数的订单观看状态置为已观看</p>
       		<p>9.系统自动将今天之前的放映安排清空。</p>
       		<p>10.管理员如审核拼单信息不通过，该影片的拼单及参与拼单的订单置为全部失效，并退还积分。</p>
       		<p>11.如果发起拼单的订单通过审核，参与拼单到达60%则自动视为拼单成功，发放观影码。</p>
       		<p>12.管理员应对申请的放映安排尽快审核，否则逾期自动清除</p>
       		<p>13.放映安排在当前时间前两小时del_flag置为'2',已经过期，无法发起拼单。</p>
       		<p>14.当用户发起拼单时，在指定时间内未支付，但是其他用户参与了拼单，则将此发起拼单置为失效状态，并退还参与者使用的积分。</p>
       	</div>
    </div>
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<!-- datetimepicker -->
<!-- <script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap-datetimepicker.zh-CN.js"></script> -->
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">
	
</script>
</html>