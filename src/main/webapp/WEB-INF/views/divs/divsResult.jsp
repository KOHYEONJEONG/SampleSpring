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
	
	switch ("${res}") {
	case "success":
		
		if("${param.gbn}" == "u"){
			//수정하고 나면 상세보기로 가잖아? 아래 form에 code를 가지고 가야지 상세보기가 가능하지?
			$("#goForm").submit();
		}else{
			location.href="divsList";		
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
	default:
		break;
	}
});
</script>
</head>
<body>
	<form action="divsDetail" id="goForm" method="post">
		<input type="hidden" name="code" value="${param.code}"/>
	</form>
</body>
</html>