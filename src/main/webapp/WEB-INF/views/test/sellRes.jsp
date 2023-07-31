<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결과에 따라 페이지이동하는 jsp</title>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function() {//html보다 먼저 실행 되면 안됨(수정 후 상세보기로 넘어올려고)
	                          //($(document).ready가 없으면 위에서부터 순서대로 실행되기떄문에)
	// el tag를 script에서 사용 시
	// 해당 위치에 값이 그대로 들어가기 떄문에 보편적으로 "" 를 달아서 문자열로 인식시킨 뒤 사용
	switch("${res}") {
		case "success" :
				if("${param.gbn}"=="u"){// 수정이 성공 했을 때(수정후 상세보기 가려고)
					$("#goForm").submit();						
				}else{
					//등록, 삭제가 성공했을 때
			   		location.href = "sellList";
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
<!-- 수정버튼을 누르면 goForm으로 오고 sellDetail 컨트롤러를 찾아서 상세보기 페이지로 이동한다.(왜? 상세보기 페이지는 no가 필요하기 때문이다) -->
<form action="sellDetail" id="goForm" method="post">

	<!--(중요)전 화면에서 넘어온 페이지 정보(목록으로 돌아가더라도 페이지 상태값이 유지된다.)  -->
	<input type="hidden" name="page" value="${param.page}">
	
	<!--(중요) 밑2줄, 상세보기 다녀와도 검색어가 유지되도록 하기 위해서.(sellList.jsp와 유지되게) -->
	<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
	<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
	
	<!-- 전 화면에서 넘어오기 때문에 param붙여줌. 상세보기는 no가 있어야 조회가능함 -->
	<input type="hidden" name="no" value="${param.no}">
	
</form>
</body>
</html>