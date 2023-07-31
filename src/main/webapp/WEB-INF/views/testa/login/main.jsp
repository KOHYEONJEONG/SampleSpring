<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 main화면</title>

<style type="text/css">
.wrap {
	padding:20px;
    width : 400px;
    margin : 0 auto;
    text-align: center;
}

a{
	text-decoration: none;
	
	cursor: pointer;
}

li{
	margin-bottom: 10px;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js">
</script>

<script type="text/javascript">
$(document).ready(function() {
	
});
</script>
</head>
<body>
	<div class="wrap">
		<h3>로그인 성공!!</h3>
		<!-- /가 붙어야지 컨트롤러에서 찾는다는 뜻임! -->
		<br/>
		
		<ul>
			<li><a href="ATList">TBoard 게시판</a></li>
			<li><a href="AOB">한줄게시판(댓글)</a></li>
			<li><a href="AMList">회원목록</a></li>
			<li><a href="AGALLERY">사진 갤러리(현정)</a></li>
			<li><a href="AGList">사진 갤러리(세희님)</a></li>
		</ul>
		
	</div>	
</body>
</html>