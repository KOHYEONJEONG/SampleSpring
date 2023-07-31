<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 메인화면</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js">
</script>

<script type="text/javascript">
$(document).ready(function() {
	
});
</script>
</head>
<body>
<h3>로그인 메인 화면(결과)</h3>
<c:import url="/testHeader"></c:import>
<!-- /가 붙어야지 컨트롤러에서 찾는다는 뜻임! -->
<br/> 
<a href="tBoardList">TBoard List</a>
</body>
</html>