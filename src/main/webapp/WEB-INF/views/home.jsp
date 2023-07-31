<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SampleSpring Home</title>
<link rel="shortcut icon" href="resources/favicon/favicon.ico">
<link rel="stylesheet" type="text/css"
	href="resources/css/common/cmn.css" />
<style type="text/css">
body {
	overflow: auto;
}

.wrap {
	width: 700px;
	margin: 0 auto;
}

.info {
	display: none;
	margin-top: 5px;
	margin-bottom: 20px;
	padding: 0px 20px;
	width: calc(100% - 40px);
	font-size: 10.5pt;
	white-space: pre-line;
}

@
keyframes headlineHover {
	from {background-color: #ffffff;
}

to {
	background-color: #eaf3ff;
}

}
.headline:hover {
	background-color: #eaf3ff;
	animation-name: headlineHover;
	animation-duration: 1s;
}

.btn_wrap {
	height: 30px;
	margin: 5px 0px;
}
</style>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".move_btn").on("click", function() {
			location.href = $(this).attr("loc");
		});

		$(".info_btn").on("click", function() {
			$("#i" + $(this).attr("no")).toggle();
		});
	});
</script>
</head>
<body>
	<div class="cmn_title">Sample Spring MVC 샘플 목록</div>
	<div class="wrap">
		<div class="sample_wrap">
			<div class="headline">
				비동기화 게시판
				<div class="cmn_btn_ml float_right_btn move_btn" loc="ajaxBoard">이동</div>
				<div class="cmn_btn_ml float_right_btn info_btn" no="0">설명</div>
			</div>
			<div class="info" id="i0">Ajax방식을 채용한 SPA(Single Page
				Application)게시판 resource/sqlFile/board.sql(Oracle) 적용 후 확인 가능</div>
		</div>
		<div class="sample_wrap">
			<div class="headline">
				동기화 게시판
				<div class="cmn_btn_ml float_right_btn move_btn" loc="syncList">이동</div>
				<div class="cmn_btn_ml float_right_btn info_btn" no="1">설명</div>
			</div>
			<div class="info" id="i1">동기화 방식을 채용한 게시판
				resource/sqlFile/board.sql(Oracle) 적용 후 확인 가능</div>
		</div>
		<div class="sample_wrap">
			<div class="headline">
				파일업로드
				<div class="cmn_btn_ml float_right_btn move_btn" loc="fileUpload">이동</div>
				<div class="cmn_btn_ml float_right_btn info_btn" no="2">설명</div>
			</div>
			<div class="info" id="i2">jQuery Form의 ajaxForm을 활용한
				Spring파일업로드</div>
		</div>
		<div class="sample_wrap">
			<div class="headline">
				팝업
				<div class="cmn_btn_ml float_right_btn move_btn" loc="popup">이동</div>
				<div class="cmn_btn_ml float_right_btn info_btn" no="3">설명</div>
			</div>
			<div class="info" id="i3">jQuery기반 커스텀 팝업</div>
		</div>
		<div class="sample_wrap">
			<div class="headline">
				Rest Api
				<div class="cmn_btn_ml float_right_btn move_btn" loc="rest">이동</div>
				<div class="cmn_btn_ml float_right_btn info_btn" no="4">설명</div>
			</div>
			<div class="info" id="i4">@RestController를 활용한 Rest Api
				resource/sqlFile/rest.sql(Oracle) 적용 후 확인 가능</div>
		</div>
		<div class="sample_wrap">
			<div class="headline">
				캘린더
				<div class="cmn_btn_ml float_right_btn move_btn" loc="calendar">이동</div>
				<div class="cmn_btn_ml float_right_btn info_btn" no="5">설명</div>
			</div>
			<div class="info" id="i5">jQuery Datepicker, Javascript 커스텀 달력,
				Fullcalendar</div>
		</div>
		<div class="sample_wrap">
			<div class="headline">
				차트
				<div class="cmn_btn_ml float_right_btn move_btn" loc="chart">이동</div>
				<div class="cmn_btn_ml float_right_btn info_btn" no="6">설명</div>
			</div>
			<div class="info" id="i6">Highchart(v3.x)기반 비동기식 차트</div>
		</div>
		<div class="sample_wrap">
			<div class="headline">
				채팅
				<div class="cmn_btn_ml float_right_btn move_btn" loc="chat">이동</div>
				<div class="cmn_btn_ml float_right_btn info_btn" no="7">설명</div>
			</div>
		</div>
		<div class="sample_wrap">
			<div class="info" id="i7">비동기 방식의 실시간 채팅
				resource/sqlFile/chat.sql(Oracle) 적용 후 확인 가능</div>
			<div class="headline">
				Fancybox
				<div class="cmn_btn_ml float_right_btn move_btn" loc="fancybox">이동</div>
				<div class="cmn_btn_ml float_right_btn info_btn" no="8">설명</div>
			</div>
		</div>
		<div class="sample_wrap">
			<div class="info" id="i8">jQuery기반 Fancybox</div>
			<div class="headline">
				Zoom
				<div class="cmn_btn_ml float_right_btn move_btn" loc="zoom">이동</div>
				<div class="cmn_btn_ml float_right_btn info_btn" no="9">설명</div>
			</div>
			<div class="info" id="i9">jQuery기반 Zoom</div>
		</div>
		<div class="sample_wrap">
			<div class="headline">
				Slimscroll
				<div class="cmn_btn_ml float_right_btn move_btn" loc="scroll">이동</div>
				<div class="cmn_btn_ml float_right_btn info_btn" no="10">설명</div>
			</div>
			<div class="info" id="i10">jQuery기반 Slimscroll</div>
		</div>
	</div>
</body>
</html>