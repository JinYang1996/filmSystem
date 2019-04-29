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
    #seat{
    	width:500px;
    	height:500px;
    }
    .seatBorder{
    	display:block;
    	width:28px;
    	height:28px;
    	line-height:28px;
    	text-indent:5px;
    	background-color:#90EE90;
    	border-radius:5px;
    	margin-left:10px;
    	margin-top:10px;
    	float:left;
    }
    .seatRow{
    	display:block;
    	width:28px;
    	height:28px;
    	line-height:28px;
    	text-indent:7.5px;
    	border:1px solid blue;
    	margin-left:10px;
    	margin-top:10px;
    	border-radius:20px;
    	float:left;
    }
    .seatNull{
    	display:block;
    	width:28px;
    	height:28px;
    	line-height:28px;
    	text-indent:7.5px;
    	margin-left:10px;
    	margin-top:10px;
    	float:left;
    }
    a:hover{
    	cursor:pointer;
    }
    .seatBorder a{
    	opacity:0;
    }
</style>
<body>
<div class="panel admin-panel" style="width:800px;margin:20px auto">
    <div class="panel-head"><strong><span class="icon-key"></span>座位表</strong></div>
    <div class="body-content">
       <%--  <div class="form-group">
            <div class="label">
                <label>影院名：</label>
            </div>
            <c:forEach items="${hallList }" var="hall">
            <div class="field">
                <label style="line-height:33px;">
                	${hall.hallName }
                </label>
                <span class="right"><a href="">添加座位</a></span>
            </div>
            </c:forEach>
        </div> --%>
        <form id="frm1" style="float:left">
        	<table>
        		<tr>
        			<td>座位行数：</td>
        			<td>
        				<select class="input input-mid" name="hallRow" onchange="changeRow()" style="width:40px">
       						<option value="5">5</option>
       						<option value="6">6</option>
       						<option value="7">7</option>
        				</select>
        			</td>
        			<td>&nbsp;&nbsp;座位列数：</td>
        			<td>
        				<select class="input input-mid" name="hallCol" onchange="changeCol()" style="width:40px">
       						<option value="${hall.hallCol }">${hall.hallCol }</option>
       						<c:if test="${hall.hallCol ne 5 }"><option value="5">5</option></c:if>
       						<c:if test="${hall.hallCol ne 6 }"><option value="6">6</option></c:if>
       						<c:if test="${hall.hallCol ne 7 }"><option value="7">7</option></c:if>
       						<c:if test="${hall.hallCol ne 8 }"><option value="8">8</option></c:if>
        				</select></td>
        		</tr>
        	</table>
        </form>
        &nbsp; &nbsp; &nbsp;<button onclick="addSeat()" class="btn btn-primary" >添加选中座位</button>
        <div id="seat" style="clear:both">
        </div>
    </div>
    
</div>
</body>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		var row = '${hall.hallRow}';
		var col = '${hall.hallCol}';
		createSeat(row,col);
		console.log('${hallName}');
		$.get("seat/getSeatDetail?hallName="+'${hall.hallName}',function(data){
			$(data).each(function(index,item){
			console.log(item);
				$("#"+item.seatRow+item.seatNumber).css("background","rgb(233,150,122)");
				$("#"+item.seatRow+item.seatNumber).attr("data-choose","1");
			});
		});
		$("[name='hallRow'] option").each(function(){
			if($(this).val() == row){
				$(this).prop("selected",true);
			}
		});
	});
	function changColor(seat){
		var isColor = $(seat).parent().css("background-color");
		console.log(isColor);
		if(isColor == "rgb(233, 150, 122)"){
			$(seat).parent().css("background","rgb(144, 238, 144)");
			$(seat).parent().attr("data-choose","0");
		}else{
			$(seat).parent().css("background","rgb(233,150,122)");
			$(seat).parent().attr("data-choose","1");
		}
	}
	function addSeat(){
		var seatList = [];
		console.log($("#seat .seatBorder"));
		$("#seat .seatBorder").each(function(index,item){
			if($(item).attr("data-choose") == "1"){
				seatList.push($(item).attr("id"));
			}
		});
		if(seatList.length == 0){
			alert("请选择要添加的座位");
		}else{
			var row = $("[name='hallRow'] option:selected").val();
			var col = $("[name='hallCol'] option:selected").val();
			console.log(seatList.toString());
			$.ajax({
				url:"seat/addSeat1",
				data:{"seatList":seatList.toString(),"hallName":'${hall.hallName}',"hallRow":row,"hallCol":col},
				type:"post",
				dataType:"json",
				success:function(data){
					if(data == "1"){
						location.href="videoHall/selAllVideoHall";
					}else{
						location.href="videoHall/selAllVideoHall";
					}
				}
			});
		}
	}
	function createSeat(row,col){
		for(i=1 ; i<=row ; i++){
			$("#seat").append('<span class="seatRow">'+i.toString()+'</span>');
			for(j=1 ; j<=col ; j++){
				$("#seat").append('<span id="'+'row'+i.toString()+'col'+j.toString()+'" class="seatBorder">'+
				'<a onclick="changColor(this)">'+i.toString()+j.toString()+'</a></span>');
			}
			$("#seat").append('<br>');
			$("#seat").append('<br>');
			$("#seat").append('<br>');
		}
		$("#seat").append('<span class="seatNull"></span>');
		for(k=1 ; k<j ; k++){
			$("#seat").append('<span class="seatRow">'+k.toString()+'</span>');
		}
	}
	
	function changeRow(){
		$("#seat").children().remove();
		var row = $("[name='hallRow'] option:selected").val();
		var col = $("[name='hallCol'] option:selected").val();
		console.log(row + " " + col);
		createSeat(row,col);
	}
	
	function changeCol(){
		$("#seat").children().remove();
		var row = $("[name='hallRow'] option:selected").val();
		var col = $("[name='hallCol'] option:selected").val();
		console.log(row + " " + col);
		createSeat(row,col);
	}
</script>
</html>