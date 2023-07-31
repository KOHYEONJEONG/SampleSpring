<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결과값 받는 페이지</title>
<style type="text/css">
h3 {
	display: inline-block;
	padding: 20px 0;
	font-size: 14pt;
}
</style>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/script/jquery/jquery-1.12.4.min.js">
	//../를 붙여줘야지 컨트롤러가 인식함. or ${ pageContext.request.contextPath }
</script>
<script type="text/javascript">
$(document).ready(function() {
	switch ("${res}") {
		case "success":
			if("${flag}"=="u"){ //"${param.gbn}"=="u" <- 이 anboard는 gbn을 안씀!!(다른 테이블들은 썼지만, 다른 방법임!)
				$("#goForm").submit();
			}else{
				//등록, 삭제
				location.href="../anboardList";
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
	<form action="../anboardDetail" id="goForm" method="post">
		<!--(중요)전 화면에서 넘어온 페이지 정보(목록으로 돌아가더라도 페이지 상태값이 유지된다.)  -->
		<input type="hidden" name="page" value="${param.page}">
		
		<!--(중요) 밑2줄, 상세보기 다녀와도 검색어가 유지되도록 하기 위해서.(sellList.jsp와 유지되게) -->
		<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
		
		<!-- 전 화면에서 넘어오기 때문에 param붙여줌., 상세보기는 no가 있어야 조회가능함. -->
		<input type="hidden" name="no" value="${param.no}">
	</form>
</body>
</html>