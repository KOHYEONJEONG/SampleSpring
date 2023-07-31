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
	
		//체크된 값으로 알아서 넣어진다(꿀팁!!!)
		//기본 값으로 selectbox 선택 내용이 변경됨.
		$("#dept").val("${data.DEPT}"); //DB에서 넘어온 값이기 때문에 DEPT 컬럼은 꼭 대문자로 입력해야 가져온다!!!
		
		$("#listBtn").on("click", function() { 
			history.back(); /*처음화면으로 돌아가기*/
		});
		
		$("#updateBtn").on("click", function() {
			$("#actionForm").submit(); 
		});
});
</script>
</head>
<body>
	<form action="managerResult" id="actionForm" method="post">
		
		<input type="hidden" name="no" value="${data.EMP_NO}">
		
		<!-- 구분에 따라 행위가 달라진다(update 창이니까 u를 보냄) -->
		<input type="hidden" name="gbn" value="u" /> 
		
		<!--(중요) 밑2줄, 상세보기 다녀와도 검색어가 유지되도록 하기 위해서.(sellList.jsp와 유지되게) -->
		<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
		
		성함: <input type="text" 	name="name" id="name" value="${data.NAME}" />
		
		 부서: <select name="dept" id="dept">
			<option value="영업1팀">영업1팀</option>
			<option value="영업2팀">영업2팀</option>
			<option value="영업3팀">영업3팀</option>
		</select>
	</form>

	<input type="button" value="수정" id="updateBtn" />
	<input type="button" value="목록" id="listBtn" />
</body>
</html>