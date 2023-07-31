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
	margin: 10px 0;
	border-collapse: collapse;
	display: inline-block;
	text-align: center;
}

td {
	border-bottom: 1px solid #000;
	padding: 5px;
}

thead tr {
	border-top: 2px solid #222222;
	border-bottom: 1px solid #031027;
	height: 40px;
	font-size: 11pt;
	background-color : #009999;
}

tbody tr {
	font-size: 11pt;
}

.table_box{
	text-align: center;
	border: red 1px solid;
	padding: 30px 0;
}

input[type="button"]{
	cursor:  pointer;
}
h3{
	display: inline-block;
}


</style>

<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>

<script type="text/javascript">
$(document).ready(function() {
	
	$("#insertBtn").on("click", function() {
		location.href="insertMemberPage";
	});
	
	$("tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		$("#actionForm").attr("action", "memberDetail");
		$("#actionForm").submit();
	});
	
	$("tbody tr").hover(function(){
	    $(this).css('color','#cc00cc');
	    $(this).css('cursor','pointer');
	}, function() {
		$(this).css('color','#000');
	});
	
	$("#pagingWrap").on("click", "span" , function() {
			
		$("#page").val($(this).attr("page"));
		
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action", "memberList");

		$("#actionForm").submit();
		
	});
	
	$("#searchBtn").on("click", function() {
		$("#page").val("1");//페이지 초기화(검색하면 1페이지부터 시작)
		
		$("#actionForm").attr("action", "memberList");
		$("#actionForm").submit();
	});
});
</script>

</head>
<body>

	<div class="table_box">
		<h3>회원목록</h3>
		
		<form action="#" id="actionForm" method="post">
			<input type="hidden" id="no" name="no"/>
			
			<!-- DB에서 넘어옴, page는 상세보기, 수정, 삭제, 조회 가지고 다닌다.(등록x) -->
			<input type="hidden" id="page" name="page" value="${page}"/>
			 
			 <!-- 검색구분 -->
			 <select name="searchGbn" class="searchGbn" id="searchGbn">
			 	<option value="0">아이디</option>
			 	<option value="1">이름</option>
			 </select>
			 
			 <!-- 검색어 -->
			 <input type="text" name="searchTxt" id="searchTxt" class="searchTxt"/>
			 
			 <!-- 검색버튼 -->
			 <input type="button" value="검색" id="searchBtn"/>
		</form>

	
		<!-- 번호, 아이디, 이름, 등록일,( DEL = 1인것만 조회 ) -->
		<table>
			<colgroup>
				<col width="100">
				<col width="200">
				<col width="200">
				<col width="150">
			</colgroup>
			
			<thead>
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>등록일</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="data" items="${list}">
					<tr no="${data.MEM_NO}">
						<td>${data.MEM_NO}</td>
						<td>${data.MEM_ID}</td>
						<td>${data.MEM_NM}</td>
						<td>${data.REG_DT}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<br/>
		<input type="button" value="추가" id="insertBtn" class="insertBtn"/>
		
		<div id="pagingWrap">
			<span page="1">
				처음
			</span>
			
			<c:choose>
				<c:when test="${page eq 1}">
					<span page="1">이전</span>
				</c:when>
				<c:otherwise>
					<span page="${page -1}">이전</span>
				</c:otherwise>
			</c:choose>
			
			<!-- 페이지들 -->
			<c:forEach var="i" begin="${pd.startP}" end="${pd.endP}" step="1">
				<c:choose>
					<c:when test="${i eq page}">
						<span page="${i}" style="color: red;">
							${i}
						</span>
					</c:when>
					
					<c:otherwise>
						<span page="${i}">
							${i}
						</span>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<!-- 다음 페이지가 마지막에 도달했을 때는 증가하지 않고, 마지막 페이지가 아니면 +1 -->
			<c:choose>
				<c:when test="${page eq pd.maxP}">
					<span page="${pd.maxP}">다음</span>
				</c:when>
				<c:otherwise>
					<span page="${page +1}">다음</span>
				</c:otherwise>
			</c:choose>
			
			<span page="${pd.maxP}">마지막</span>
		</div>
	</div>

</body>
</html>