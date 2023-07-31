<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록(Ajax)</title>
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css"/>
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css"/>
<script type="text/javascript" src="resources/script/common/popup.js"></script>

<style type="text/css">
#searchTxt{
	width: 161px;
	height: 28px;
	padding: 0 2px;
	text-indent: 5px;
	vertical-align: middle;
	border: 1px solid #d7d7d7;
	outline-color: #70adf9;
}

.board_area{
	width: 800px;
	margin: 0 auto;
}

.search_area{
	padding-top : 30px;
	width: 800px;
	text-align: right;
	margin: 0 auto;
}
</style>

<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>

<script type="text/javascript">
$(document).ready(function() {
	if("${param.searchGbn}" != ""){
		$("#searchGbn").val("${param.searchGbn}");
	}
	
	
	//목록조회
	reloadList();
	
	//검색버튼
	$("#searchBtn").on("click", function() {
		$("#page").val("1");
		
		//신규 상태 등록(검색구분, 검색어 유지하려고)
		$("#oldGbn").val($("#searchGbn").val());
		$("#oldTxt").val($("#searchTxt").val());
		
		//목록조회
		reloadList();
	});
	
	
	//페이징 버튼
	$(".paging_area").on("click","span", function() {
		
		//기본 검색 상태 유지(검색구분, 검색어 유지)
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#page").val($(this).attr("page"));
		
		reloadList();
	});
	
	//검색 버튼
	$("#searchBtn").on("click", function() {
		$("#page").val("1");
		
		//신규 상태 등록(검색구분, 검색어 유지하려고)
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#page").val($(this).attr("page"));
		
		//목록조회
		reloadList();
	});
	
	//등록버튼
	$("#insertBtn").on("click", function() {
		
		//기존 검색 상테
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action", "AMInsert");
		$("#actionForm").submit();
	});
	
	//행을 누르면 상세보기로 이동!
	$("tbody").on("click","tr", function() {
		$("#no").val($(this).attr("no"));
		
		//기존 검색상태 유지
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action", "AMDetail");
		$("#actionForm").submit();
	});
	
	
});
function reloadList() {
	var params = $("#actionForm").serialize();
	
	$.ajax({
		url : "AMListAjax", //경로
		type : "POST",
		dataType:"json",
		data:params,
		success : function(res) {
			drawList(res.list);
			drawPaging(res.pd);
		},
		error : function(request, status, error) {// 실패했을 때 함수 실행
			console.log(request.responseText);    //실패 상세 내역
		}
		
	});
}


function drawList(list) {//list가 넘어옴
	var html = ""; 
	
	for(var data of list){
		html += "<tr no=\""+data.MEM_NO+"\">";
		html += "<th>"+data.MEM_NO+"</th>";
		html += "<th>"+data.MEM_ID+"</th>";
		html += "<th>"+data.MEM_NM+"</th>";
		html += "<th>"+data.REG_DT+"</th>";
		html += "</tr>";
	}
	
	$("tbody").html(html);
}

function drawPaging(pd) {
	var html = "";
	
	html += "<span class=\"page_btn page_first\" page=\""+1+"\">이전</span>";
	
	if($("#page").val() == "1"){
		html += "<span class=\"page_btn page_prev\" page=\""+1+"\">이전</span>";
	}else{
		html += "<span class=\"page_btn page_prev\" page=\""+($("#page").val()*1 -1)+"\">이전</span>";
	}
	
	for(var i=pd.startP; i<=pd.endP; i++){
		if($("#page").val()*1 == i){
			html += "<span style=\"color:red;\" class=\"page_btn\" page=\""+i+"\">"+i+"</span>"
		}else{
			html += "<span class=\"page_btn\" page=\""+i+"\">"+i+"</span>"
		}
	}
	
	//다음
	if($("#page").val()*1 == pd.maxP){
		html += "<span class=\"page_btn page_next\" page=\""+pd.maxp+"\">다음</span>";
	}else{
		html += "<span class=\"page_btn page_next\" page=\""+($("#page").val()*1+1)+"\">다음</span>";
	}
	
	//마지막 페이지
	html += "<span class=\"page_btn page_last\" page=\""+pd.maxP+"\">마지막</span>";
	
	$(".paging_area").html(html);
	
}
</script>

</head>
<body>
	
	<input type="hidden" id="oldGbn" value="${param.searchGbn}"> <!-- 기존 검색 유지용 보관 (검색구분)-->
	<input type="hidden" id="oldTxt" value="${param.searchTxt}"> <!-- 기존 검색 유지용 보관 (검색어)-->
	
	<div class="search_area">
		<form action="#" id="actionForm" method="post">
			<input type="hidden" name="page" id="page" value="${page}"/>
			<input type="hidden" id="no" name="no"/> 
			
			<!-- 검색구분 -->
			<select name="searchGbn" class="searchGbn" id="searchGbn">
				<option value="0">아이디</option>
				<option value="1">이름</option>
			</select>
			
			<!-- 검색어 -->
			<input type="text" name="searchTxt" id="searchTxt"/> 
			
			<!-- 검색버튼 -->
			<div class="cmn_btn_ml" id="searchBtn">검색</div>
			
			<!-- 로그인한 사람만 등록버튼 -->
			<div class="cmn_btn_ml" id="insertBtn">등록</div>
		</form> 
	</div>	
	
	
		<!-- 번호, 아이디, 이름, 등록일, DEL  -->
	<div class="board_area">
		<table class="board_table">
			
			<thead>
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>등록일</th>
				</tr>
			</thead>
			
			<tbody>
				<!-- c:foreach 필요 없음. ajax에서 처리함. -->
			</tbody>
		</table>
		
		<div class="paging_area">
		</div>
	
		<br/>
		<div style="font-size: 14px">게시판 =><a href="ATList">TBOARD List</a></div>
	</div>
	
	
</body>
</html>