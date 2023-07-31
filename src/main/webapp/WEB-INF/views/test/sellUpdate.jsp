<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function() {
	
	//체크된 값으로 알아서 넣어진다(꿀팁!!!)
	//기존 값으로 셀렉트 박스 선택 내용 변경.
	$("#itemName").val("${data.ITEM_NAME}");//DB에서 넘어온 값이기 때문에 ITEM_NAME 컬럼은 꼭 대문자로 입력해야 가져온다!!!
	
	$("#listBtn").on("click", function() { 
		history.back(); /*처음화면으로 돌아가기*/
	});
	
	//insert와 update는 필털링 똑같음.
	$("#updateBtn").on("click", function() { 
		if($("#count").val() == ""){
			alert("수량을 입력하세요.");
			$("#count").focus();
		}else if($("#count").val() *1 < 1){
			/*(고려사항)정확하게 어떤한 값들이 필수인지 아닌지 처리를 해야한다.*/
			alert("수량은 1개 이상이어야 합니다.");
			$("#count").focus();
		}
		else if($("#sellDt").val() == ""){
			alert("일자를 입력하세요.");
			$("sellDt").focus();
		}else{
			$("#actionForm").submit();
		}
	});
});
</script>
</head>
<body>
	<!-- sellRes 컨트롤러에서 삽입, 수정, 삭제 가능함.  -->
	<form action="sellRes" id="actionForm" method="post">
		
		<!--(중요)전 화면에서 넘어온 페이지 정보(목록으로 돌아가더라도 페이지 상태값이 유지된다.)  -->
		<input type="hidden" name="page" value="${param.page}">
		
		<!--(중요) 밑2줄, 상세보기 다녀와도 검색어가 유지되도록 하기 위해서.(sellList.jsp와 유지되게) -->
		<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
		
		<!-- 구분에 따라 행위가 달라짐. -->
		<!-- 구분 : i - insert, u - update, d - delete -->
		<input type="hidden" name="gbn" value="u"/>
		
		<!-- 수정할 때는 번호를 가지고 다녀야함. -->
		<input type="hidden" name="no" value="${data.SELL_NO}"/>
		
		판매번호 : ${data.SELL_NO}<br/>
		
		품목명 
		 <select name="itemName" id="itemName">
			<!-- value는 명시적으로 적어주는 게 좋고, 다 입력하자. -->
			<option value="감자">감자</option>
			<option value="고구마">고구마</option>
			<option value="애호박">애호박</option>
			<option value="호박">호박</option>
			<option value="호박고구마">호박고구마</option>
		 </select> 
		 
		 <br />
		  수량 : <input type="number" name="count" id="count" value="${data.COUNT}" />
		
		 <br />
		  일자 <input type="date" name="sellDt" id="sellDt" value="${data.SELL_DT}"/> <br />
	</form>
	<input type="button" value="수정" id="updateBtn" />
	<input type="button" value="목록" id="listBtn" />
	
	<script type="text/javascript"></script>
</body>
</html>