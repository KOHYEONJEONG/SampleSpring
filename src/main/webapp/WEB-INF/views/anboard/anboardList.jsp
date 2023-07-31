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
* {
	margin: 0;
	padding: 0;
}

body {
	font-size: 0pt;
}

span{
	font-size: 14px;
	margin-right: 5px;
	border: 1px solid #595959;
	display: inline-block;
}

.table_box {
	padding: 30px 0;
    width: 100%;
    text-align: center;
}

.insertBtnBox{
	text-align:right;
	border: 1px solid red;
	width: 900px;
	margin: 0 auto;
}

table {
	border-collapse: collapse;
	display: inline-block;
}

thead tr {
	border-top: 2px solid #222222;
	border-bottom: 1px solid #031027;
	height: 40px;
	font-size: 11pt;
}

tbody tr {
	border-bottom: 1px solid #031027;
	font-size: 11pt;
}

th, td {
	padding: 5px;
}

th {
	background-color: #009999;
}

#pagingWrap{
	margin-top: 10px;
}

#pagingWrap span {
	cursor: pointer;
}

input[type="button"] {
	cursor: pointer;
	margin-top: 10px;
	border: 1px solid gray;
	width: 50px;
	height: 30px;
	line-height: 30px;
	background-color: #e0e0e0;
	box-sizing: border-box;
}

h3 {
	display: inline-block;
	padding: 20px 0;
	font-size: 14pt;
}

.searchGbn{
	width:  70px;
	height: 28px;
	margin-right: 5px;
	box-sizing: border-box;
}	

.searchTxt{
	height: 28px;
	box-sizing: border-box;
	margin-right: 5px;
}

</style>

<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function(){
	
	if("${param.searchGbn}" != ""){ //검색 구분이 넘어오면(구분이 유지가 됨(중요))
		$("#searchGbn").val("${param.searchGbn}");
	}
	
	$("#insertBtn").on("click", function() {
		
		//검색 상태 유지(검색버튼을 누르기 전까지 기존 내용들을 유지하려고 + 상세보기 갔다와도 유지, 페이징 버튼을 누르면 검색버튼을 누르지 않아도 검색어가 있으면 변경이되는 버그를 막기위해서)
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action", "anboardInsert");
		$("#actionForm").submit();
	});
	
	$("tbody").on("click","tr",function(){
		$("#no").val($(this).attr("no"));
		
		$("#actionForm").attr("action","anboardDetail");
		$("#actionForm").submit();
	});
	
	/*hover와 mouseover*/
	$("tbody tr").hover(function(){
	    $(this).css('color','#cc00cc');
	    $(this).css('cursor','pointer');
	}, function() {
		$(this).css('color','#000');
	});
	
	$("#pagingWrap").on("click","span", function() {
		//list에서 list로 이동하려고		
		$("#page").val($(this).attr("page"));
		
		//검색 상태 유지(검색버튼을 누르기 전까지 기존 내용들을 유지하려고 + 상세보기 갔다와도 유지, 페이징 버튼을 누르면 검색버튼을 누르지 않아도 검색어가 있으면 변경이되는 버그를 막기위해서)
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action", "anboardList");
		$("#actionForm").submit();
	});
	
	$("#searchBtn").on("click", function() {
		//검색을하게되면 결과값이 1페이지에 나타나지?
		$("#page").val("1");//페이지 초기화
		
		$("#actionForm").attr("action", "anboardList");
		$("#actionForm").submit();
	});
	
});


</script>
</head>

<body>
	
	<input type="hidden" id="oldGbn" value="${param.searchGbn}"> <!-- 기존 검색 유지용 보관 (검색구분)-->
	<input type="hidden" id="oldTxt" value="${param.searchTxt}"> <!-- 기존 검색 유지용 보관 (검색어)-->
	
	
	<div class="table_box">
		<h3>구디 익명게시판</h3>
		
		<div class="insertBtnBox">	
			<input type="button" id="insertBtn" class="insertBtn" value="추가" />
		</div>
		
		<table>
			<colgroup>
				<col width="100">
				<col width="400">
				<col width="150">
				<col width="150">
				<col width="100">
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
				<c:forEach var="data" items="${list}">
					<%-- 번호, 제목, 작성자, 조회수, 작성일  --%>
					<tr no="${data.NO}">
						<td>${data.NO}</td>
						<td>${data.TITLE}</td>
						<td>${data.WRITER}</td>
						<td>${data.DT}</td>

						<c:choose>
							<c:when test="${empty data.HIT}">
								<td>0</td>
							</c:when>

							<c:otherwise>
								<td>${data.HIT}</td>
							</c:otherwise>
						</c:choose>

					</tr>
				</c:forEach>
			</tbody>

		</table>

		<form action="#" id="actionForm" method="post">
			<input type="hidden" id="no" name="no" />
	
			<!-- page는 상세보기,수정,삭제,조회 가지고 다님.(등록x) -->
			<input type="hidden" id="page" name="page" value="${page}"/>
			
			<!-- 검색구분 -->
			<select name="searchGbn" id="searchGbn" class="searchGbn">
				<option value="0">제목</option>
				<option value="1">작성자</option>
				<option value="2">작성일</option>
			</select>
			
			<!-- 검색어 -->
			<input type="text" name="searchTxt" id="searchTxt" class="searchTxt" value="${param.searchTxt}">
			
			
			<!-- 검색버튼 -->
			<input type="button" value="검색" id="searchBtn"/>
		
		</form>

		

		<!-- 페이징 수(UI) : 컨트롤러에서 받아서 불러오면 됨. -->
		<div id="pagingWrap">
			<span page="1"> 처음 <!-- 처음버튼은 무조건 1페이지로 이동 -->
			</span>

			<!-- 이전 페이지 : 현재 페이지가 1이면 1로 이동, 1페이지가 아니면(현재페이지 -1) -->
			<c:choose>
				<c:when test="${page eq 1}">
					<span page="1">이전</span>
				</c:when>

				<c:otherwise>
					<span page="${page -1}">이전</span>
				</c:otherwise>
			</c:choose>

			<!-- 페이지들(pagingService에서 getPagingData()를 보면 알거임. -->
			<c:forEach var="i" begin="${pd.startP}" end="${pd.endP}" step="1">
				<c:choose>
					<c:when test="${i eq page}">
						<%-- 현재 페이지 --%>
						<span page="${i}" style="color: red;"> ${i} </span>
					</c:when>
					<c:otherwise>
						<span page="${i}"> ${i} </span>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<!-- 다음 페이지가 마지막에 도닥했을 때는 증가하지 않고, 마지막 페이지가 아니면 +1 -->
			<c:choose>
				<c:when test="${page eq pd.maxP}">
					<span page="${pd.maxP}"> 다음 </span>
				</c:when>

				<c:otherwise>
					<span page="${page +1}"> 다음 </span>
				</c:otherwise>
			</c:choose>

			<span page="${pd.maxP}"> 마지막 </span>
		</div>
	</div>
</body>
</html>