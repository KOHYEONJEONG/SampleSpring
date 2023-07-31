<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>book 결과 페이지</title>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function() {
	switch ("${res}") {
	case "success" :
		if("${param.gbn}" == "u"){
			$("#goForm").submit();
		}else{
			location.href="bookList";
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
	<form action="bookDetail" id="goForm" method="post">
		<input type="hidden" name="no" value="${param.no}"/>
	</form>
</body>
</html>