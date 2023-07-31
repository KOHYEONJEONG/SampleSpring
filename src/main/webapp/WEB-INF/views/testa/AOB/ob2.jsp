<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<!-- jstl은 자바 라이브러리 이다. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Common css -->
<link rel="stylesheet" type="text/css"
	href="resources/css/common/cmn.css" />
<!-- Popup css -->
<link rel="stylesheet" type="text/css"
	href="resources/css/common/popup.css" />
<!-- jQuery -->
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<!-- Popup JS -->
<script type="text/javascript" src="resources/script/common/popup.js"></script>
<!-- SlimScroll -->
<script type="text/javascript"
	src="resources/script/jquery/jquery.slimscroll.js"></script>

<style type="text/css">
.wrap {
	width: 800px;
	margin: 0 auto;
}

.mtb {
	margin: 5px 0px;
}

.login {
	vertical-align: baseline;
}

.con {
	width: calc(100% - 22px);
	height: 60px;
	border: 1px solid #d7d7d7;
	resize: none;
	padding: 10px;
}

.update {
	display: none;
}

.con_td {
	font-size: 0;
}

.paging_area {
	display: block;
	position: relative;
	left: 0;
	margin-bottom: 10px;
}

.search_area {
	text-align: center;
}

body {
	overflow: auto;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	
	reloadList();//전제조회

});

function reloadList() {
	//serialize(): 해당 내용물들 중 전달이 가능한 것들이 전송가능한 문자 형태로 전환
	var params = $("#searchForm").serialize();
	
	$.ajax({
		url : "list",
		type : "POST",
		dataType : "json",
		data : params,
		success : function(res) {
			drawList(res.list);
			drawPaging(res.pd);
		},
		error : function(request, status, error) {
			console.log(request.responseText);
		}
	});//ajax
}

function drawList(list) {
	var html = "";
	
	for(var data of list){
		html += "<tr no=\"1\"> ";
		html += "<td>홍길동</td>";
		html += "<td>테스트</td>";
		html += "<td>10:16</td>";
		html += "<td>";
		
		if("${sMemNo}" == data.MEM_NO){
			html += "<div class=\"cmb_btn mtb\">수정</div><br/>";
			
			html += "<div class=\"cmb_btn mtb\">삭제</div>";
		}
		html += "</td>";
		html += "</tr>";
	}
	
	$("tbody").html(html);
}
</script>
</head>
<body>
	<c:import url="/testHeader"></c:import>

	<div class="wrap">
		<div class="board_area">
			<table class="board_table">
				<colgroup>
					<col width="100" />
					<col width="500" />
					<col width="100" />
					<col width="100" />
				</colgroup>

				<thead>
					<c:choose>
						<c:when test="${empty sMemNo}">
							<!-- 비 로그인 시 -->
							<tr>
								<th colspan="4">로그인이 필요한 서비스 입니다.
									<div class="cmn_btn mtb login" id="loginBtn">로그인</div>
								</th>
							</tr>
						</c:when>

						<c:otherwise>
							<!-- 로그인이 되어 있다면 -->
							<tr>
								<th>${sMemNm}</th>
								<!-- 쿠키에 세션을 담겨 있다면 나옴. -->
								<td colspan="2" class="con_td">
									<form action="#" id="actionForm">
										<input type="hidden" name="no" id="no" /> <input type="hidden"
											name="memNo" value="${sMemNo}" />
										<textarea class="con" name="con" id="con"></textarea>
									</form>
								</td>

								<th>
									<div class="insert">
										<div class="cmn_btn" id="insertBtn">등록</div>
									</div>

									<div class="update">
										<div class="cmn_btn mtb" id="updateBtn">수정</div>
										<div class="cmn_btn mtb" id="cancelBtn">취소</div>
									</div>
								</th>
							</tr>
						</c:otherwise>
					</c:choose>

					<tr>
						<th>작성자</th>
						<th>내용</th>
						<th>작성일</th>
						<th>&nbsp;</th>
						<!-- 버튼이 들어갈 자리여서 빈공백(&nbsp; 디자이너들이 원함) -->
					</tr>
				</thead>

				<tbody>
					<!-- <tr no="1">
						<td>홍길동</td>
						<td>테스트</td>
						<td>10:16</td>
						<td>
							<div class="cmb_btn mtb">수정</div>
							<br/>
							<div class="cmb_btn mtb">삭제</div>
						</td>
					</tr> -->
				</tbody>
			</table>

			<!-- 페이징 -->
			<div class="paging_area"></div>
		</div>


		<!-- 검색 -->
		<div class="search_area">
			<!-- 검색어 휴지통 -->
			<input type="hidden" id="oldGbn" value="0" /> <input type="hidden"
				id="oldTxt" />

			<form action="#" id="searchForm">
				<input type="hidden" name="page" id="page" value="1" /> <select
					name="searchGbn" id="searchGbn">
					<option value="0">작성자</option>
					<option value="1">내용</option>
				</select> <input type="text" name="searchText" id="searchText" />

				<div class="cmn_btn_ml" id="searchBtn">검색</div>
			</form>

		</div>
	</div>
</body>
</html>