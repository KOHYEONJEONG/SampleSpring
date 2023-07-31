<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sync Board Test</title>
<link rel="shortcut icon" href="resources/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<style type="text/css">
.search_area {
	width: 700px;
	text-align: right;
	margin: 0 auto;
}

.board_area {
	width: 700px;
	margin: 0 auto;
}
</style>
<!-- jQuery Script -->
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
		src="resources/script/common/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("tbody").on("click","tr",function(){
		$("#boardNo").val($(this).attr("id"));
		$("#sendForm").attr("action", "syncDetail");
		$("#sendForm").submit();
	});
	
	$("#searchBtn").on("click", function(){
		$("[name='searchGbn']").val($("#searchGbn").val());
		$("[name='searchText']").val($("#searchText").val());
		$("[name='page']").val(1);
		$("#sendForm").attr("action", "syncList");
		$("#sendForm").submit();
	});
	
	$(".paging_area").on("click", "span", function(){
		$("[name='page']").val($(this).attr("name"));
		$("#sendForm").attr("action", "syncList");
		$("#sendForm").submit();
	});
	
	$("#writeBtn").on("click", function(){
		$("#sendForm").attr("action", "syncWrite");
		$("#sendForm").submit();
	});
});
</script>
</head>
<body>
<form action="#" method="post" id="sendForm">
	<input type="hidden" name="boardNo" id="boardNo" />
	<input type="hidden" name="page" value="${page}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchText" value="${param.searchText}" />
</form>
<div class="cmn_title">동기화 게시판 샘플<div class="cmn_btn_mr float_right_btn" id="sampleListBtn">샘플목록</div></div>
<div class="search_area">
	<select id="searchGbn">
		<c:choose>
			<c:when test="${param.searchGbn eq 0}">
				<option value="0" selected="selected">제목</option>
			</c:when>
			<c:otherwise>
				<option value="0">제목</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${param.searchGbn eq 1}">
				<option value="1" selected="selected">작성자</option>
			</c:when>
			<c:otherwise>
				<option value="1">작성자</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${param.searchGbn eq 2}">
				<option value="2" selected="selected">제목+작성자</option>
			</c:when>
			<c:otherwise>
				<option value="2">제목+작성자</option>
			</c:otherwise>
		</c:choose>
	</select>
	<input type="text" id="searchText" value="${param.searchText}" placeholder="검색" />
	<div class="cmn_btn_ml" id="searchBtn">검색</div>
	<div class="cmn_btn_ml" id="writeBtn">글쓰기</div>
</div>
<div class="board_area">
	<table class="board_table">
		<colgroup>
			<col width="100"/>
			<col width="400"/>
			<col width="150"/>
			<col width="150"/>
			<col width="100"/>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${list}" varStatus="status">
				<tr id="${data.BOARD_NO}" class="a">
					<td>${data.BOARD_NO}</td>
					<td class="board_table_hover board_cont_left">${data.TITLE}</td>
					<td>${data.WRITER}</td>
					<td>${data.WRITE_DATE}</td>
					<td>${data.HIT_CNT}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="paging_area">
		<span class="page_btn page_first" name="1">처음</span>
		<c:choose>
			<c:when test="${page eq 1}">
				<span class="page_btn page_prev" name="1">이전</span>
			</c:when>
			<c:otherwise>
				<span class="page_btn page_prev" name="${page - 1}">이전</span>
			</c:otherwise>
		</c:choose>
		
		<c:forEach var="i" begin="${pd.startP}" end="${pd.endP}" step="1">
			<c:choose>
				<c:when test="${i eq page}">
					<span class="page_btn_on" name="${i}">${i}</span>
				</c:when>
				<c:otherwise>
					<span class="page_btn" name="${i}">${i}</span>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:choose>
			<c:when test="${page eq pd.maxP}">
				<span class="page_btn page_next" name="${pd.maxP}">다음</span>
			</c:when>
			<c:otherwise>
				<span class="page_btn page_next" name="${page + 1}">다음</span>
			</c:otherwise>
		</c:choose>
		<span class="page_btn page_last" name="${pd.maxP}">맨끝</span>
	</div>
</div>
</body>
</html>