<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- jstl의 functions : el tag 추가 옵션 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 상세보기</title>
<!-- Common css -->
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />

<style type="text/css">
	.wrap{
	   width:800px;
	   margin: 0 auto;
	}
	
	.con{
		text-align: left;
		height: 400px;
	}
</style>
<script type="text/javascript"
      src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/common/popup.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	   $("#listBtn").on("click",function(){
	      $("#actionForm").attr("action","AGALLERY");
	      $("#actionForm").submit();
	   });
	   
	   $("#deleteBtn").on("click", function(){
	     
		   //강사님이 만드신 makePopup!!!!
		   makePopup({
	    	  title : "알림",
	    	  contents : "삭제 하시겠습니까?",
			  buttons :[{ //배열로 버튼을 추가하면 창안에 들어간다!
					name : "삭제",
					func : function(){//버튼에 이벤트
						var params = $("#actionForm").serialize();
				         $.ajax({
				            url : "ATAction/delete",
				            type : "POST",
				            dataType : "json", 
				            data : params, 
				            success : function(res) { 
					            switch(res.msg){
					            case "success":
					            	
					            	$("#page").val("1"); //1 중요!!
					            	$("#searchGbn").val("0");
					            	$("#searchTxt").val("");
					            	
					               $("#actionForm").attr("action", "ATList");
					               $("#actionForm").submit();
					               break;
					               
					            case "fail":
					                makeAlert("알림", "삭제에 실패하였습니다.");
					               break;
					            case "error":
					                makeAlert("알림", "삭제 중 문제가 발생하였습니다.");
					               break;
					            }
					            },
					            error : function(request, status, error) {
					               console.log(request, responseText); 
					            }
				         });
					}
			   }, {//취소 버튼 추가!
				   name : "취소"
			   }]
	      });//makePopup
	   });
	   
	   $("#updateBtn").on("click", function(){
	      $("#actionForm").attr("action", "AGUpdate");
	      $("#actionForm").submit();
	   });
	});
</script>
</head>
<body>
	<c:import url="/testAHeader"></c:import>

	<!-- form action에서 #은 아무런 이동을 하지 않는다. -->
	<form action = "#" id="actionForm" method="post">
	   <input type="hidden" name="no" value="${data.NO}"/>
	   
	   <!--  전 화면에서 넘어온 페이지 정보 -->
	   <input type="hidden" name="page" id="page" value="${param.page}"/>
	   
	   <!--  전 화면에서 넘어온 검색 정보 -->
	   <input type="hidden" id="searchGbn" name="searchGbn" value="${param.searchGbn}"/>
	   <input type="hidden" id="searchTxt" name="searchTxt" value="${param.searchTxt}"/>
	   
	</form>
	
	<div class="wrap">
		<table class="board_detail_table">
					
			   <tr>
			      <th>번호</th>
			      <td>${data.NO}</td>
			   </tr>
			   
			   <tr>
			      <th>제목</th>
			      <td>${data.TITLE}</td>
			   </tr>
			   
			   <tr>
			      <th>작성자</th>
			      <td>${data.MEM_NM}</td>
			   </tr>
			   
			   <tr>
			      <th>작성일</th>
			      <td>${data.REG_DT}</td>
			   </tr>
			   
			   <tr>
			      <th>조회수</th>
			      <td>${data.HIT}</td>
			   </tr>
			   
			   <tr>
			      <th colspan="2">설명</th>
			   </tr>
			   
			   <tr>
			      <td class="con" colspan="2">${data.DESCRIPT}</td>
			   </tr>
			   
			   <!-- 첨부파일이 있다면 -->
			   <c:if test="${!empty data.PIC}">
			   							<!-- fn:length(대상) : 대상 문자열의 길이나 배열, 리스트의 크기를 가져온다. -->
			   <c:set var="fileLength" value="${fn:length(data.PIC)}"/>
			   
			   <!-- fn:substring(값, 숫자1, 숫자2) : 값을 숫자 1이상부터 숫자2미만까지 인덱스 기준으로 자른다. -->
			   <c:set var="fileName" value="${fn:substring(data.PIC, 20, fileLength)}"/>
			   
				   <tr>
				   		<th>첨부파일</th>
				   		<td><a href="resources/upload/${data.ATT}" download="${fileName}">${fileName}</a></td>
				   		<!-- 사용자한테도 파일코드들이 잘린 순수 파일명으로 보이게 하려면 download="${data.ATT}"로 작성해주면 된다!(download만 적어도 되지만, 다운받을 때 서버에서 가져온 '파일 코드+파일명'들이 보인다) -->
				   </tr>
				   
			   </c:if> 
		</table>
	
		<br/>
		
		<!-- flooat속성이라서 거꾸로 줘야지 거꾸로 보여짐 -->
		<div class="cmn_btn_ml float_right_btn" id="listBtn">목록</div>
		<c:if test="${sMemNo eq data.MEM_NO}">
			<div class="cmn_btn_ml float_right_btn" id="deleteBtn">삭제</div>
			<div class="cmn_btn_ml float_right_btn" id="updateBtn">수정</div>
		</c:if>
	
	</div>

</body>
</html>