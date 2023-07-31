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

img {
	width: 30px;
	height: 30px;
}

#insertBtn{
	margin-top: 10px;
}
h3 {
	display: inline-block;
	background-color: pink;
}
</style>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
	$(document).ready(function() {
		
		//상세보기
		$("tbody").on("click","tr",function(){
			
			console.log($(this).attr("no"));
			$("#code").val($(this).attr("no"));
			
			$("#actionForm").submit();
		});
		
		//추가하기
		$("#insertBtn").on("click", function() {
			location.href="divsInsertPage"; /*페이지 이동은 컨트롤러에 작성하기*/
		});
		
	});
</script>
</head>
<body>
	<form action="divsDetail" id="actionForm" method="post">
		<input type="hidden" id="code" name="code" />
	</form>

	<h3>DIVS 테이블</h3>
	<table>
		<thead>
			<tr>
				<th>코드</th>
				<th>코드명</th>
			</tr>
		</thead>

		<tbody>

			<!-- java.lang.NumberFormatException: For input string: "DIV_CODE"  -->
			<c:forEach var="data" items="${list}">
				<tr no="${data.DIV_CODE}">
					<td>${data.DIV_CODE}</td>
					<td>${data.DIV_NAME}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<button type="button" id="insertBtn">
		<img alt="추가버튼" src="./resources/images/addBtn.png">
	</button>

</body>
</html>