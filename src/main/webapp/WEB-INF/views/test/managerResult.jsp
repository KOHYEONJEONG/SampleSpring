<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>manager 테이블의 DML언어에 성공 결과를 받아 페이지 이동</title>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function() {//html보다 먼저 실행 되면 안됨(수정 후 상세보기로 넘어올려고)
							 //($(document).ready가 없으면 위에서부터 순서대로 실행되기떄문에)
	//el tag를 script에서 사용하려면
	//해당 위치에 값이 그대로 들어가기 때문에 보편적으로 ""(쌍따움표)를 달아서 문자열로 인식시킨 뒤 사용
	
	switch("${res}"){
		case "success":
			if("${param.gbn}" == "u"){
				$("#goForm").submit();
			}else{
				//등록, 삭제 성공 시
				location.href="managerList";
			}
			break;
		case "failed" :
			   alert("작업에 실패하였습니다.");
			   history.back();
		   break;
		case "error" :
			   alert("작업중 문제가 발생 하였습니다.");
			   history.back();
		   break;
	}
});
</script>

</head>
<body>
	<!-- 수정 후 상세보기 페이지로 넘어가기전에 no를 가져가야 함. -->
	<form action="managerDetail" id="goForm" method="post">
		
		<!-- 전 화면에서 넘어오기 때문에 param 붙여줌. -->
		<input type="hidden" name="no" value="${param.no}"/>
		
		<!-- 전 화면에서 넘어온 페이지 정보(목록으로 돌아가더라도 페이지 상태값이 유지된다.)  -->
		<input type="hidden" name="page" value="${param.page}">
		
		<!--(중요) 밑2줄, 상세보기 다녀와도 검색어가 유지되도록 하기 위해서.(sellList.jsp와 유지되게) -->
		<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
	</form>
	
</body>
</html>