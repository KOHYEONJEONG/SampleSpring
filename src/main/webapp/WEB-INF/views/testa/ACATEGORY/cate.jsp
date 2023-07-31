<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리</title>
<!-- Common css -->
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<!-- Popup css -->
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />
<!-- jQuery -->
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<!-- Popup JS -->
<script type="text/javascript" src="resources/script/common/popup.js"></script> 
<!-- SlimScroll -->
<script type="text/javascript" src="resources/script/jquery/jquery.slimscroll.js"></script>
<style type="text/css">
.wrap{
   width: 500px;
   margin: 0 auto;
}

.mtb {
   margin: 5px 0px;
}

.login {
   vertical-align:baseline;
}

.nm {
  	width: calc(100% - 22px);
    height: 20px;
    border: 1px solid #d7d7d7;
    resize: none;
    padding: 10px;
    margin: 5px;
}

.update{
	display: none;
}

.con_td{
	font-size: 0;
}

.paging_area{
	display: block;
	position: relative;
	left: 0;
	margin-bottom: 10px;
}

.search_area{
	text-align: center;
}

body{
	overflow: auto;
}
</style> 
<script type="text/javascript">
	$(document).ready(function() {
		
		reloadList(); //전체 조회
		
		
		$("#insertBtn").click(function() {
			if($.trim($("#nm").val()) == "" ){
				makeAlert("알림","카테고리명을 입력하세요.", function() {
					$("#nm").focus();	
				});
			}else{
				action("insert");
			}
		});//insertBtn
		
		
		//페이징 버튼
		$(".paging_area").on("click", "span",function() {
			$("#page").val($(this).attr("page"));
			
			//기존 값 유지
			$("searchGbn").val($("#oldGbn").val());
			$("searchText").val($("#oldText").val());
			
			//다시 조회
			reloadList();
		});
		
		//검색버튼 클릭시
		$("#searchBtn").on("click", function() {
			$("#page").val("1");
			
			//기존값 새값으로 변경
			$("#oldGbn").val($("#searchGbn").val());
			$("#oldText").val($("#searchText").val());
			
			//다시 조회
			reloadList();
						
		});
		
		//목록의 삭제버튼 클릭시
		$("tbody").on("click", ".delete_btn", function() {
			var no = $(this).parent().parent().attr("no");
			
			makePopup({
				title:"알림",
				contents : "삭제 하시겠습니까?",
						buttons:[{
							name:"삭제",
							func : function() {
								
								$("#no").val(no);
								action("delete");//삭제 로직처리
								
								closePopup();
							}
						},
						{
							name : "취소"
						}]
			});
		});//delete_btn
		
		//목록의 수정 버튼 클릭 시
		$("tbody").on("click", ".update_btn", function() {
			var no = $(this).parent().parent().attr("no");
			
			$("#no").val(no);
			
			var nm = $(this).parent().parent().children().eq(1).html();
			console.log(nm);
			
			$("#nm").val(nm);
			
			//등록버튼 감추기 + (수정, 취소버튼 나타내기)
			$(".insert").hide();
			$(".update").show();
			
			$("#nm").focus();
			
			
		})//update_btn
		
		//(상단)수정 영역의 취소 버튼
		$("thead #cancelBtn").click(function() {
			
			//입력 내용 초기화
			$("#no").val(""); //hidden이라 보이지는 않음.
			$("#nm").val("");
		
			//등록버튼 나타내기 + (수정,취소버튼 숨기기)
			$(".insert").show();
			$(".update").hide();
			
		});
		
		//(상단)수정 영역의 수정 버튼
		$("thead #updateBtn").click(function() {
			action("update");
		});
		
	});
	
	function reloadList() {
		var params = $("#searchForm").serialize();
		
		$.ajax({
			url : "ACateList", //경로(컨트롤러) 
			type : "POST", 
			dataType : "json",
			data : params,
			success : function(res) {
				drawList(res.list);
				drawPaging(res.pd);
			},
			error: function(request, status, error) {//실패했을 때 함수 실행
				console.log(request.responseText);//실패 상세 내역
			}
		});//ajax
	}//reloadList() 
	
	function drawList(list) {
		var html = "";
		
		for(var data of list){
			html += "<tr no=\""+data.CATE_NO+"\">";
			html += "<td>"+data.CATE_NO+"</td>";
			html += "<td>"+data.CATE_NM+"</td>";
			html += "<td>"
		
			if(data.CATE_NO != 0){ //자유게시판은 삭제 못하게
				html += "<div class=\"cmn_btn mtb update_btn\">수정</div><br/>";  //수정버튼
				html += "<div class=\"cmn_btn mtb delete_btn\">삭제</div>";       //삭제버튼
			}
			html += "</td>";
			html += "</tr>";
		}
		
		$("tbody").html(html);
	}
	
	function drawPaging(pd){
		var html = "";
		
		html = "<span class=\"page_btn page_first\" page=\""+1+"\">처음</span>";
		
		if($("#page").val() == "1"){
			//이전 페이지 page가 1이면 1, 아니면  -1
			html += "<span class=\"page_btn page_prev\" page=\""+1+"\"> 이전</span>";
		}else{
			html += "<span class=\"page_btn page_prev\" page=\""+($("#page").val() *1 - 1)+"\"> 이전</span>";
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
	
	var msg= {
			"insert":"등록",
			"update":"수정",
			"delete":"삭제"
	}
	
	function action(flag) {//비동기 등록, 수정, 삭제
		
		//JS에서의 Object에서의 [] : 해당 키값으로 내용을 불러오거나 넣을 수 있다. 
		//						java의 Map에서 get, put역할
		console.log(msg[flag]);//ex)문자로 insert가 넘어온 거임
		
		var params = $("#actionForm").serialize();
		$.ajax({
			url : "ACateAction/"+flag, //동일한 작업을 해야함.
			type : "POST",
			dataType : "json",
			data : params,
			success : function(res) {
				switch (res.msg) {
				case "success":
						//카테고리명을 초기화(등록되고 나면 textarea에 아무것도 안남음)
						$("#nm").val("");
						
						//목록 재조회
						switch (flag) {
						case "insert":
						case "delete":
							$("#page").val("1");//첫 페이지에 나타나게 하려고
							$("#searchGbn").val("0");
							$("#searchText").val("");
							$("#oldGbn").val("0");
							$("#oldText").val("");
							
						break;
						
						case "update":
							//업데이트는 기존 값 유지만 하면된다.
							$("#searchGbn").val($("#oldGbn").val());
							$("#searchText").val($("#oldText").val());
							
							//입력 내용 초기화
							$("#no").val("");
							$("#nm").val("");
							
							//등록버튼 +수정, 취소버튼
							$(".insert").show();
							$(".update").hide();
							break;
						}
						
						reloadList();//등록하고 나면 바로 재조회!!
					break;
				case "fail":
					makeAlert("알림", msg[flag] + "에 실패하였습니다.");
					break;
					
				case "error":
					makeAlert("알림", msg[flag] + "에 실패하였습니다.");
					break;
				}
				
			},
			error: function(request, status, error){
				console.log(request, responseText);
			}
		});
		
	}
</script>
</head>
<body>
<div class="wrap">
	
	<div class="board_area">
		
		<table class="board_table">
			<colgroup>
				<col width = "100">
				<col width = "*">
				<col width = "100">
			</colgroup>
			
			<thead>
				<tr>
					<th>카테고리명</th>
					<th class="con_td">
						<form action="#" id="actionForm">
							<input type="hidden" name="no" id="no"/><!-- 삭제,수정 시 사용 -->
							<input type="text" name="nm" id="nm" class="nm"/>
						</form>
					</th>
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
				
				<tr>
					<th>NO</th>
					<th>카테고리명</th>
					<th>&nbsp;</th>
				</tr>
			</thead>	
			
			<tbody>
			</tbody>
			
			
		</table>
		
		<!-- 페이징 -->
   		<div class="paging_area"></div>
   		
   		<div class="search_area">
   			<!-- 검색어 휴지통 -->
   			<input type="hidden" id="oldGbn" value="0"/>
   			<input type="hidden" id="oldText"/>
   			
   			<form action="#" id="searchForm">
   				<input type="hidden" name="page" id="page" value="1">
   				<select name="searhGbn" id="searhGbn">
   					<option value="0">카테고리명</option>
   				</select>
   				<input type="text" name="searchText" id="searchText" />
   				<div class="cmn_btn_ml" id="searchBtn">검색</div>
   			</form>
   		</div>
	</div>
	
</div>



</body>
</html>