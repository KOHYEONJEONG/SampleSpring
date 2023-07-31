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

input[type="text"]{
 	border:0;
}

textarea {
	width:100%;
	height:200px;
	border: 0;
	box-sizing: border-box;
}

.nm{
	font-size: 14px;
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
		$("#backForm").submit(); /*처음화면으로 돌아가기*/
	});
	
	$("#insertBtn").on("click", function() {
		
		//CKEditor의 값 취득
		//CKEditor.instances[아이디] : CKEDITOR중 아이디가 같은 것을 찾겠다.
		//.getData() : 작성중인 내용을 취득한다.
		$("#con").val(CKEDITOR.instances['con'].getData());
				
		if($.trim($("#title").val())==""){ //$.trim(값) : 값 앞 뒤 공백제거
			alert("제목을 입력하세요.");
			$("#title").focus();
			
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

	<form action="tBoardList" id="backForm" method="post"> 
		<input type="hidden" name="page" value="${param.page}"/>
		<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
		
	</form>
	
	<form action="TAction" id="actionForm" method="post">
		<!-- insert 구분자 i -->
		<input type="hidden" name="gbn" value="i"/>
		
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" id="title" name="title"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td class="nm">${sMemNm}<input type="hidden" name="memNo" value="${sMemNo}"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea id="con" name="con"></textarea></td>
			</tr>
			
		</table> 
	</form>
	
	<div style="text-align: center;">
		<input type="button" value="등록" id="insertBtn" />
		<input type="button" value="목록" id="listBtn" />
	</div>
	
</body>
</html>