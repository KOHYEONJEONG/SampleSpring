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

#pagingWrap span{
	cursor : pointer;
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
	
	   $("tbody").on("click","tr",function(){
		  console.log($(this).attr("no"));
	      
	      $("#no").val($(this).attr("no"));/*tr값을 hidden타입을 가진 id=no에 담기 위해서*/
	      
	      $("#actionForm").attr("action" , "sellDetail");//클릭했을때 주소 변경됨.
	      $("#actionForm").submit();
	   });
	   
	   
		$("#insertBtn").on("click" , function() {
			location.href="sellInsert";//주소가 새로 생기면 controller로 가서 작성해야함.	 	
		});
		
		
		$("#pagingWrap").on("click", "span" , function() {
			//list에서 list로 이동
			$("#page").val($(this).attr("page"));//page속성으로 이동할 번호를 지정(목적지)
			
			//검색 상태 유지(검색버튼을 누르기 전까지 기존 내용들을 유지하려고 + 상세보기 갔다와도 유지, 페이징 버튼을 누르면 검색버튼을 누르지 않아도 검색어가 있으면 변경이되는 버그를 막기위해서)
			$("#searchGbn").val($("#oldGbn").val());
			$("#searchTxt").val($("#oldTxt").val());
			
			$("#actionForm").attr("action", "sellList");
			$("#actionForm").submit();
		});
		
		$("#searchBtn").on("click", function() {
			//검색을하게되면 결과값이 1페이지에 나타나지?
			$("#page").val("1");//페이지 초기화
			
			$("#actionForm").attr("action", "sellList");
			$("#actionForm").submit();
		});
		
		
});
	
</script>

</head>
<body>
	<%--TestController에서 받아옴(메소드는 sellLisT()) --%>
	<input type="hidden" id="oldGbn" value="${param.searchGbn}"> <!-- 기존 검색 유지용 보관 (검색구분)-->
	<input type="hidden" id="oldTxt" value="${param.searchTxt}"> <!-- 기존 검색 유지용 보관 (검색어)-->

	<form action="#" id="actionForm" method="post">
		<input type="hidden" id="no" name="no"/>
		<!-- page는 상세보기,수정,삭제,조회 가지고 다님.(등록x) -->
		<input type="hidden" id="page" name="page" value="${page}"/>
		
		<!-- 검색구분  -->
		<select name="searchGbn" id="searchGbn">
			<option value="0">품목</option>
			<option value="1">수량</option>
		</select>
		
		<!-- 검색어-->
		<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}"/> <!-- value="${param.searchTxt} : 검색어 유지되게 하려고 -->
		
		<!-- 검색버튼 -->
		<input type="button" value="검색" id="searchBtn"/>
		
		<!-- 게시글 추가버튼 -->
		<input type="button" value="추가" id="insertBtn"/>
		
	</form>
	<br/>
	
	<table>
		<thead>
			<colgroup>
				<col width="100">
				<col width="400">
				<col width="100">
				<col width="150">
			</colgroup>
		
			<tr>
				<th>판매번호</th>
				<th>품목</th>
				<th>수량</th>
				<th>일자</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach var="data" items="${list}">
			<!-- db는 컬럼명을 대문자로 넘겨주기 때문에 대문자로 불러와야함!!! -->
				<!-- data는 list에 인덱스이고 map에 든거를 출력하면 됨. -->
				<tr no="${data.SELL_NO}">
					<td>${data.SELL_NO}</td>
					<td>${data.ITEM_NAME}</td>
					<td>${data.COUNT}</td>
					<td>${data.SELL_DT}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

<!-- 페이징 수(UI), 컨트롤러에서 받아서 불러오면 됨. -->	
<div id="pagingWrap">
	<span page="1">
		처음 <!-- 처음버튼은 무조건 1페이지로 이동 -->
	</span>
	
	<!-- 이전 페이지 : 현재 페이지가 1이면 1로 이동하고, 1페이지가 아니면 (현재페이지 -1) -->
	<c:choose>
		<c:when test="${page eq 1}">
			<span page="1">이전</span>
		</c:when>
		<c:otherwise>
			<span page="${page -1}">이전</span>
		</c:otherwise>
	</c:choose>
	
	<!-- 페이지들(pagingService에서 getPagingData()를 보면 알거임.-->
	<c:forEach var="i" begin="${pd.startP}" end="${pd.endP}" step="1">
		<%-- 현재 페이지의 경우 별도 처리 --%>
		<c:choose>
			<c:when test="${i eq page}">
				<%-- 현재 페이지 --%>
				<span page="${i}"><b style="color: red;">${i}</b> </span>
			</c:when>
			<c:otherwise>
				<%-- 다른 페이지 --%>
				<span page="${i}">${i}</span>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	
	<!-- 다음 페이지가 마지막에 도달했을 때는 증가하지 않고, 마지막 페이지가 아니면 +1  -->
	<c:choose>
		<c:when test="${page eq pd.maxP}">
			<span page="${pd.maxP}">다음</span>
		</c:when>
		
		<c:otherwise>	
			<span page="${page +1}">다음</span>			
		</c:otherwise>
	</c:choose>

	<!-- 맨 마지막으로 이동 -->
	<span page="${pd.maxP}">마지막</span>
</div>
	
</body>
</html>