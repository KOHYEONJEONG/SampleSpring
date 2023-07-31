<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sync Board Test</title>
<link rel="shortcut icon" href="resources/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<style type="text/css">
.wrap {
	width: 700px;
	margin: 0 auto;
}
</style>
<!-- jQuery Script -->
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
		src="resources/script/common/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#updateBtn").on("click", function(){
		$("#actionForm").attr("action", "syncUpdate");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function(){
		if(confirm("삭제하시겠습니까?")) {
			if($.trim($("#pass").val()) == "") {
				alert("비밀번호를 입력하세요.");
				$("#pass").focus();
			} else {
				
				$("input[name='pass']").val($("#pass").val());
				$("#actionForm").attr("action", "syncAction");
				$("#actionForm").submit();
			}
		}
	});
	
	$("#backBtn").on("click", function(){
		$("#actionForm").attr("action", "syncList");
		$("#actionForm").submit();
	});
});
</script>
</head>
<body>
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="gbn" value="d" />
	<input type="hidden" name="boardNo" value="${data.BOARD_NO}" />
	<input type="hidden" name="page" value="${param.page}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchText" value="${param.searchText}" />
	<input type="hidden" name="pass" />
</form>
<div class="cmn_title">동기화 게시판 샘플<div class="cmn_btn_mr float_right_btn" id="sampleListBtn">샘플목록</div></div>
<div class="wrap">
	<table class="board_detail_table">
		<colgroup>
			<col width="100"/>
			<col width="600"/>
		</colgroup>
		<tbody>
			<tr>
				<th>번호</th>
				<td class="board_cont_left">${data.BOARD_NO}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td class="board_cont_left">${data.TITLE}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td class="board_cont_left">${data.WRITER}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td class="board_cont_left">${data.WRITE_DATE}</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td class="board_cont_left">${data.HIT_CNT}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="board_cont_left">${data.CONTENTS}</td>
			</tr>
			<tr>
				<th>삭제비밀번호</th>
				<td class="board_cont_left"><input type="password" id="pass" /></td>
			</tr>
		</tbody>
	</table>
	<div>
		<div class="cmn_btn_ml float_right_btn" id="backBtn">뒤로가기</div>
		<div class="cmn_btn_ml float_right_btn" id="deleteBtn">삭제</div>
		<div class="cmn_btn_ml float_right_btn" id="updateBtn">수정</div>
	</div>
</div>
</body>
</html>








