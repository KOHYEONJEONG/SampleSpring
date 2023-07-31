<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OB</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	if("${res}" == "success") {
		switch("${param.gbn}") {
		case "u":
			if("${state}" == "1") {
				$("#actionForm").submit();
			} else {
				alert("비밀번호가 틀립니다.");
				history.back();
			}
			break;
		case "i":
			location.href = "syncList";
			break;
		case "d":
			if("${state}" == "1") {
				location.href = "syncList";
			} else {
				alert("비밀번호가 틀립니다.");
				history.back();
			}
			break;
		}
	} else { // 예외 발생 시
		alert("작업 중 문제가 발생하였습니다.");
		history.back();
	}
});
</script>
</head>
<body>
<!-- 수정 성공 시 사용 -->
<form action="syncDetail" id="actionForm" method="post">
	<input type="hidden" name="boardNo" value="${param.boardNo}" />
	<input type="hidden" name="page" value="${param.page}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchText" value="${param.searchText}" />
</form>
</body>
</html>