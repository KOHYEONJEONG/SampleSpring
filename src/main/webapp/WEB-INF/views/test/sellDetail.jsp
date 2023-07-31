<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript"> 
	$(document).ready(function() {
		$("#listBtn").on("click", function() { 
			//history.back(); /*처음화면으로 돌아가기*/
			$("#actionForm").attr("action","sellList");
			$("#actionForm").submit();
		});
		
		$("#deleteBtn").on("click", function() {
			
			//no를 받아서 해당 글 삭제하려고 보냄.
			if(confirm("삭제하시겠습니까?")){
				$("#actionForm").attr("action","sellRes");
				$("#actionForm").submit(); //gbn이랑 no가 넘어감 
			};
			
		});
		
		$("#udpateBtn").on("click", function() {
			//no를 받아서 해당 글 수정하려고 보냄.
			$("#actionForm").attr("action","sellUpdate");
			$("#actionForm").submit();
		});
	
	});//document
</script>
</head>
<body>
	
	<!-- form action ="#" : 아무런 이동을 하지 않겠다.(목적지 없음), js에서 attr로 하나의 폼으로 여러개를 실행가능하다. -->
	<form action="#" id="actionForm" method="post">
		<input type="hidden" name="gbn" value="d"/>
		<!-- 전 화면에서 넘어오기 때문에 param 붙여줌. -->
		<input type="hidden" name="no" value="${data.SELL_NO}"/>
		
		
		<!--(중요)전 화면에서 넘어온 페이지 정보(목록으로 돌아가더라도 페이지 상태값이 유지된다.)  -->
		<input type="hidden" name="page" value="${param.page}">
		
		<!--(중요) 밑2줄, 상세보기 다녀와도 검색어가 유지되도록 하기 위해서.(sellList.jsp와 유지되게) -->
		<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
		
	</form>
	
	<!-- sellLiST.jsp에서 클릭한 td에 대한 내용만 찍어주는 jsp -->
	 번호 : ${data.SELL_NO}<br/>
	 품목 : ${data.ITEM_NAME}<br/>
	 수량 : ${data.COUNT}<br/>
	 일자 : ${data.SELL_DT}<br/>
	 
	 <input type="button" value="수정" id="udpateBtn">
	 <input type="button" value="삭제" id="deleteBtn">
	 <input type="button" value="목록" id="listBtn">
</body>
</html>