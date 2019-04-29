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
    
    <title>添加电影页</title>
    
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
	</style>
  <body>
    <div class="panel admin-panel" style="width:1000px;margin:20px auto">
    <div class="panel-head"><strong><span class="icon-key"></span>影片添加</strong></div>
    <div class="body-content">
        <div class="form-group">
            
            <form id="frm1" action="filmDetail/addNewFilm" method="post" enctype="multipart/form-data">
	            <div class="field">
	            	<table class="table table-hover">
	            		<tr>
	            			<td style="color:red">*影片：</td>
	            			<td><input type="file" name="filmPicture" class="input input-big" ></td>
	            		</tr>
	            		<tr>
	            			<td style="color:red">*电影名：</td>
	            			<td>
	            				<input type="text" name="title" onblur="checkFilm()" class="input input-big" >
	            			</td>
	            			<td><p id="msg"></p></td>
	            		</tr>
	            		<tr>
	            			<td>导演：</td>
	            			<td>
	            				<input type="text" name="direct" class="input input-big" >
	            			</td>
	            		</tr>
	            		<tr>
	            			<td>编剧：</td>
	            			<td>
	            				<input type="text" name="screenWriter" class="input input-big" >
	            			</td>
	            		</tr>
	            		<tr>
	            			<td>主演：</td>
	            			<td>
	            				<input type="text" name="leadingRole" class="input input-big" >
	            			</td>
	            		</tr>
	            		<tr>
	            			<td>类型：</td>
	            			<td>
	            				<input type="text" name="type" class="input input-big" >
	            			</td>
	            		</tr>
	            		<tr>
	            			<td>制片国家/地区：</td>
	            			<td>
	            				<input type="text" name="state" class="input input-big" >
	            			</td>
	            		</tr>
	            		<tr>
	            			<td>语言：</td>
	            			<td>
	            				<input type="text" name="language" class="input input-big" >
	            			</td>
	            		</tr>
	            		<tr>
	            			<td style="color:red">*上映日期：</td>
	            			<td>
	            				<input type="date" name="releaseDate" class="input input-big" >
	            			</td>
	            		</tr>
	            		<tr>
	            			<td>片长：</td>
	            			<td>
	            				<input type="number" name="filmLength" class="input input-big" >
	            			</td>
	            		</tr>
	            		<tr>
	            			<td>又名：</td>
	            			<td>
	            				<input type="text" name="alternateName" class="input input-big" >
	            			</td>
	            		</tr>
	            		<tr>
	            			<td>简介：</td>
	            			<td>
	            				<textarea rows="5" cols="80" name="brief"></textarea>
	            			</td>
	            		</tr>
	            		<tr>
	            			<td>豆瓣评分：</td>
	            			<td>
	            				<input type="number" name="score" class="input input-big" value="0" style="width:120px;margin:0 auto">
	            			</td>
	            		</tr>
	            		<tr>
	            			<td>价格：</td>
	            			<td><input type="number" class="input input-big"  name="price" onblur="checkPrice(this)" style="width:120px;margin:0 auto" value="99"></td>
	            		</tr>
	            	</table>
	            	
	            </div>
	        </form>
        </div>
        <button onclick="saveFilm()" class="btn btn-success" style="margin-left:500px;">保存</button>
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
    	function saveFilm(){
    		var msg = $("#msg").val();
    		var filmPicture = $("input[name='filmPicture']").val();
    		var releaseDate = $("input[name='releaseDate']").val();
    		console.log(filmPicture+"  "+releaseDate);
    		if(msg != "影片已存在" && filmPicture != '' && releaseDate != ''){
    			$("#frm1").submit();
    		}else{
    			alert("信息请填写完整");
    		}
    	}
    	
    	function checkFilm(){
    		var title = $("input[name='title']").val();
    		$.ajax({
    			url:"filmDetail/selFilmExist",
    			data:{title:title},
    			dataType:"json",
    			type:"post",
    			success:function(data){
    				if(data == '2'){
    					$("#msg").text("影片已存在");
    					$("#msg").css("color","red");
    				}else if(data == '1'){
    					$("#msg").text("");
    				}
    			}
    		});
    	}
    </script>
</html>
