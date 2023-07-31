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
	
	$("#updateBtn").on("click", function() {
		
		if($("#id").val()==""){
			alert("아이디를 입력해주세요");
			$("#id").focus();
		}else if($("#pw").val() == "" ){
			alert("비밀번호를 입력해주세요.");
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
		<form action="memberRes/update" method="post" id="actionForm">
			
			<input type="hidden" name="no" value="${data.MEM_NO}"/>
			
			<table>
				<caption>회원 수정</caption>
				<colgroup>
					<col width="100">
					<col width="200">
				</colgroup>
				<tr>
					<th>ID</th>
					<td><input type="text" id="id" name="id" value="${data.MEM_ID}" readonly="readonly"/></td>
				</tr>
				
				<tr>
					<th>PWD</th>
					<td><input type="text" id="pw" name="pw" value="${data.MEM_PW}" /></td>
				</tr>
				
				<tr>
					<th>NAME</th>
					<td><input type="text" id="nm" name="nm" value="${data.MEM_NM}" /></td>
				</tr>
				
				<tr>
					<th>BirthDay</th>
					<td><input type="date" id="bd" name="bd" value="${data.MEM_BIRTH}"></td>
				</tr>
				
				
			</table>
			
			<div id="btnBox" class="btnBox">
				<input type="button" id="updateBtn" value="수정"/>
				<input type="button" id="listBtn" value="목록"/>
			</div>	
		</form>
	</div>
</body>
</html>