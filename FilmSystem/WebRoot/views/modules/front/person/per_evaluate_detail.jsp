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
    <div class="panel-head"><strong><span class="icon-key"></span> 评论详情</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="">
            <div class="form-group">
                <div class="label">
                    <label>影片：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       <img src="${evaluate.filmDetail.picture }" height="60px">
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>影片名：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       ${evaluate.filmDetail.title }
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>评论内容：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       ${evaluate.content}
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>审核状态：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       	<c:if test="${evaluate.reviewStatus == '1'}">未审核</c:if>
					 	<c:if test="${evaluate.reviewStatus == '0'}">已通过</c:if>
					 	<c:if test="${evaluate.reviewStatus == '2'}">未通过</c:if>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>点赞数：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       ${evaluate.likes}
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>评论时间：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                       <fmt:formatDate value="${evaluate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>备注：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                    	<textarea rows="20" cols="72" name="remarks" style="height:220px"></textarea>
                    </label>
                </div>
            </div>
            
        </form>
    </div>
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("textarea[name='remarks']").val('${evaluate.remarks}');
		$("textarea[name='remarks']").attr("readonly",true);
	});
</script>
	
</html>