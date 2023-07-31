<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
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
	$("#btnWrap").on("click", "button", function() {
		
		if($(this).attr("id") == "deleteBtn" || 
					($(this).attr("id") == "deleteBtn" && confirn('코드를 삭제하시겠습니까?'))){
			$("#actionForm").attr("action", $(this).attr("loc"));
			$("#actionForm").submit();
		}else if($(this).attr("id") == "updateBtn"){
			$("#actionForm").attr("action",$(this).attr("loc"));
			$("#actionForm").submit(); 
		}else{
			location.href="divsList";
		}
		
	});
});
</script>
</head>
<body>

	<form action="#" id="actionForm" method="post" >
	<!-- 삭제하는 페이지는 없잖아? 그래서 그냥 d로 지정해줌. -->
		<input type="hidden" name="gbn" value="d"/>
		<input type="hidden" name="code" value="${data.DIV_CODE}"/>
	</form>
	
	<h3>상세보기</h3>
	<table>
		<tr>
			<th>코드</th>
			<th>코드명</th>
		</tr>
		
		<tr>
			<td>${data.DIV_CODE}</td>
			<td>${data.DIV_NAME}</td>
		</tr>
	</table>
	
	<br/>
	
	<div id="btnWrap">
		<button type="button" id="updateBtn" loc="divsUpdatePage">수정</button>
		<button type="button" id="deleteBtn" loc="divsResult">삭제</button>
		<button type="button" id="listBtn" loc="divsList">목록</button>
	</div>
	
</body>
</html>