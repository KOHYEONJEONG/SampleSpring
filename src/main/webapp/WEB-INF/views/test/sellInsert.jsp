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
	$("#listBtn").on("click", function() { 
		history.back(); /*처음화면으로 돌아가기*/
	});
	
	$("#insertBtn").on("click", function() { 
		if($("#count").val() == ""){
			alert("수량을 입력하세요.");
			$("#count").focus();
		}else if($("#count").val() *1 < 1){
			/*(고려사항)정확하게 어떤한 값들이 필수인지 아닌지 처리를 해야한다.*/
			alert("수량은 1개 이상이어야 합니다.");
			$("#count").focus();
		}
		else if($("#sellDt").val() == ""){
			alert("일자를 입력하세요.");
			$("sellDt").focus();
		}else{
			$("#actionForm").submit();
		}
	});
});
</script>
</head>
<body>
<!-- sellRes 컨트롤러에서 삽입, 수정, 삭제 가능함.  -->
	<form action="sellRes" id="actionForm" method="post">
	
		<!-- 구분에 따라 행위가 달라짐. -->
		<!-- 구분 : i - insert, u - update, d - delete -->
		<input type="hidden" name="gbn" value="i"/>
		
		품목명 <select name="itemName">
			<!-- value는 명시적으로 적어주는 게 좋고, 다 입력하자. -->
			<option value="감자">감자</option>
			<option value="고구마">고구마</option>
			<option value="애호박">애호박</option>
			<option value="호박">호박</option>
			<option value="호박고구마">호박고구마</option>
		</select> <br /> 수량 : <input type="number" name="count" id="count" value="0" />
		<br /> 일자 <input type="date" name="sellDt" id="sellDt" /> <br />
	</form>
	<input type="button" value="등록" id="insertBtn" />
	<input type="button" value="목록" id="listBtn" />
</body>
</html>