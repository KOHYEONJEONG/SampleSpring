<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
	$(document).ready(function() {
		
		$("#actionForm").on("keypress","input", function(event) {
			if(event.keyCode == 13){
				//enter키를 입력햇을때
				//login(); //방법1)직접 함수 호출
				
				
				//방법2)버튼 이벤트 박생
				$("#loginBtn").click();
				return false;//enter키는 폼을 실행하는 속성이 있는데 그거 안하겠다.
			}
		});
		$("#loginBtn").on("click", login);
	});
	
	function login() {
		if($.trim($("#id").val()) == "" ){
			alert("아이디를 입력하세요.");
			$("#id").focus();
			
		}else if($.trim($("#pw").val()) == ""){
			alert("비밀번호를 입력하세요.");
		}else{
			$("#actionForm").submit();
		}
	}

</script>

</head>
<body>
<form action="testLoginAction" id="actionForm" method="post">
	<table>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="id" id="id"/>
		</tr>
		
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="pw" id="pw"/>
		</tr>
		
	</table>
</form>
	<input type="button" value="로그인" id="loginBtn"/> 
</body>
</html>