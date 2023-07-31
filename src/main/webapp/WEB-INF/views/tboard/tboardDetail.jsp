<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<style type="text/css">
table {
	border-collapse: collapse;
}

th, td {
	border: 1px solid #000;
	padding: 5px;
}

#pagingWrap span {
	cursor: pointer;
}

input[type="button"] {
	cursor: pointer;
}

h3 {
	background-color: silver;
	display: inline-block;
}
</style>

<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function() {
	$("#listBtn").on("click", function() {
		$("#actionForm").attr("action","tBoardList");
		$("#actionForm").submit();
	});	
	
	$("#deleteBtn").on("click", function() {
		if(confirm("삭제하시겠습니까??")){
			$("#actionForm").attr("action","TAction");
			$("#actionForm").submit();
		}
	});
	
	$("#udpateBtn").on("click", function() {
		//수정 페이지로 이동
		$("#actionForm").attr("action","tBoardUpdate");
		$("#actionForm").submit();
	});
});
</script>
</head>
<body>
	<form action="#" id="actionForm" method="post">
	
		<input type="hidden" name="gbn" value="d"/>
		
		 <input type="hidden" name="no" value="${data.NO}" />
		 
		 <!--(중요)전 화면에서 넘어온 페이지 정보(목록으로 돌아가더라도 페이지 상태값이 유지된다.)  -->
		<input type="hidden" name="page" value="${param.page}">
		
		<!--(중요) 밑2줄, 상세보기 다녀와도 검색어가 유지되도록 하기 위해서.(sellList.jsp와 유지되게) -->
		<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
		 
	</form>

	<table>
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
			<td>${data.DT}</td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td>
				${data.CON}
			</td>
		</tr>

		<tr>
			<th>조회수</th>
			<c:choose>
				<c:when test="${empty data.HIT}">
					<td>0</td>
				</c:when>

				<c:otherwise>
					<td>${data.HIT}</td>
				</c:otherwise>
			</c:choose>
		</tr>

		<tr>
			<th>작성일</th>
			<td>${data.DT}</td>
		</tr>
	</table>

	<c:if test="${sMemNo eq data.MEM_NO}">
		<input type="button" value="수정" id="udpateBtn">
		<input type="button" value="삭제" id="deleteBtn">
	</c:if>
	
	<input type="button" value="목록" id="listBtn">
</body>
</html>