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
		history.back(); /*처음화면으로 돌아가기*/
	});
	
	$("#updateBtn").on("click", function() {  
		$("#actionForm").submit(); 
	});
	
});
</script>

</head>
<body>
<form action="divsResult" method="post" id="actionForm">
	<input type="hidden" name="gbn" value="u"/>
	
	코드 : 
	<input type="text" name="code" id="code" value="${data.DIV_CODE}" readonly="readonly"/>
	
	코드명 :
	<input type="text" name="codeName" id="codeName" value="${data.DIV_NAME}"/>
</form>

	
	<br/>
	<button type="button" id="updateBtn">수정</button>
	<button type="button" id="listBtn">목록</button>
</body>
</html>