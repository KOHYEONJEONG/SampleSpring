<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>

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
	width: 800px;
	text-align: right;
	margin: 0 auto;
}

.att{
	display: inline-block;
	vertical-align: top;
	width : 18px;
	height: 18px;
	background-image: url('resources/images/attFile.png');
	background-size: cover;
}

#cateNo{
      min-width: 100px;
      height: 30px;
      vertical-align: middle;
      border: 1px solid #d7d7d7;
      float: left;
}
</style>

<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>

<script type="text/javascript">
$(document).ready(function() {
	
	//검색구분 유지
	if("${param.searchGbn}" != ""){
		$("#searchGbn").val("${param.searchGbn}");
	}else{
		$("#oldGbn").val("0");//없으면 0으로 고정
	}
	
	//카테고리 설정
	if("${param.cateNo}"!=""){
		$("#cateNo").val("${param.cateNo}");
	}
	
	//카테고리가 변경됐을때 무언가를 하겠다.
	$("#cateNo").on("change", function() {
		//검색 및 페이징 초기화
		$("#page").val("1");
		$("#searchGbn").val("0");
		$("#searchTxt").val("");
		$("#oldGbn").val("0");
		$("#oldTxt").val("");
		
		//목록조회
		reloadList();
	});
	
	//목록조회
	reloadList();
	
	//검색버튼
	$("#searchBtn").on("click", function() {
		$("#page").val("1");
		
		// 신규 상태 등록(검색구분, 검색어 유지하려고)
		$("#oldGbn").val($("#searchGbn").val());
		$("#oldTxt").val($("#searchTxt").val());
		
		//목록을 다시 화면에 그렸으면 좋겠엉!
		reloadList();
	});
	
	//페이징버튼
	$(".paging_area").on("click", "span", function() {
		
		//기본 검색상태 유지(검색구분, 검색어 유지하려고)
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		//페이지 속성에 값을 서버에 보낸 page id에 담아서 보내기.
		$("#page").val($(this).attr("page"));
		
		reloadList();
	})
	
   // 등록 버튼
   $("#insertBtn").on("click", function() {
      // 기존 검색상태 유지      
      $("#searchGbn").val($("#oldGbn").val());
      $("#searchTxt").val($("#oldTxt").val());
      
      $("#actionForm").attr("action", "ATInsert");
      $("#actionForm").submit();      
   });

	
	//행을 누르면 상세보기로 이동~
	$("tbody").on("click", "tr", function() {
	      $("#no").val($(this).attr("no"));
	      
	      // 기존 검색상태 유지
	      $("#searchGbn").val($("#oldGbn").val());
	      $("#searchTxt").val($("#oldTxt").val());
	      
	      $("#actionForm").attr("action", "ATDetail");
	      $("#actionForm").submit();
	   });


});

function reloadList() {
	
	var params = $("#actionForm").serialize();
	
	$.ajax({
		url : "ATListAjax", //경로 
		type : "POST",    //전송방식(GET : 주소형태, POST : 주소 헤더 형태)
		dataType : "json",//데이터 형태
		data : params,
		success : function(res) {//성공했을 때 결과를 res에 받고 함수 실행
			
			//res는 list와 pd가 넘어온다.
			drawList(res.list);//실행하고 넘어온 것중에 list만 보내겠따.
			drawPaging(res.pd);//실행하고 넘어온 것중에 pd만 보내겠따.
			
		},
		error : function(request, status, error) {// 실패했을 때 함수 실행
			console.log(request.responseText);    //실패 상세 내역
		}
		
	});
}

function drawList(list) {
	//list가 넘어옴
	var html = "";
	
	for(var data of list){ //"++" : 숫자가 들어갈 자리에 넣어주면 됨.
		console.log(data.ATT != "undefined");
		html += "<tr no=\""+data.NO+"\">";//속성에 값을 
		html += "<th>"+data.NO+"</th>";
		
		html +="<td>";
		html += data.TITLE;
		if(typeof(data.ATT) != "undefined"){ //첨부파일이 있다면
			html+="<span class=\"att\"></span>";
		}
		html +="</td>";
		
		html += "<th>"+data.MEM_NM+"</th>";
		html += "<th>"+data.DT+"</th>";
		html += "<th>"+data.HIT+"</th>";
		html += "</tr>";
	}
	
	$("tbody").html(html);
}

function drawPaging(pd) {//비동기화 페이징
	
	var html = "";
	//ctrl + f
	
	html += "<span class=\"page_btn page_first\"  page=\""+1+"\">처음	</span>"; //처음은 무조건 1
	
	if($("#page").val() == "1"){ //이전페이지 page가 1이면 1, 아니면 page -1
		// 1이면 page = 1
		html += "<span class=\"page_btn page_prev\" page=\""+1+"\">이전</span>";
	}else{
		//아니면 page -1
		html += "<span class=\"page_btn page_prev\" page=\""+($("#page").val() * 1 - 1)+"\">이전</span>"; //(*1)을 해주면 문자로 받은 것을 숫자로 바뀜
	}

	
	for(var i = pd.startP; i<=pd.endP; i++){
		if($("#page").val()*1 == i){
			//현재 페이지
			html += "<span style=\"color:red;\" class=\"page_btn\" page=\""+i+"\">" + i+ "</span>";
		}else{
			//다른 페이지
			html += "<span class=\"page_btn\" page=\""+i+"\">" + i+ "</span>";
		}
	}
	
	//다음
	if($("#page").val() * 1 == pd.maxP){
		html += "<span class=\"page_btn page_next\" page=\""+pd.maxP+"\"> 다음 </span>";
	}else{
		html += "<span class=\"page_btn page_next\" page=\""+($("#page").val() * 1 + 1)+"\"> 다음 </span>";
	}
	
	
	//마지막 페이지
	html += "<span class=\"page_btn page_last\" page=\""+pd.maxP+"\"> 마지막 </span>";
	
	$(".paging_area").html(html);
	
}

</script>
</head>
<body>
	<c:import url="/testAHeader"/>
	
	<input type="hidden" id="oldGbn" value="${param.searchGbn}"> <!-- 기존 검색 유지용 보관 (검색구분)-->
	<input type="hidden" id="oldTxt" value="${param.searchTxt}"> <!-- 기존 검색 유지용 보관 (검색어)-->
	
	
	<div class="search_area">
		<form action="#" id="actionForm" method="post">
			<input type="hidden" id="no" name="no"/>
			<input type="hidden" name="page" id="page" value="${page}"/>
			
			<select id="cateNo" name="cateNo">
				<c:forEach var="data" items="${cate}">
					<option value="${data.CATE_NO}">${data.CATE_NM}</option>
				</c:forEach>
			</select>
			
			<select name="searchGbn" id="searchGbn">
				<option value="0">제목</option>	
				<option value="1">작성자</option>	
			</select>
			
			<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}"/>
			
			<div id="searchBtn" class="cmn_btn_ml">검색</div> 
			
			<c:if test="${!empty sMemNo}">
				<div class="cmn_btn_ml" id="insertBtn">등록</div>
			</c:if>
		</form>
	</div>
	
	
	<div class="board_area">
			<table class="board_table">
				
				
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
				</tbody>
			</table>
		
		<div class="paging_area">
		
		</div>
	</div>
	

	
</body>
</html>