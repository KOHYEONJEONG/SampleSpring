<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	border-collapse: collapse;
	display: inline-block;
	text-align: center;
}

th, td {
	border: 1px solid #000;
	padding: 5px;
}

#pagingWrap span {
	cursor: pointer;
}

.table_box{
	text-align: center;
}

input[type="button"] {
	cursor: pointer;
}

h3 {
	background-color: silver;
	display: inline-block;
}
</style>

<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>

<script type="text/javascript">
$(document).ready(function(){
	$("#listBtn").on("click", function() {
		location.href="memberList";
	});
	
	$("#updateBtn").on("click", function() {
		$("#actionForm").attr("action", "updateMemberPage");
		$("#actionForm").submit();
	});
	 
	$("#deleteBtn").on("click", function() {
		$("#actionForm").attr("action", "memberRes/delete");
		$("#actionForm").submit();
	});
});
</script>
</head>
<body>
	<form action="#" id="actionForm" method="post">
		<input type="hidden" name="no" value="${data.MEM_NO}"/>
	</form>
	
	<div class="table_box">
		<table>
			<caption>회원 상세보기</caption>
			
			<colgroup>
				<col width="150">
				<col width="200">
			</colgroup>
			<tr>
				<th>NO</th>
				<td>${data.MEM_NO}</td>
			</tr>
			<tr>
				<th>ID</th>
				<td>${data.MEM_ID}</td>
			</tr>
			<tr>
				<th>NAME</th>
				<td>${data.MEM_NM}</td>
			</tr>
			<tr>
				<th>BirthDay</th>
				<td>${data.MEM_BIRTH}</td>
			</tr>
			<tr>
				<th>등록일</th>
				<td>${data.REG_DT}</td>
			</tr>
		</table>
		
		<br/>
		
		<input type="button" value="수정" id="updateBtn">
		<input type="button" value="삭제" id="deleteBtn">
		<input type="button" value="목록" id="listBtn">
	</div>
</body>
</html>