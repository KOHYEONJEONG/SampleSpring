<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>book 등록페이지</title>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>

<script type="text/javascript">
$(document).ready(function() {
	
	$("#listBtn").on("click", function() { 
		history.back();//처음화면으로 컴백~~~
	});
	
	$("#updateBtn").on("click" , function() {
		if(confirm("수정하시겠습니까??")){
			$("#actionForm").submit();
		}
	})
	
	
	
});
</script>	
	
</head>
<body>

	<h3>BOOK 수정페이지</h3>
	<form action="bookRes" id="actionForm" method="post">
	
		<input type="hidden" name="no" value="${data.BOOK_NO}"/>
		<input type="hidden" name="gbn" value="u"/>
	
		책제목 <input type="text" id="title" name="title" value="${data.BOOK_TITLE}"/>
		저자 <input type="text" id="author" name="author" value="${data.BOOK_AUTHOR}"/>
		출판사 <input type="text" id="co" name="co" value="${data.BOOK_CO}"/>
		출판일<input type="date" id="bookDt" name="bookDt" value="${data.BOOK_DT}"/>
		등록일<input type="date" id="regDt" name="regDt" value="${data.REG_DT}"/>
	</form>
	
	<input type="button" value="수정" id="updateBtn"/>
	<input type="button" value="목록" id="listBtn"/>
</body>
</html>