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
		if($("#codeName").val() == null || $("#codeName").val() == ""){
			alert("코드명을 적어주세요.");
			$("#codeName").focus();
		}else{
			$("#actionForm").submit();
		}
		
	});

});
</script>
</head>
<body>

<form action="divsResult" method="post" id="actionForm">
	<input type="hidden" name="gbn" value="i"/>
	
	코드 : 
	<input type="text" name="code" id="code"/>
	
	코드명 :
	<input type="text" name="codeName" id="codeName"/>
</form>

	
	<br/>
	<button type="button" id="insertBtn">추가</button>
	<button type="button" id="listBtn">목록</button>
	


</body>
</html>