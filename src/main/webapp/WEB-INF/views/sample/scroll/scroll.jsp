<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Slimscroll Sample</title>
<link rel="shortcut icon" href="resources/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<!-- jQuery Script -->
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
		src="resources/script/common/common.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.slimscroll.js"></script>
<style>
/* 스크롤용 박스 크기지정 */
.box_wrap {
	width: 200px;
	height: 200px;
	border: 1px solid #444;
	margin: 0 auto;
}
.box {
	display: inline-block;
	width: 200px;
	height: 200px;
	font-size: 14pt;
}
</style>  
<script type="text/javascript">
$(document).ready(function() {
	$(".box").slimscroll({
		width : 200,
		height : 200,
		axis : "both" // axis - both, x, y
	});
});
</script>
</head>
<body>
	<div class="cmn_title">스크롤 샘플<div class="cmn_btn_mr float_right_btn" id="sampleListBtn">샘플목록</div></div>
	<div class="box_wrap">
		<div class="box">
		나라의 말이 중국과 달라<br/>
		문자(한자)로 서로 통하지 아니하여서<br/>
		이런 까닭으로 어리석은 백성이<br/>
		말하고자 하는 바가 있어도<br/>
		마침내 제 뜻을 능히 펴지<br/>
		못하는 사람이 많다<br/>
		내가 이를 위하여 가엾이 여겨<br/>
		새로 스물여덟 자를 만드니<br/>
		사람마다 하여금 쉬이 익혀 날마다 씀에<br/>
		편안하게 하고자 할 따름이다
		</div>
	</div>
</body>
</html>













