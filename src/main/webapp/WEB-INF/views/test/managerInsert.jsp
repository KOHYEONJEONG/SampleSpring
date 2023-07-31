<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function() {
	$("#listBtn").on("click", function() {
		history.back();
	});
	
	$("#insertBtn").on("click", function() {
		//등록
		if($("#name").val() == null || $("#name").val() == ""){
			alert("성함을 적어주세요.");
			$("#name").focus();
		}else{
			$("#actionForm").submit();
		}
		
	});
});
</script>
</head>
<body>
	<form action="managerResult" id="actionForm" method="post">
		<!-- 구분에 따라 행위가 달라진다(insert창이니까 i를 보냄) -->
		<input type="hidden" name="gbn" value="i"/>
		
		성함:
		<input type="text" name="name" id="name"/>
		부서:
		  <select name="dept">
		  	<option value="영업1팀">영업1팀</option>
		  	<option value="영업2팀">영업2팀</option>
		  	<option value="영업3팀">영업3팀</option>
		  </select>
	</form>
	
	<input type="button" value="등록" id="insertBtn"/>
	<input type="button" value="목록" id="listBtn"/>
	
</body>
</html>