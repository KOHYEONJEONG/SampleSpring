<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	border-collapse: collapse;
	margin: 0 auto;
}

th, td {
	border: 1px solid #000;
	padding: 5px;
}

#pagingWrap span{
	cursor : pointer;
}

textarea {
	width:100%;
	height:200px;
	border: 0;
	box-sizing: border-box;
}

.updateBox{
	text-align: center;
}

h3{
	display: inline-block;
	background-color: #e6e6e6;
}
</style>

<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>

<!-- CKEditor -->
<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js">
</script>

<script type="text/javascript">
$(document).ready(function() {
	//에더터 연결
	//CKEDITOR.replace(아이디, 옵션)
	CKEDITOR.replace("con",{
		resize_enabled : false, //resize_enabled : 크기조절기능 활용 여부(false는 사이즈 조절 불가능.)
		language : "ko", // 사용언어(ko 한글)
		enterMode : "2", // 엔터키 처리 방법
		width : 600, //숫자일 경우 px, 문자열일경우 css 크기
		height : 400 //마지막옵션에는 콤마 붙이면 안됨!!!
	});
	
	$("#listBtn").on("click", function() { 
		history.back(); /*처음화면으로 돌아가기*/
	});
	
	$("#updateBtn").on("click", function() {
		
		$("#con").val(CKEDITOR.instances['con'].getData());
		
		if($("#title").val()==""){
			alert("제목을 입력하세요.");
			$("#title").focus();
		}else if($("#writer").val()==""){
			alert("작성자를 입력하세요.");
			$("#writer").focus();
		}else if($("#con").val()==""){
			alert("내용을 입력하세요.");
			$("#con").focus();
		}else{
			$("#actionForm").submit();
		}
	});
	
});
</script>
</head>
<body>
	<div class="updateBox">
	<h3>익명게시판 수정페이지</h3>
	<form action="ANAction/update" id="actionForm" method="post"> 
		<!-- 수정할 때는 번호를 가지고 다녀야함. -->
		<input type="hidden" name="no" value="${data.NO}"/>
		
		<!--(중요)전 화면에서 넘어온 페이지 정보(목록으로 돌아가더라도 페이지 상태값이 유지된다.)  -->
		<input type="hidden" name="page" value="${param.page}">
		
		<!--(중요) 밑2줄, 상세보기 다녀와도 검색어가 유지되도록 하기 위해서.(sellList.jsp와 유지되게) -->
		<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
		
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" id="title" name="title" value="${data.TITLE}"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" id="writer" name="writer" value="${data.WRITER}"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea id="con" name="con">${data.CON}</textarea></td>
			</tr>
			
		</table> 
	</form>
	
			<input type="button" value="수정" id="updateBtn" />
			<input type="button" value="목록" id="listBtn" />
	</div>
</body>
</html>