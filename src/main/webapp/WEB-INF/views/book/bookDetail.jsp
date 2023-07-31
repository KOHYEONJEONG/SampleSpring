<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOOK 상세보기</title>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#listBtn").on("click", function() {
		$("#actionForm").attr("action", "bookList");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function() {
		if(confirm("삭제할꺼임???")){
			$("#actionForm").attr("action","bookRes");
			$("#actionForm").submit();//gbn이랑  no 보내짐.
		}
	});
	
	$("#updateBtn").on("click", function() {
		$("#actionForm").attr("action", "bookUpdate");//수정페이지로 이동
		$("#actionForm").submit();
	});
	
});
</script>
</head>
<body>
	<form action="#" id="actionForm" method="post">
		<input type="hidden" name="gbn" value="d"/>
		<input type="hidden" name="no" value="${data.BOOK_NO}"/> <!-- 수정도 no가 필요함. -->
	</form>
	
	<h3>BOOK 상세보기</h3>
	책번호 : ${data.BOOK_NO}<br/>
	책제목  : ${data.BOOK_TITLE}<br/>
	저자  : ${data.BOOK_AUTHOR}<br/>
	출판사 : ${data.BOOK_CO}<br/>
	출판일 : ${data.BOOK_DT}<br/>
	등록일 ${data.REG_DT}<br/>
	
	
	<input type="button" value="수정" id="updateBtn">
	<input type="button" value="삭제" id="deleteBtn">
	<input type="button" value="목록" id="listBtn">
</body>
</html>