<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 조회</title>
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
   width:800px;
   margin: 0 auto;
}
.mtb {
   margin: 5px 0px;
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

#accTypeGbn{
	width: 90px;
    height: 35px;
}

input[type="text"]{
	height: 30px;
}

input[type="date"]{
	height: 30px;
}


</style>

<script type="text/javascript">
	$(document).ready(function() {
		reloadList();//전체 조회
		
		$("#insertBtn").on("click", function() {
			console.log("등록");
			
			if($.trim($("#info").val()) == "") {
	            makeAlert("알림", "내용을 입력하세요.", function() {
	           		 $("#info").focus();
	       		});
	       }else if($.trim($("#price").val()) == ""){
	    	   makeAlert("알림", "금액을 입력하세요.", function() {
	           		 $("#price").focus();
	       		});
	       }else if($.trim($("#dt").val()) == ""){
	    	   makeAlert("알림", "날짜를 선택해주세요.", function() {
	           		 $("#dt").focus();
	       		});
	       }else{
	            action("insert");
	       }
		});
		
		//페이징 클릭시
	  	$(".paging_area").on("click", "span", function() {
				
	  		$("#page").val($(this).attr("page"));
	  	
	  		//다시 조회
	  		reloadList();
		});
	  	
		
	});
	
	var msg = {
			"insert" : "등록",
			"update" : "수정",
			"delete" : "삭제",
	}
	
	function action(flag) { //비동기 등록, 수정, 삭제
		
		console.log(msg[flag]);
		var params = $("#insertForm").serialize();
		
		$.ajax({
			url : "AccAction/"+flag,
			type : "POST",
			dataType : "json",
			data:params,
			success : function(res) {
				switch (res.msg) {
				case "success":
					
					$("#no").val("");
				  	$("#price").val("");
				  	$("#info").val("");
				  	$("#accTypeGbn").val("0");
				  	$("#dt").val("");
				  	
						switch (flag) {
						 case "insert":
						 case "delete":
							 $("#page").val("1");//첫페이지에서 나타나게 하려고
						 	break;
						 
						 case "update":
							//입력내용 초기화
						  	$("#no").val("");
						  	$("#price").val("");
						  	$("#info").val("");
						  	$("#accTypeGbn").val("0");
						  	$("#dt").val("");
					     	break;
						}
					
						//목록 재조회
			            reloadList();
					break;//case "success"
				
				case "fail":
					makeAlert("알림", msg[flag]+"에 실패하였습니다.")
					break;	
				case "error":
					makeAlert("알림", msg[flag]+"중 문제가 발생하였습니다.")
					break;
				
				}
				
			},
			error : function(request, status, error) {
				console.log(request.responseText);
			}
		});//ajax End
	}//action(Flag) function End
	
	
	/**전체조회, 페이징 데이터*/
	function reloadList() {
		var params = $("#actionForm").serialize();
		
		$.ajax({
			url:"ACCListAjax",
			type:"POST",
			dataType:"json",
			data : params,
			success : function(res) {
				
				drawList(res.list);
				drawPaging(res.pd);
				
			},error: function(request, status, error) {
				console.log(request.responseText);
			}
			
		});
	}
	
	function drawList(list) {
		var html = "";
		
		for(var data of list){
			html += "<tr no=\""+data.NO+"\">";
			html += "<td>"+data.NO+"</td>";
			html += "<td>"+data.PRICE+"</td>";
			html += "<td>"+data.ACC_TYPE+"</td>";
			html += "<td>"+data.INFO+"</td>";
			html += "<td>"+data.DT+"</td>";
			html += "<div class=\"cmn_btn mtb update_btn\">수정</div><br/>";
			html += "<div class=\"cmn_btn mtb delete_btn\">삭제</div>";
			html += "</tr>";
		}
	}
	
	function drawPaging(pd) {
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
	<!-- 
	총계 제공내용 : 지출 총계, 수입 총계, 총계 테이블
	
	목록 제공내용 : 번호, 금액, 지출/수입, 내역, 일자
	 -->
	 <form action = "#" id="actionForm">
	 	<input type="hidden" name="page" id="page" value="1"/>
	 </form>
	 
	 
	<div class="wrap">
		<div class="board_area">
		<table class="board_table">
			<colgroup>
				<!-- 번호 -->
		         <col width="100" />
		         <!-- 금액 -->
		         <col width="100" />
		          <!-- 지출/수입 -->
		         <col width="100" />
		      </colgroup>
		      
	      <thead>
	      	<tr>
	      		<th>지출</th>
	      		<th>수입</th>
	      		<th>총액</th>
	      	</tr>
	      	
      		
	      </thead>
	      
	      <tbody>
	      <tr>
	      		<th>(지출-비동기)</th>
	      		<th>(수입-비동기)</th>
	      		<th>(총액-비동기)</th>
	      	</tr>
	      </tbody>
	      	
	   </table>
		
		
		
		<table class="board_table">
			<colgroup>
		         <!-- 번호 -->
		         <col width="150" />
		         <!-- 금액 -->
		         <col width="150" />
		          <!-- 지출/수입 -->
		         <col width="150" />
		          <!-- 내역 -->
		         <col width="150" />
		         <!-- 일자 -->
		         <col width="200" />
		      </colgroup>
		    <thead>
		    <tr>
		    <td colspan="4">
			    <form action="#" id="insertForm">
			    	<input type="hidden" name="no" id="no"/> 
					<!-- 지출(SELECT) , 금액(TEXT), 내역(TEXT), DATE(캘린더),등록버튼  -->
					<select name="accTypeGbn" id="accTypeGbn">
						<option value="0">지출</option>
						<option value="1">수입</option>
					</select>
					<input type="text" placeholder="금액" name="price" id="price"/>
					<input type="text" placeholder="내역" name="info" id="info"/>
					<input type="date" name="dt" id="dt"/>
				</form>
			</td>
			<td>
				<div  class="cmn_btn_ml" id="insertBtn">
					등록
				</div>
			</td>
		    
		    </tr>
			    <tr>
			    	<th>번호</th>
			    	<th>금액</th>
			    	<th>지출/수입</th>
			    	<th>내역</th>
			    	<th>일자</th>
			    	<th></th>
			    </tr>
		    </thead> 
		      
			<tbody>
				
			</tbody>
		</table>
		
			<!-- 페이징 -->
	   		<div class="paging_area"></div>
		
		</div>
	</div>
</body>
</html>