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
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <style type="text/css">
        .form-x .form-group .label{
            width:100px;
        }
        .msg{
        	line-height:40px;
        }
        .newmsg{
        	line-height:40px;
        }
    </style>
</head>
<body>
<div class="panel admin-panel" style="width:800px;margin:20px auto">
    <div class="panel-head"><strong><span class="icon-key"></span> 订单详情</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="">
            <div class="form-group">
                <div class="label">
                    <label>影片：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       <img src="${fightTicket.filmDetail.picture }" height="60px">
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>影片名：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       ${fightTicket.filmDetail.title }
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>发起者：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       ${fightTicket.fightPeople}
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>影厅安排：</label>
                </div>
                <div class="field">
                    <p style="color:red">场次：<fmt:formatDate value="${fightTicket.theaterArrange.releaseTime }" pattern="yyyy-MM-dd E"/>
          			 <fmt:formatDate value="${fightTicket.theaterArrange.startTime }" pattern="HH:mm"/> ${fightTicket.theaterArrange.videoHall.hallName }</p>
          			<p style="font-size:14px;color:grey">预计<fmt:formatDate value="${fightTicket.theaterArrange.endTime }" pattern="HH:mm"/>散场</p>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>座位信息：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       ${rowCol }
                    </label>
                </div>
            </div>
            <c:if test="${fightTicket.watchCode != null }">
	            <div class="form-group">
	                <div class="label">
	                    <label>对应观影码：</label>
	                </div>
	                <div class="field">
	                    <label style="line-height:33px;">
	                        ${fightTicket.watchCode }
	                    </label>
	                </div>
	            </div>
            </c:if>
        
            <div class="form-group">
                <div class="label">
                    <label>订单类型：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                        <c:if test="${fightTicket.type == '1'}">申请拼单</c:if>
			 			<c:if test="${fightTicket.type == '2'}">参加拼单</c:if>
			 			<c:if test="${fightTicket.type == '3' or fightTicket.type == '4'}">申请取消</c:if>
                    </label>
                </div>
            </div>
             <div class="form-group">
                <div class="label">
                    <label>发起状态：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       	<c:if test="${fightTicket.fightStatus == '0'}">拼单取消</c:if>
			 			<c:if test="${fightTicket.fightStatus == '1'}">正在拼单</c:if>
			 			<c:if test="${fightTicket.fightStatus == '2'}">人数达标</c:if>
                    </label>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label">
                    <label>审核状态：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       	<c:if test="${fightTicket.reviewStatus == '1'}">未审核</c:if>
					 	<c:if test="${fightTicket.reviewStatus == '0'}">已通过</c:if>
					 	<c:if test="${fightTicket.reviewStatus == '3'}">未通过</c:if>
                    </label>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label">
                    <label>支付状态：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       	<c:if test="${fightTicket.payStatus == '1'}">未支付</c:if>
			 			<c:if test="${fightTicket.payStatus == '0'}">已支付</c:if>
			 			<c:if test="${fightTicket.payStatus == '2'}">已退还</c:if>
                    </label>
                </div>
            </div>
            
            <c:if test="${fightTicket.payStatus != '2'}">
            	<div class="form-group">
	                <div class="label">
	                    <label>观看状态：</label>
	                </div>
	                <div class="field">
	                    <label style="line-height:33px;">
	                       	<c:if test="${fightTicket.watchStatus == '1'}">待观看</c:if>
						 	<c:if test="${fightTicket.watchStatus == '2'}">已观看</c:if>
	                    </label>
	                </div>
	            </div>
            </c:if>
            
            <div class="form-group">
                <div class="label">
                    <label>备注：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       	${fightTicket.remarks }
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>下单时间：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       	<fmt:formatDate value="${fightTicket.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </label>
                </div>
            </div>
           <%--  <div class="form-group">
                <div class="label">
                    <label>订单状态：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                    	<c:if test="${fightTicket.delFlag == '0' }">进行中</c:if>
                       	<c:if test="${fightTicket.delFlag == '1' }">已失效</c:if>
                       	<c:if test="${fightTicket.delFlag == '2' }">占用中</c:if>
                    </label>
                </div>
            </div> --%>
        </form>
    </div>
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
</script>
	
</html>