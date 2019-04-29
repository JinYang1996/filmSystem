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
    <div class="panel-head"><strong><span class="icon-key"></span>我的订单</strong></div>
    <div class="container-fluid">
        	<form action="fightTicket/toPersonOrder" method="post" id="frm">
        		<div class="form-group" style="margin-top:5px;">
        			<input type="hidden" name="pageNo" value="0">
        			<label>电影名称：</label>
        			<input type="text" class="form-control" name="filmDetail.title" value="${fight.filmDetail.title }" style="width:150px;display:inline-block">
        			
        			<label>支付状态：</label>
        			<select name="payStatus" class="form-control" style="width:150px;display:inline-block">
        				<option value="">--请选择--</option>
   						<option value="1">未支付</option>
   						<option value="0">已支付</option>
   						<option value="2">已退还</option>
        			</select>
        			
        			<label>类型：</label>
        			<select name="type" class="form-control" style="width:150px;display:inline-block">
        				<option value="">--请选择--</option>
  						<option value="1">申请拼单</option>
  						<option value="2">参加拼单</option>
  						<option value="3">申请取消拼单</option>
  						<option value="4">申请取消参加拼单</option>
        			</select>
        		</div>
        		
        		<div class="form-group">
        			<label>审核状态：</label>
        			<select name="reviewStatus" id="reviewStatus" class="form-control" style="width:150px;display:inline-block">
        				<option value="">--请选择--</option>
  						<option value="1">审核中</option>
  						<option value="0">已通过</option>
  						<option value="3">未通过</option>
        			</select>
        			
        			<label>放映日期：</label>
        			<input type="date" class="form-control" id="releaseTime" name="theaterArrange.releaseTime" style="width:160px;display:inline-block">
        			<p style="display:none" id="release"><fmt:formatDate value="${fight.theaterArrange.releaseTime }" pattern="yyyy-MM-dd"/></p>
        		
        			<button onclick="sub()" class="btn btn-success" style="margin:-5px 0 0 130px">查询</button>
        		</div>
        	</form>
        </div>
    <table class="table table-hover text-center">
        <tr>
        	<th width="7%">序号</th>
            <th width="12%">影片</th>
            <th width="15%">影片名</th>
            <th width="13%">观影时间</th>
            <th width="10%">类型</th>
            <th width="10%">支付状态</th>
            <th width="10%">审核状态</th>
            <th width="30%">订单操作</th>
        </tr>
 		<c:forEach items="${fightList }" var="fight" varStatus="s">
         <tr onclick="orderDetail('${fight.id}',event)">
         	 <td style="vertical-align:middle;">${s.count }</td>
             <td style="vertical-align:middle;"><img src="${fight.filmDetail.picture}" height="60px"></td>
			 <td style="vertical-align:middle;">${fight.filmDetail.title}</td>
			 <td style="vertical-align:middle;"><fmt:formatDate value="${fight.theaterArrange.releaseTime}" pattern="yyyy-MM-dd"/> <fmt:formatDate value="${fight.theaterArrange.startTime}" pattern="HH:mm:ss"/></td>
			 <td style="vertical-align:middle;">
			 	<c:if test="${fight.type == '1'}">申请拼单</c:if>
			 	<c:if test="${fight.type == '2'}">参加拼单</c:if>
			 	<c:if test="${fight.type == '3' or fight.type == '4'}">申请取消</c:if>
			 </td>
			 <td style="vertical-align:middle;">
			 	<c:if test="${fight.payStatus == '1'}">未支付</c:if>
			 	<c:if test="${fight.payStatus == '0'}">已支付</c:if>
			 	<c:if test="${fight.payStatus == '2'}">已退还</c:if>
			 </td>
			 <td style="vertical-align:middle;">
			 	<c:if test="${fight.reviewStatus == '1'}">审核中</c:if>
			 	<c:if test="${fight.reviewStatus == '0'}">已通过</c:if>
			 	<c:if test="${fight.reviewStatus == '3'}">未通过</c:if>
             <td style="vertical-align:middle;">
                 <div class="button-group">
                 	<c:choose>
                 		<c:when test="${fight.payStatus == '1' and fight.delFlag != '1'}">
	                 		<a class="button border-blue" style="width:100px;" href="javascript:void(0)" onclick="pay('${fight.id}')">
	                         <span class="icon-delicious"></span> 支付
	                     	</a>
                 		</c:when>
                 		<c:when test="${fight.type == '3' or fight.type == '4'}">
                 			<c:if test="${fight.reviewStatus == '1' and fight.delFlag != '1'}">
								<a class="button border-yellow" style="width:100px;">
		                         	<span class="icon-delicious"></span> 审核中
		                     	</a>
							</c:if>
	                 		<c:if test="${fight.reviewStatus == '0'}">
								<a class="button border-yellow" style="width:100px;">
		                         	<span class="icon-delicious"></span> 已完成
		                     	</a>
							</c:if>
							<c:if test="${fight.reviewStatus == '3' and fight.fightStatus == '2'}">
								<a class="button border-yellow" style="width:100px;">
		                         	<span class="icon-delicious"></span> 待观看
		                     	</a>
							</c:if>
                 		</c:when>
                 		<c:when test="${fight.type == '1' and fight.reviewStatus == '3'}">
                 			<a class="button border-yellow" style="width:100px;">
	                         	<span class="icon-delicious"></span> 已完成
	                     	</a>
                 		</c:when>
                 		<c:when test="${fight.type == '2' and fight.reviewStatus == '3'}">
                 			<a class="button border-yellow" style="width:100px;">
	                         	<span class="icon-delicious"></span> 已完成
	                     	</a>
                 		</c:when>
                 		<c:when test="${fight.fightStatus == '2' and fight.reviewStatus == '1'}">
                 			<a class="button border-yellow" style="width:120px;">
		                         <span class="icon-delicious"></span> 人数达标
		                     </a>
                 		</c:when>
                 		<c:when test="${fight.reviewStatus == '0' and fight.watchStatus == '1'}">
                 			<a class="button border-yellow" style="width:100px;">
		                         <span class="icon-delicious"></span> 待观看
		                    </a>
                 		</c:when>
                 		<c:when test="${fight.watchStatus == '2'}">
                 			<a class="button border-yellow" style="width:100px;">
		                         <span class="icon-delicious"></span> 已观看
		                    </a>
                 		</c:when>
                 		<c:when test="${fight.delFlag == '3'}">
                 			<a class="button border-yellow" style="width:100px;">
		                         <span class="icon-delicious"></span> 已超时
		                    </a>
                 		</c:when>
                 		<c:otherwise>
                 			 <a class="button border-red left" style="width:100px;" href="javascript:void(0)" onclick="del('${fight.id}')">
		                         <span class="icon-trash-o"></span> 取消
		                     </a>
                 		</c:otherwise>
                 	</c:choose>
                 </div>
             </td>
         </tr>
        </c:forEach>
    </table>
