<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<!-- Common CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<!-- Popup CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />
<style type="text/css">
.wrap{
	width: 800px;
	margin: 0 auto;
}


</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
		src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" 
		src="resources/script/common/popup.js"></script>
<!-- CKEditor -->
<!-- 제이쿼리 뒤에 나와야함, 제이쿼리 기반으로 동작하기 때문에 -->
<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	// 에디터 연결
	// CKEDITOR.replace(아이디, 옵션)
	CKEDITOR.replace("descript", {
		resize_enabled: false, // resize_enabled : 크기조절기능 활용여부
		language : "ko", // 사용언어
		enterMode: "2", // 엔터키처리방법. 2번이면 <br/>
		width : "100%", // 숫자일경우 px, 문자열일경우 css크기
		height : 400
	});
	
	$("#listBtn").on("click", function () {
		$("#backForm").submit();
	});
	
	$("#insertBtn").on("click", function () {
		// CKEditor의 값 취득
		// CKEDITOR.instances[아이디] : CKEditor중 아이디가 같은 것을 찾겠다.
		//.getData() : 작성중인 내용을 취득하겠다.
		$("#descript").val(CKEDITOR.instances['descript'].getData());
		
		if($.trim($("#title").val()) == ""){
			makeAlert("알림","제목 입력하세요." , function () {
				$("#title").focus();
			})
		} else if($.trim($("#descript").val()) == ""){
			makeAlert("알림","설명을 입력하세요." , function () {
				$("#descript").focus();
			})
		} else {
			// 1. 파입업로드 -> 2. 업로드 파일명 취득 -> 3. 글 저장
			// 폼 객체 취득
			var form = $("#actionForm");
			// ajaxForm 적용
			form.ajaxForm({
				success: function (res) { // 데이터 주고 받기 성공시
					if(res.result == "SUCCESS"){ // 파일 전송 성공
						// 올라간 파일이 존재한다면, 첨부파일이 없을 수도 있으니 조건문 처리
						if(res.fileName.length > 0){
							$("#pic").val(res.fileName[0]); // 올라간 파일명 보관		
						}
						// 3번 단계 글저장 시작, 기존테이터
						var params = $("#actionForm").serialize();
						
						$.ajax({
							url : "AGAction_sh/insert", //restful api라는게 여기서 시작한다고?
							type : "POST", 
							dataType: "json", 
							data: params, 
							success : function(res) { 
								switch(res.msg){
								case "success" : 
									// 카테고리를 유지하고 나머지 정보 초기화
									$("#page").val("1");
								
									$("#backForm").submit();
									break;
								case "fail" :
									makeAlert("알림" , "등록에 실패하였습니다.");
									break;
								case "error" :
									makeAlert("알림" , "등록 중 문제가 발생하였습니다.");
									break;
								}
							},
							error : function(request, status, error) { 
								console.log(request.responseText); 
							}
						});  // 글저장 끝
						
					} else { // 문제발생
						makeAlert("알림", "파일 업로드에<br/>문제가 발생하였습니다.")
					}
				},
				error: function () { // 에러시
					makeAlert("알림", "파일 업로드에<br/>문제가 발생하였습니다.")
				}
			}); // ajaxForm 설정 끝
			
			
			// ajaxForm 실행
			form.submit();
			
		}
	});
});

</script>
</head>
<body>
<c:import url="/testAHeader"></c:import>
<form action="AGList" id="backForm" method="post">
	<input type="hidden" name="page" id="page" value="${param.page}" />
</form>
<!-- ajax쓰기 때문에 gbn 지움 -->
<div class="wrap">
	<form action="fileUploadAjax" id="actionForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="pic" id="pic" /> <!-- 실 저장된 파일명 보관용 -->
		<table class="board_detail_table">
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" id="title" /></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${sMemNm}<input type="hidden" name="memNo" value="${sMemNo}" /><br/></td>
			</tr>
			<tr>
				<th colspan="2">내용</th>
			</tr>
			<tr>
				<th colspan="2"><textarea rows="10" cols="30" name="descript" id="descript"></textarea></th>
			</tr>			
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="pic" /></td>
			</tr>
		</table>
	</form>
	<div class="cmn_btn_ml float_right_btn" id="listBtn">목록</div>
	<div class="cmn_btn_ml float_right_btn" id="insertBtn">등록</div>
</div>
</body>
</html>