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
$(document).ready(function(){
	
	$("#listBtn").on("click", function() {
		location.href="memberList";
	});
	
	$("#insertBtn").on("click", function() {
		
		if($.trim($("#id").val())==""){
			alert("아이디를 입력해주세요");
			$("#id").focus();
		}else if($("#pw").val() == "" ){
			alert("비밀번호를 입력해주세요.");
			$("#pw").focus();
		}else if($.trim($("#pw").val()) != $.trim($("#repw").val())){
			alert("비밀번호가 일치하지 않습니다.")
			$("#pw").val("");
			$("#repw").val("");
			$("#pw").focus();
			
		}else if($("#nm").val()==""){
			alert("이름을 입력해주세요.");
			$("#nm").focus();
			
		}else if($("#dt").val()==""){
			alert("날짜를 입력해주세요.");
			$("#dt").focus();
		}else{
			$("#actionForm").submit();
		}
		
	});
});

</script>
</head>
<body>
	<div>
		<form action="memberRes/insert" method="post" id="actionForm">
			
			<table>
				<caption>회원 입력</caption>
				<colgroup>
					<col width="100">
					<col width="200">
				</colgroup>
				<tr>
					<th>ID</th>
					<td><input type="text" id="id" name="id" /></td>
				</tr>
				
				<tr>
					<th>PWD</th>
					<td><input type="text" id="pw" name="pw" /></td>
				</tr>
				
				<tr>
					<th>RE PWD</th>
					<td><input type="text" id="repw" name="repw" /></td>
				</tr>
				
				<tr>
					<th>NAME</th>
					<td><input type="text" id="nm" name="nm" /></td>
				</tr>
				
				<tr>
					<th>BirthDay</th>
					<td><input type="date" id="bd" name="bd"></td>
				</tr>
			</table>
			
			<div id="btnBox" class="btnBox">
				<input type="button" id="insertBtn" value="등록"/>
				<input type="button" id="listBtn" value="목록"/>
			</div>	
		</form>
	</div>
</body>
</html>