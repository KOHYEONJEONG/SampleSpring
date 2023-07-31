<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결과 값 받는 페이지</title>

<script type="text/javascript"
	src="../resources/script/jquery/jquery-1.12.4.min.js">
</script>

<script type="text/javascript">
$(document).ready(function() {
		
	switch ("${res}") {
	case "success":
		  if("${flag}" == "u"){
			  $("#goForm").submit();
		  }else{
			  location.href="../memberList";
		  }
		break;
	case "failed" :
		   alert("작업에 실패하였습니다.");
		   history.back();
	   break;
	case "error" :
		   alert("작업중 문제가 발생 하였습니다.");
		   history.back();
	   break; 
	}

});
	
</script>
</head>
<body>
<form action="memberDetail" id="goForm" method="post">
	<!-- 전 화면에서 넘어오기 때문에 param붙여줌., 상세보기는 no가 있어야 조회가능함. -->
	<input type="hidden" name="no" value="${param.no}">
</form>
</body>
</html>