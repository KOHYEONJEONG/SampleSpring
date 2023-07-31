<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chat Login</title>
<link rel="shortcut icon" href="resources/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<style type="text/css">
.wrap {
	width: 406px;
	margin: 0 auto;
}

#joinForm {
	height: 30px;
	font-size: 10.5pt;
}

#joinForm span {
	display: inline-block;
	vertical-align: top;
	width: 90px;
	height: 30px;
	padding: 0px 5px;
	line-height: 30px;
	text-align: center;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	font-weight: bold;
}

#userNick {
	width: 230px;
	height: 28px;
	padding: 0px 2px;
	text-indent: 5px;
	vertical-align: middle;
	border: 1px solid #d7d7d7;
	outline-color: #70adf9;
}
</style>
<!-- jQuery Script -->
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
		src="resources/script/common/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#joinBtn").on("click", function(){
		if($.trim($("#userNick").val()) == "") {
			alert("사용자 별칭을 입력해 주세요.");
		} else {
			$("#joinForm").submit();
		}
	});
});
</script>
</head>
<body>
	<div class="cmn_title">채팅 샘플<div class="cmn_btn_mr float_right_btn" id="sampleListBtn">샘플목록</div></div>
	<div class="wrap">
	<div class="headline">채팅 로그인</div>
	<form action="joinChat" method="post" id="joinForm">
	<span>닉네임</span>
	<input type="text" id="userNick" name="userNick" />
	<div class="cmn_btn_ml" id="joinBtn">입장</div>
	</form>
	</div>
</body>
</html>