<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 추가</title>
<!-- Common CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<!-- Popup CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />
<style type="text/css">
.wrap {
   width : 400px;
   margin : 0 auto;
}
</style>
<script type="text/javascript"
      src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
      src="resources/script/common/popup.js"></script>   
         
<script type="text/javascript">
$(document).ready(function() {
	
	$("#listBtn").on("click", function() {
	      $("#backForm").submit();/*목록으로~ 이동!*/
	   });
	
	$("#insertBtn").on("click", function() {
		
		if($.trim($("#nm").val()) == ""){
			makeAlert("알림", "이름을 입력하세요.", function() {
				$("#nm").focus();
			});
		}else if($.trim($("#id").val()) == ""){
			makeAlert("알림", "아이디를 입력하세요.", function() {
				$("#id").focus();
			});
		}else if($.trim($("#pw").val()) == ""){
			makeAlert("알림", "비밀번호를 입력하세요.", function() {
				$("#pw").focus();
			});
		}else if($.trim($("#bd").val()) == ""){
			makeAlert("알림", "생일을 입력하세요.", function() {
				$("#bd").focus();
			});
		}else{
			var params = $("#actionForm").serialize();
			
			$.ajax({
				url : "AMAction/insert", 
				type : "POST",
				dataType : "json",
				data : params,
				success: function(res) {
					switch (res.msg) {
					case "success":
						location.href = "AMList";
						break;
					case "fail":
						makeAlert("알림", "등록에 실패하였습니다.");
						break;
					case "error":
						makeAlert("알림", "등록 중 문제가 발생하였습니다.");
						break;
					}
				},
				error : function(request, status, error) {
					console.log(request, responseText);
				}
				
			});
		}
		
	});
});
</script>
</head>
<body>

	<c:import url="/testAHeader"/>
	
	<form action="AMList" id="backForm" method="post">
	
		<!-- 전화면에서 넘어온 페이지 정보 -->
		<input type="hidden" id="page" name="page" value="${page}"/>
		
	</form>
	
	<div class="wrap">
		<form action = "#" id="actionForm" method="post">
		<!-- 아이디, 비빌번호, 이름 -->
			<input type="hidden" name="gbn" value="i"/>
			
			<table class="board_detail_table">
				<tr>
					<th colspan="2">회원가입</th>
				<tr>
					<th>이름</th>
					<td><input type="text" id="nm" name="nm"/></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input type="text" id="id" name="id"/></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="text" id="pw" name="pw"/></td>
				</tr>
				<tr>
					<th>생일</th>
					<td><input type="date" id="bd" name="bd"/></td>
				</tr>
			</table>
			
			<div class="cmn_btn_ml float_right_btn" id="listBtn">목록</div>
			<div class="cmn_btn_ml float_right_btn" id="insertBtn">등록</div>
		</form>
	</div>
</body>
</html>