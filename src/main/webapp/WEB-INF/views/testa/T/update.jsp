<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- jstl의 functions : el tag 추가 옵션 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>

<!-- Common CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<!-- Popup CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />

<style type="text/css">
	.wrap {
	   width : 800px;
	   margin : 0 auto;
	}
	
	.att{
		display: none;/*안 보이게*/
	}
</style>

<script type="text/javascript"
      src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<!-- CKEditor -->   
<script type="text/javascript"
      src="resources/script/ckeditor/ckeditor.js"></script>
      
<!-- ajaxForm 사용하려고(파일업로드 시 많이 사용하는 비동기 form) -->      
<script type="text/javascript" 
		src="resources/script/jquery/jquery.form.js"></script>      
      
<script type="text/javascript"
      src="resources/script/common/popup.js"></script>      
<script type="text/javascript">
$(document).ready(function() {
   // 에디터 연결
   CKEDITOR.replace("con", {
      resize_enabled : false, // resize_enabled : 크기조절기능 활용여부
      language : "ko", // 사용언어
      enterMode : "2", // 엔터키 처리 방법
      width : "100%", // 숫자일 경우px, 문자열일경우 css크기
      height : 400
   });
   
   //취소 버튼
   $("#cancleBtn").on("click", function() {
      $("#backForm").submit();
   });
   
   //파일 삭제 버튼
   $("#fileDelBtn").on("click", function() {
		$(".attOld").remove();//기존 파일 내역 영역 제거
		$("#att").val("");//기존 값 제거
		$(".att").show();//파일 선택 영역 제공 (display:none이 였던 거를 show로!) 
	});
   
   //수정 버튼
   $("#updateBtn").on("click", function() {
      // CKEditor의 값 취득
      // CKEDITOR.instances[아이디] : CKEditor중 아이디가 같은 것을 찾겠다.
      // .getDate() : 작성중인 내용을 취득한다
      $("#con").val(CKEDITOR.instances['con'].getData());
      
      // $.trim(값) : 값 앞 뒤 공백제거
      if($.trim($("#title").val()) == "") {
         makeAlert("알림", "제목을 입력하세요.", function() {
            $("#title").focus();
         });
      } else if($.trim($("#con").val()) == "") {
         makeAlert("알림", "내용을 입력하세요.", function() {
            $("#con").focus();
         });
      } else {
    		 var form = $("#actionForm"); 
        	 //ajaxform 적용
        	 form.ajaxForm({
        		success: function(res) {//데이터 주고 받기 성공시
    				if(res.result == "SUCCESS"){//FileController.java에 fileUploadAjax메소드에서 SUCCESS 또는 ERROR 반환.
    					if(res.fileName.length > 0){
    						//올라간 파일이 존재한다면
    						$("#att").val(res.fileName[0]);//올라간 파일명 보관
    					}
    					
    					/*글 저장*/
    					 var params = $("#actionForm").serialize();
    			         $.ajax({
    			            url : "ATAction/update",
    			            type : "POST",
    			            dataType : "json", 
    			            data : params, 
    			            success : function(res) { 
    				            switch(res.msg){
    					            case "success":
										$("#backForm").submit();
    					            	break;
    					            case "fail":
    					                makeAlert("알림", "수정에 실패하였습니다.");
    					                break;
    					            case "error":
    					                makeAlert("알림", "수정 중 문제가 발생하였습니다.");
    					                break;
    				            }
    			            },
    			            error : function(request, status, error) {
    			               console.log(request, responseText); 
    			            }
    			         });//ajax
    			         
    				}else{
    					makeAlert("알림", "파일 업로드에<br/> 문제가 발생하였습니다.");
    				}
    			},error : function() {//에러시
    				makeAlert("알림", "파일 업로드에<br/> 문제가 발생하였습니다.");
    			}
    			
        	});//ajaxForm
        	 
        	form.submit();//전송
      }   
   });
});
</script>
</head>
<body>

	<c:import url="/testAHeader"></c:import>

		<!-- form -->
		<form action="ATList" id="backForm" method="post">
		
			<input type="hidden" name="no" value="${data.NO}"/> <!-- from이 달랏서 같은 no여도 상관없음. -->
		
		   <!-- 전 화면에서 넘어온 페이지 정보 -->
		   <input type="hidden" id="page" name="page" value="${page}" />
		   <!-- 전 화면에서 넘어온 검색 정보 -->
		   <input type="hidden" id="oldGbn" name="oldGbn" value="${param.searchGbn}" />
	   	   <input type="hidden" id="oldTxt" name="oldTxt" value="${param.searchTxt}" />
		   <input type="hidden" name="cateNo" value="${param.cateNo}"/>
		</form>
		
		
		<!-- 다른 form -->
		<div class="wrap">
			<form action="fileUploadAjax" id="actionForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="no" value="${data.NO}"/>
				
				<!-- 전화면에서 넘어온 카테고리번호 -->
				<input type="hidden" name="cateNo" value="${param.cateNo}"/>
			
			   <table class="board_detail_table">
			   
			   	  <tr>
			         <th>카테고리</th>
			         <td>${cateNm}</td>
			      </tr>
			      
				  <tr>
			         <th>번호</th>
			         <td>${data.NO}</td>
			      </tr>		   
			      
			      <tr>
			         <th>제목</th>
			         <td><input type="text" name="title" id="title" value="${data.TITLE}" /></td>
			      </tr>
			      
			      <tr>
			         <th>작성자</th>
			         <td>${sMemNm}</td>
			      </tr>	
			      
			      <tr>
			         <th colspan="2">내용</th>
			      </tr>
			      <tr>
			         <td colspan="2"><textarea rows="10" cols="30" name="con" id="con">${data.CON}</textarea></td>
			      </tr>
			      
			      <tr>
			      	<th style="color: blue;">첨부파일</th>
			      	<c:choose>
			      		<c:when test="${empty data.ATT}">
			      			<!-- 파일 없을 때 -->
			      			<td>
			      				<input type="file" name="attFile" ><!-- name="attFile" -->
			      				<input type="hidden" name="att" id="att">
			      			</td>
			      		</c:when>
			      		
			      		<c:otherwise>
			      			<!-- 파일 있을 때 -->
			      			<td>
			      				<span class="attOld">
			      					   <!-- fn:length(대상) : 대상 문자열의 길이나 배열, 리스트의 크기를 가져온다. -->
		   							   <c:set var="fileLength" value="${fn:length(data.ATT)}"/>
									   <!-- fn:substring(값, 숫자1, 숫자2) : 값을 숫자 1이상부터 숫자2미만까지 인덱스 기준으로 자른다. -->
									   <c:set var="fileName" value="${fn:substring(data.ATT, 20, fileLength)}"/>
									   ${fileName}
			      				</span>
			      				
			      				<!-- 파일 삭제 버튼 -->
								<div class="cmn_btn_ml float_right_btn" id="fileDelBtn">파일삭제</div>
			      				
			      				<span class="att">
			      					<!-- 기존 파일 삭제 후 새파일 용도 -->
			      					<input type="file" name="attFile" /><!-- name="attFile" -->
			      					<input type="hidden" name="att" id="att" value="${data.ATT}"/>
		      					</span>
			      			</td>
			      		</c:otherwise>
			      	</c:choose>
			      </tr>
			   </table>
			</form>
		
			<div class="cmn_btn_ml float_right_btn" id="cancleBtn">취소</div>
			<div class="cmn_btn_ml float_right_btn" id="updateBtn">수정</div>
		</div>
	</body>
</html>