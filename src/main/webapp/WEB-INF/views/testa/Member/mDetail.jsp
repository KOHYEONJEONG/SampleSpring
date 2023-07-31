<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세보기</title>
<!-- Common css -->
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />

<style type="text/css">
	.wrap{
	   width:800px;
	   margin: 0 auto;
	}
	
	.con{
		text-align: left;
		height: 400px;
	}
</style>

<script type="text/javascript"
      src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/common/popup.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	$("#listBtn").on("click", function() {
		$("#actionForm").attr("action","AMList");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function() {
		makePopup({
			title:"알림",
			contents:"삭제 하시겠습니까?",
			buttons : [{
					name : "삭제",
					func : function() {
						var params = $("#actionForm").serialize();
						$.ajax({
				            url : "ATAction/delete",
				            type : "POST",
				            dataType : "json", 
				            data : params, 
				            success : function(res) { 
				            switch(res.msg){
				            case "success":
				               location.href = "AMList";
				               break;
				            case "fail":
				                makeAlert("알림", "삭제에 실패하였습니다.");
				               break;
				            case "error":
				                makeAlert("알림", "삭제 중 문제가 발생하였습니다.");
				               break;
				            }
				            },
				            error : function(request, status, error) {
				               console.log(request, responseText); 
				            }
				         });
					}
				},{
					name : "취소"
				}]

			});//makePopup
	});	
	
	$("#updateBtn").on("click", function() {
		$("#actionForm").attr("action","AMUpdate"); 
		$("#actionForm").submit();
	});
		
});
</script>      
</head>
<body>
	<c:import url="/testAHeader"/>
	
	<form action="#" id="actionForm" method="post">
		<input type="hidden" name="no" value="${data.MEM_NO}"/>
		
		<input type="hidden" name="page" value="${param.page}"/>
		
		<input type="hidden" id="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" id="searchTxt" value="${param.searchTxt}"/>
	</form>
	
	<div class="wrap">
		<table class="board_detail_table">
			<tr>
				<th>번호</th>
				<td>${data.MEM_NO}</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>${data.MEM_ID}</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${data.MEM_NM}</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td>${data.REG_DT}</td>
			</tr>
			
		</table>
		: <br/>
		: <br/>
		: <br/>
		: <br/>
		: <br/>
		-- --<br/>
		<br/>
		
		<div class="cmn_btn_ml float_right_btn" id="listBtn">목록</div>
		<div class="cmn_btn_ml float_right_btn" id="deleteBtn">삭제</div>
		<div class="cmn_btn_ml float_right_btn" id="updateBtn">수정</div>
		
		
	</div>
</body>
</html>