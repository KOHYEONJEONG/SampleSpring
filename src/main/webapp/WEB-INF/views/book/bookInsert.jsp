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
	
	$("#insertBtn").on("click" , function() {
		if($("#title").val()==""){
			alert("책 제목을 입력하세요");
			$("#title").focus();
			
		}else if($("#author").val()==""){
			alert("저자를 입력하세요");
			$("#author").focus();
			
		}else if($("#co").val() == ""){
			alert("출판사를 입력하세요");
			$("#co").focus();
			
		}else if($("#bookDt").val() ==""){
			alert("출판일을 입력하세요.");
			$("#bookDt").focus();
			
		}else{
			$("#actionForm").submit();
		}
	})
	
	
	
});
</script>	
	
</head>
<body>
	<form action="bookRes" id="actionForm" method="post">
		
		<input type="hidden" name="gbn" value="i"/>
	
		책제목 <input type="text" id="title" name="title"/>
		저자 <input type="text" id="author" name="author"/>
		출판사 <input type="text" id="co" name="co"/>
		출판일<input type="date" id="bookDt" name="bookDt"/>
	</form>
	
	<input type="button" value="등록" id="insertBtn"/>
	<input type="button" value="목록" id="listBtn"/>
</body>
</html>