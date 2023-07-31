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
	
	//serialize() : 해당 내용물들 중 전달이 가능한 것들이 전송가능한 문자 형태로 전환.
	var params = $("#dataForm").serialize();
	console.log(params);
	
	$.ajax({
		url : "testAAjax", //경로
		type : "POST",    //전송방식(GET : 주소형태, POST : 주소 헤더 형태)
		dataType : "json",//데이터 형태
		data : params,
		success : function(res) {//성공했을 때 결과를 res에 받고 함수 실행
			console.log(res);
            console.log(res.msg);
		},
		error : function(request, status, error) {// 실패했을 때 함수 실행
			console.log(request.responseText);    //실패 상세 내역
		}
		
	});

	
});
</script>
</head>
<body>
	<form id="dataForm" action="#">
		<input type="text" name="a" id="a" >
		<input type="text" name="b" id="b">
	</form>
	
	<input type="button" value="로그인" id="loginBtn">
</body>
</html>