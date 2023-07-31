<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>testa/login/로그인</title>

<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css"/>
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css"/>

<style type="text/css">
#actionForm{
	font-size : 11pt;
}
.wrap {
	padding:20px;
   width : 400px;
   margin : 0 auto;
   }
   
   hr{
   	border:  1px solid black;
   	background-color: black;
   }
   
   h3{
   font-size: 14px;
   }
</style>

<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>

<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css"/>
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css"/>
<script type="text/javascript" src="resources/script/common/popup.js"></script>

<script type="text/javascript">
$(document).ready(function () {
	$("#actionForm").on("keypress","input", function(event) {
		if(event.keyCode == 13){
			//enter키를 입력햇을때
			//login(); //방법1)직접 함수 호출
			//방법2)버튼 이벤트 박생
			$("#loginBtn").click();
			return false;//enter키는 폼을 실행하는 속성이 있는데 그거 안하겠다.
		}
	});
	
	$("#loginBtn").on("click", function() {
		if($.trim($("#id").val()) == "" ){
			makeAlert("알림", "아이디를 입력하세요", function() {
				$("#id").focus();
			});
			
		}else if($.trim($("#pw").val()) == ""){
			makeAlert("알림", "비밀번호를 입력하세요", function() {
				$("#pw").focus();
			});
		}else{
			var params = $("#actionForm").serialize();
			
			$.ajax({
				url : "testALoginAjax", //경로 
				type : "POST",    //전송방식(GET : 주소형태, POST : 주소 헤더 형태)
				dataType : "json",//데이터 형태
				data : params,
				success : function(res) {//성공했을 때 결과를 res에 받고 함수 실행
					//console.log(res);
					
					if(res.msg == "success"){
						location.href="testAMain"; 
						
					}else{
						makeAlert("알림","아이디나 비밀번호가 틀립니다.");
					}
				
				},
				error : function(request, status, error) {// 실패했을 때 함수 실행
					console.log(request.responseText);    //실패 상세 내역
				}
				
			});
		}
	});
	
});
</script>
</head>
<body>
	
	<div class="board_area wrap">
		<form action="#" id="actionForm">
				<h3>로그인</h3>
				<hr/>
				<table class="board_table">
				
					<tr>
						<th>아이디</th>
						<td><input type="text" name="id" id="id"/></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="pw" id="pw"/></td>
					</tr>
				</table>
		</form>
		<input type="button" value="로그인" id="loginBtn" />
		
		<h3>회원목록(로그인 상관없음.)=><a href="AMList">Member List</a></h3>
	</div>

</body>
</html>