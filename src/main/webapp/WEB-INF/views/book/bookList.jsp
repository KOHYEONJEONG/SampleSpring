<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	border-collapse: collapse;
	width: 300px;
	text-align: 0 auto;
}

tr {
	text-align: 0 auto;
}

th, td {
	border: 1px solid #000;
	padding: 5px;
}
</style>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>

<script type="text/javascript">
$(document).ready(function() {
	$("tbody").on("click","tr", function() {
		console.log($(this).attr("no"));
		
		$("#no").val($(this).attr("no"));
		
		$("#actionForm").submit();
	});
	
	$("#insertBtn").on("click", function() {
		location.href="bookInsert";
	});
	
});
</script>	
</head>
<body>
	<form action="bookDetail" id="actionForm" method="post">
		<input type="hidden" id="no" name="no" />
	</form>
	
	<h3>BOOK 테이블</h3>
	<input type="button" value="등록" id="insertBtn"/>
	<table>
	<thead>
		<tr>
			<th>책번호</th>
			<th>책제목</th>
			<th>저자</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="data" items="${list}">
			<tr no="${data.BOOK_NO}">
				<td>${data.BOOK_NO}</td>
				<td>${data.BOOK_TITLE}</td>
				<td>${data.BOOK_AUTHOR}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>