<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- jsl의 functions : el tag 추가옵션 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
<!-- Common CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<!-- Popup CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />
<style type="text/css">
.wrap{
	width: 800px;
	margin: 0 auto;
}

.pic {
	display: none;
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
	
	$("#cancelBtn").on("click", function () {
		$("#backForm").submit();
	});
	
	// 첨부파일 파일삭제 버튼 클릭시
	$("#fileDelBtn").on("click", function () {
		// 기존 파일 내역 영역 제거
		$(".picOld").remove();
		// 기존 값 제거
		$("#pic").val("");
		// 파일 선택 영역 제공 
		$(".pic").show();
	});
	
	$("#updateBtn").on("click", function () {
		// CKEditor의 값 취득
		// CKEDITOR.instances[아이디] : CKEditor중 아이디가 같은 것을 찾겠다.
		//.getData() : 작성중인 내용을 취득하겠다.
		$("#descript").val(CKEDITOR.instances['descript'].getData());
		
		if($.trim($("#title").val()) == ""){
			makeAlert("알림","제목 입력하세요." , function () {
				$("#title").focus();
			})
		} else if($.trim($("#descript").val()) == ""){
			makeAlert("알림","내용을 입력하세요." , function () {
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
							url : "AGAction_sh/update", //restful api라는게 여기서 시작한다고?
							type : "POST", 
							dataType: "json", 
							data: params, 
							success : function(res) { 
								switch(res.msg){
								case "success" : 
									$('#backForm').submit();
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
	<input type="hidden" name="no" value="${data.NO}" />
</form>
<!-- ajax쓰기 때문에 gbn 지움 -->
<div class="wrap">
	<form action="fileUploadAjax" id="actionForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="no" value="${data.NO}" />
		<table class="board_detail_table">
			<tr>
				<th>번호</th>
				<td>${data.NO}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" id="title" value="${data.TITLE}"/></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${sMemNm}</td>
			</tr>
			<tr>
				<th colspan="2">내용</th>
			</tr>
			<tr>
				<th colspan="2"><textarea rows="10" cols="30" name="descript" id="descript">${data.DESCRIPT}</textarea></th>
			</tr>
			<tr>
				<th>첨부파일</th>
				
				<c:choose>
					
					<c:when test="${empty data.PIC}">
						<!-- 파일이 없을때 -->
						<td>
							<input type="file" name="picFile" />
							<input type="hidden" name="pic" id="pic"/>
						</td>
					</c:when>
					
					<c:otherwise>
						<!-- 파일이 있을때 -->
						<td>
							<span class="picOld"> <!-- 기존 파일 -->
								<!-- fn:length(대상) : 대상 문자열의 길이나 배열, 리스트의 크기를 가져온다 -->
								<c:set var="fileLength" value="${fn:length(data.PIC)}"></c:set>
								<!-- fn:substring(값, 숫자1, 숫자2) : 값을 숫자1이상부터, 숫자2미만까지, 인덱스 기준으로 자른다. -->
								<c:set var="fileName" value="${fn:substring(data.PIC, 20, fileLength)}"></c:set>
								${fileName}
							</span>
							
							<div class="cmn_btn_ml float_right_btn" id="fileDelBtn">파일삭제</div>
							
							<span class="pic"> <!-- 기존 파일 삭제 후 새 파일 용도 -->
								<input type="file" name="picFile" />
								<input type="hidden" name="pic" id="pic" value="${data.PIC}"/>
							</span>
						</td>
					</c:otherwise>
				</c:choose>
			</tr>
		</table>
	</form>
	<div class="cmn_btn_ml float_right_btn" id="cancelBtn">취소</div>
	<div class="cmn_btn_ml float_right_btn" id="updateBtn">수정</div>
</div>
</body>
</html>