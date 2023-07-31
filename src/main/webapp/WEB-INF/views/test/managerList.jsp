<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	border-collapse: collapse;
}

th, td {
	border: 1px solid #000;
	padding: 5px;
}

#insertBtn{
border : 1px solid #595959;
background-color: orange;
}

#pagingWrap span{
	cursor : pointer;
}
#paging
</style>

<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>

<script type="text/javascript">
$(document).ready(function() {
	
	if("${param.searchGbn}" != ""){ //검색 구분이 넘어오면(구분이 유지가 됨(중요!!!))
		$("#searchGbn").val("${param.searchGbn}");
	}
	
	$("tbody").on("click","tr", function() {
		$("#no").val($(this).attr("no"));
		
		$("#goForm").attr("action", "managerDetail");
		$("#goForm").submit();
	});
	
	$("#pagingWrap").on("click", "span", function() {
		$("#page").val($(this).attr("page")); //page속성으로 이동할 번호를 지정(목적지)
		
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#goForm").attr("action", "managerList");
		$("#goForm").submit();
	});
	
	$("#searchBtn").on("click", function() {
		$("#page").val("1");//페이지 초기화(검색을 하게되면 맨 1페이지로 이동)
		
		$("#goForm").attr("action","managerList");
		$("#goForm").submit();
		
	});
	
	$("#insertBtn").on("click", function() {
		location.href="managerInsert";/*주소 이동은 컨틀롤러*/
	});
});
</script>
</head>
<body>
	
	<input type="hidden" id="oldGbn" value="${param.searchGbn}">
	<input type="hidden" id="oldTxt" value="${param.searchTxt}">

	<form action="#" id="goForm" method="post">
		<input type="hidden" id="no" name="no"/>
		<input type="hidden" id="page" name="page" value="${page}"/>
		
		<!-- 검색구분 -->
		<select name="searchGbn" id="searchGbn">
			<option value="0">성함</option>
			<option value="1">부서</option>
		</select>
		
		<!-- 검색어 -->
		<!-- value="${param.searchTxt} : 검색어 유지되게 하려고 -->
		<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}">
		
		<!-- 검색버튼 -->
		<input type="button" value="검색" id="searchBtn"/>
		
	
	</form>
	
	
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>성함</th>
				<th>부서</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="data" items="${list}">
			<!-- db는 컬럼명을 대문자로 넘겨주기 때문에 대문자로 불러와야함!!! -->
					<!-- data는 list에 인덱스이고 map에 든거를 출력하면 됨. -->
				<tr no="${data.EMP_NO}">
					<td>${data.EMP_NO}</td>
					<td>${data.NAME}</td>
					<td>${data.DEPT}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<br/>
	<input type="button" value="추가" id="insertBtn"/>
	
	<div id="pagingWrap">
		<span page="1">처음</span>
		
		<!-- 이전 페이지 : 현재 페이지가 1이면 1로 이동하고, 1페이지가 아니면 (현재페이지-1) -->
		<c:choose>	
			<c:when test="${page eq 1}">
				<span page="1">이전</span>
			</c:when>
			<c:otherwise>
				<span page="${page -1}">이전</span>
			</c:otherwise>
		</c:choose>
		
		<!-- 페이지들(pagingService에 getPagingData()를 보면 뭔지 알거다) -->
		<c:forEach var="i" begin="${pd.startP}" end="${pd.endP}" step="1">
			
			<c:choose>
				<c:when test="${i eq page}">
					<%-- 현재 페이지 --%>
					<span page="${i}">
						<b style="color: red;">${i}</b>
					</span>
				</c:when>
				
				<c:otherwise>
					<%-- 다른 페이지 --%>
					<span page="${i}">${i}</span>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 다음 페이지는 마지막에 도달했을 때는 증가하지 않고, 마지막 페이지가 아니면 +1 -->
		<c:choose>
			<c:when test="${page eq pd.maxP}">
				<span page="${pd.maxP}">다음</span>
			</c:when>
			
			<c:otherwise>
				<span page="${page+1}">다음</span>
			</c:otherwise>
		</c:choose>
		
		<span page="${pd.maxP}">마지막</span>
	</div>
</body>
</html>