</div>
</body>
  <script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
  <script type="text/javascript">
  		function del(id){
  			if(confirm("确定要取消拼单吗？")){
  				location.href="fightTicket/cancelOrder?fightId="+id;
  			}
  		}
  		
  		function pay(id){
  			window.parent.location="fightTicket/toSubmitOrder?fightId="+id;
  		}
  		
  		function orderDetail(id,e){
  			if(e.target.cellIndex <= 6){
  				location.href="fightTicket/orderDetail?fightId="+id;
  			}
  		}
  		
  		function sub(){
			$("#frm").submit();
		}
		
		$(function(){
			var reviewStatus = '${fight.reviewStatus}';
			console.log(reviewStatus);
			$("#reviewStatus option").each(function(index,item){	
				console.log($(item).val());
				if($(item).val() == reviewStatus){
					$(item).prop("selected","selected");
				}
			});
			var payStatus = '${fight.payStatus}';
			console.log(payStatus);
			$("select[name='payStatus'] option").each(function(index,item){	
				console.log($(item).val());
				if($(item).val() == payStatus){
					$(item).prop("selected","selected");
				}
			});
			var type = '${fight.type}';
			console.log(type);
			$("select[name='type'] option").each(function(index,item){	
				console.log($(item).val());
				if($(item).val() == type){
					$(item).prop("selected","selected");
				}
			});
			
			var date = $("#release").text();
			console.log(date);
			$("#releaseTime").val(date);
		});
  </script>
</html>