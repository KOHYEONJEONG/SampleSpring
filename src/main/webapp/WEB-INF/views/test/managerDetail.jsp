<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript"> 
$(document).ready(function() {
	/*	
	$("#listBtn").on("click", function() { 
		history.back(); 처음화면으로 돌아가기
	 });
	*/
	
	/*
 	$("#updateBtn").on("click", function() {
		$("#actionForm").attr("action","managerUpdate");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function() {
		$("#actionForm").attr("action","managerResult");//gdn이랑 no가 넘어감 
		$("#actionForm").submit();
	}); 
	*/
	
	/*한 function에 끝내는 방법(위와 결과는 같다.)*/
	$("#btnWrap").on("click", "input", function() {
		if($(this).attr("id") != "deleteBtn" ||
				($(this).attr("id") == "deleteBtn" && confirn("삭제?"))){
			$("#actionForm").attr("action", $(this).attr("loc"));
			$("#actionForm").submit();
			
		}else if($(this).attr("id") == "updateBtn"){
			$("#actionForm").attr("action",$(this).attr("loc"));
			$("#actionForm").submit();
			
		}else{
			/*managerList*/
			history.back(); /*처음화면으로 돌아가기*/
		}
	});
	
	
})
</script>
</head>
<body>
	<form action="#" id="actionForm" method="post">
		<input type="hidden" name="gbn" value="d"/>
		<input type="hidden" name="no" value="${data.EMP_NO}"/>
		
		<!--(중요)전 화면에서 넘어온 페이지 정보(목록으로 돌아가더라도 페이지 상태값이 유지된다.)  -->
		<input type="hidden" name="page" value="${param.page}">
		
		<!--(중요) 밑2줄, 상세보기 다녀와도 검색어가 유지되도록 하기 위해서.(sellList.jsp와 유지되게) -->
		<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
		
	</form>
	
		 번호 : ${data.EMP_NO}<br/>
		 이름 : ${data.NAME}<br/>
		 부서 : ${data.DEPT}<br/>
		 
		 <div id="btnWrap">
			 <input type="button" value="수정" id="updateBtn" loc="managerUpdate">
			 <input type="button" value="삭제" id="deleteBtn" loc="managerResult">
			 <input type="button" value="목록" id="listBtn" loc="managerList">
		</div>
</body>
</html>