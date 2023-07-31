<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- jstl의 functions : el tag 추가 옵션 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리 사진 수정</title>
<!-- Common CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<!-- Popup CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />
<style type="text/css">
.wrap {
   width : 800px;
   margin : 0 auto;
}

.pic{
		/*수정할 페이지에 PIC가 있다면 파일 올리는 버튼 안보이게.*/
		display: none;/*안 보이게*/
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
	CKEDITOR.replace("descript", {
	   resize_enabled : false, // resize_enabled : 크기조절기능 활용여부
	   language : "ko", // 사용언어
	   enterMode : "2", // 엔터키 처리 방법
	   width : "100%", // 숫자일 경우px, 문자열일경우 css크기
	   height : 400
	});
	
	//취소버튼
   $("#cancleBtn").on("click", function() {
	    $("#backForm").submit();
	});
   
   
	//파일 삭제 버튼
	$("#fileDelBtn").on("click", function() {
		$(".picOld").remove();//기존 파일 내역 영역을 제거
		$("#pic").val("");//기존 값 제거
		$(".pic").show();	
	});
	
   //수정버튼
   $("#updateBtn").on("click", function() {
	   // CKEditor의 값 취득
	   // CKEDITOR.instances[아이디] : CKEditor중 아이디가 같은 것을 찾겠다.
	   // .getDate() : 작성중인 내용을 취득한다
	   $("#descript").val(CKEDITOR.instances['descript'].getData());
	   
	   if($.trim($("#title").val()) == ""){
		   makeAlert("알림","제목을 입력하세요.",function(){
			   $("#title").focus();
		   });
	   }else if($.trim($("#descript").val())==""){
		   makeAlert("알림","설명을 입력하세요.", function(){
			   $("#descript").focus();
		   });
	   }else if($.trim($("#descript").val()) == ""){
		   makeAlert("알림","설명을 입력해주세요.", function(){
			   $("#descript").focus();
		   });
		   
		   //사진은 비동기 form에서 실행하여 사진 byte크기가 0이하면 
		   //CommonPorperties.java에서 ERROR를 반환
	   }else{
		   var form = $("#actionForm");
		   
		   //비동기form
		   form.ajaxForm({
			   success:function(res){
			   if(res.result == "SUCCESS"){
				   if(res.fileName.length > 0){
					   $("#pic").val(res.fileName[0]);//올라간 파일명 보관(서버에서 파일이름 알맞게 바꿔서 보내줌.)
				   }
					   
			   /*글 수정*/
			   var params = $("#actionForm").serialize();
			   $.ajax({
				   url : "AGAction/update",
				   type:"POST",
				   dataType:"json",
				   data : params, 
				   success: function(res){
						switch (res.msg) {
						case "success":
							$("#page").val("1");
							$("#searchGbn").val("0");
							$("#searchTxt").val("");
							
							$("#backForm").submit();
							break;
						case "fail":
							makeAlert("알림","수정에 실패하였습니다");
							break;
						case "error":
							makeAlert("알림","수정 중 문제가 발생하였습니다");
							break;
	
						}
				   },
				   error : function(resques) {
						console.log(request, responseText);
				   }//error
			   });//ajax
			
			   
			}else{
				makeAlert("알림", "파일 업로드에<br/> 문제가 발생하였습니다.");
			}
		},error : function() {//에러시
			makeAlert("알림", "파일 업로드에<br/> 문제가 발생하였습니다.");
		}
		
	});//ajaxForm
	form.submit();
	   }
   });
});
</script>
</head>
<body>
	<c:import url="/testAHeader"></c:import>
	
	<form action = "AGALLERY" id="backForm" method="post">
		
		<input type="hidden" id="searchGbn" name="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" id="searchTxt" name="searchTxt" value="${param.searchTxt}"/>
		
		<input type="hidden" id="page" name="page" value="${page}"/>
		
		<input type="hidden" id="oldGbn" value="${param.searchGbn}"/>
		<input type="hidden" id="oldTxt" value="${param.searchTxt}"/>
		
	</form>
	
	<div class="wrap">
		<form action="fileUploadAjax" id="actionForm" method="post" enctype="multipart/form-data">
		   <input type="hidden" name="no" value="${data.NO}"/>
		   <table class="board_detail_table">
		      <tr>
		         <th>제목</th>
		         <td><input type="text" name="title" id="title" value="${data.TITLE}"/></td>
		      </tr>
		      
		      <tr>
		         <th>작성자</th>
		         <td>${sMemNm} <input type="hidden" name="memNo" value="${sMemNo}" /></td>
		      </tr>
		      
		      <tr>
		         <th colspan="2">설명</th>
		      </tr>
		      
		      <tr>
		         <td colspan="2"><textarea rows="10" cols="30" name="descript" id="descript">${data.DESCRIPT}</textarea></td>
		      </tr>
		      
		      <tr>
		      	<th style="color:blue;">첨부파일</th>
		      	<c:choose>
		      		<c:when test="${empty data.PIC}">
		      			<!-- 파일이 없을 때 -->
		      			<td>
		      			<!-- name="attFile" = FileController.java에서 getFileMap()에 name을 불러옴. -->
		      				<input type="file" name="picFile"/>
		      				<input type="hidden" name="pic" id="pic"/>
		      			</td>
		      		</c:when>
		      		
		      		<c:otherwise>
		      			<td>
		      				<span class="picOld">
		      					<c:set var="fileLength" value="${fn:length(data.PIC)}"/>
		      					<c:set var="fileName" value="${fn:substring(data.PIC, 20, fileLength)}"/>
		      					${fileName}
		      					
		      				</span>
		      				<!-- 파일 삭제 버튼 -->
	      					<div class="cmn_btn_ml float_right_btn" id="fileDelBtn">파일삭제</div>
		      				
		      				<span class="pic">
		      					<input type="file" name="picFile"/> <!-- name은 FileController.java에서 getFileMap()에서 받을 때 사용한다. -->
		      					<input type="hidden" name="pic" id="pic" value="${data.PIC}"/>
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