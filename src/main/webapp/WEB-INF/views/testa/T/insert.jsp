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
.wrap {
   width : 800px;
   margin : 0 auto;
}
</style>

<script type="text/javascript"
      src="resources/script/jquery/jquery-1.12.4.min.js"></script>
      
<!-- ajaxForm 사용하려고(파일업로드 시 많이 사용하는 비동기 form) -->            
<script type="text/javascript" 
		src="resources/script/jquery/jquery.form.js"></script>
<!-- CKEditor -->   
<script type="text/javascript"
      src="resources/script/ckeditor/ckeditor.js"></script>
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
   
   $("#listBtn").on("click", function() {
      $("#backForm").submit();
   });
   
   $("#insertBtn").on("click", function() {
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
						$("#att").val(res.fileName[0]);//올라간 파일명 보관(서버에서 주는 명으로 넣어짐. HTML에 145라인과 관계는 없다.)
					}
					
					/*글 저장*/
					 var params = $("#actionForm").serialize();
			         $.ajax({
			            url : "ATAction/insert",
			            type : "POST",
			            dataType : "json", 
			            data : params, 
			            success : function(res) { 
				            switch(res.msg){
					            case "success":
					            	//카테고리만 유지하고 나머지 정보 초기화
					            	$("#page").val("1");
					            	$("#searchGbn").val("0");
					            	$("#searchTxt").val("");
					            	
					            	$("#backForm").submit();
					               break;
					            case "fail":
					                makeAlert("알림", "등록에 실패하였습니다.");
					               break;
					            case "error":
					                makeAlert("알림", "등록 중 문제가 발생하였습니다.");
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
	
	<form action="ATList" id="backForm" method="post">
		
		<!-- 전 화면에서 넘어온 페이지 정보 -->
		<input type="hidden" id="searchGbn" name="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" id="searchTxt" name="searchTxt" value="${param.searchTxt}"/>

	   <!-- 전 화면에서 넘어온 페이지 정보 -->
	   <input type="hidden" id="page" name="page" value="${page}" />
	   <!-- 전 화면에서 넘어온 검색 정보 -->
	   <input type="hidden" id="oldGbn" value="${param.searchGbn}" />
	   <input type="hidden" id="oldTxt" value="${param.searchTxt}" />
	   
	   <!-- 전화면에서 넘어온 카테고리 번호(저장할때랑, 취소할때도 사용하려고) -->
	   <input type="hidden" name="cateNo" value="${param.cateNo}"/>
	</form>
	
	<div class="wrap">
		<form action="fileUploadAjax" id="actionForm" method="post" enctype="multipart/form-data">
		   <input type="hidden" id="att" name="att"/> <!-- 실 저장된 파일명 보관용 -->
		   <table class="board_detail_table">
		   
		   	<tr>
		   		<th>카테고리</th>
		   		<!-- ${cateNm}는 서버, ${param.cateNo}는 전화면에서 넘어온 값. -->
		   		<td>${cateNm} <input type="hidden" name="cateNo" value="${param.cateNo}"/></td>
		   	</tr>
		   
		      <tr>
		         <th>제목</th>
		         <td><input type="text" name="title" id="title" /></td>
		      </tr>
		      <tr>
		         <th>작성자</th>
		         <td>${sMemNm} <input type="hidden" name="memNo" value="${sMemNo}" /></td>
		      </tr>
		      <tr>
		         <th colspan="2">내용</th>
		      </tr>
		      <tr>
		         <td colspan="2"><textarea rows="10" cols="30" name="con" id="con"></textarea></td>
		      </tr>
		      
		      <!-- 파일 등록 -->
		      <tr>
		      	<th>첨부파일</th>
		      	<td><input type="file" name="attFile"/></td>
		      </tr>
		      
		   </table>
		</form>
	
		<div class="cmn_btn_ml float_right_btn" id="listBtn">목록</div>
		<div class="cmn_btn_ml float_right_btn" id="insertBtn">등록</div>
	</div>
</body>
</html>