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
<title>댓글(한줄게시판)</title>

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

.login {
   vertical-align:baseline;
}

.con {
   width: calc(100% - 22px);
   height: 60px;
   border: 1px solid #d7d7d7;
   resize:none;
   padding:10px;
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
		
		/*문제가 좀 많아서 ㅠㅠ body에 overflow: auto;주면 됨.
			$('body').slimscroll({
				height : "100%",
				axis : "y"
			});
		*/
		
		reloadList();//전체 조회
		
		$(".board_table #loginBtn").on("click", function() {
			location.href="testALogin";
		});
		
		$("#insertBtn").on("click", function() { 
			 if($.trim($("#con").val()) == "") {
		            makeAlert("알림", "내용을 입력하세요.", function() {
		           		 $("#con").focus();
		       		});
		       }else{
		            action("insert");
		       }
			
	  	});//$("#insertBtn") function End 
	  	
	  	//페이징 클릭시
	  	$(".paging_area").on("click", "span", function() {
				
	  		$("#page").val($(this).attr("page"));
	  		
	  		//기존 값 유지
	  		$("#searchGbn").val($("#oldGbn").val());
	  		$("#searchText").val($("#oldText").val());
	  		
	  		//다시 조회
	  		reloadList();
		});
	  	
	  	//검색버튼 클릭시
	  	$("#searchBtn").on("click", function() {
	  		$("#page").val("1");//1 중요
	  		
	  		//기존 값 새 값으로 변경
	  		$("#oldGbn").val($("#searchGbn").val());
	  		$("#oldText").val($("#searchText").val());
	  		
	  		//다시 조회
	  		reloadList();
	  		
		});//searchBtn
		
		
		//목록의 삭제버튼 클릭시
		$("tbody").on("click", ".delete_btn", function() { //문서를 로드했을 때 <tbody>는 있지만 안에 내용들은 스크립트가 실행되고 나서야 생성됨. 그래서 이렇게 적은거다.
			var no = $(this).parent().parent().attr("no");//내가 버튼이고 버튼의 부모는 td고 td의 부모는 tr이다. tr이 no를 가지고 있다.(관리자도구로 보면 이해됨.)
			
			makePopup({
				title:"알림",
				contents : "삭제 하시겠습니까?",
				buttons : [{
					name:"삭제",
					func : function(){
						$("#no").val(no);//서버에 삭제할 게시글 번호 전송!!!
						action("delete");//삭제 로직 처리
						
						closePopup();//제일 위의 팝업 닫기!!!(이게 없으면 삭제되고 나서도 팝업창이 유지된다.)
					}
				},{
					name:"취소"
				}]
			});//makePopup
		});//delete_btn
	  	
		
		//목록의 수정 버튼 클릭 시
		$("tbody").on("click", ".update_btn", function() {
			
			var no = $(this).parent().parent().attr("no");
			$("#no").val(no);
			
			//eq(인덱스번호) : 자식 중 인덱스 몇번째 인지 찾아서 취득
			var con = $(this).parent().parent().children().eq(1).html();
			
			//수정 내용 넣기 전 < > 변환
			con = con.replace(/&lt;/gi, "<");//textarea에는 꺽세표시가 잘됨.(db에도 똑같이 넣어주려고 substring을 해서 db에도 해주면되지만 어짜피 바꿔줘야하기에~~...?)
			con = con.replace(/&gt;/gi, ">");//textarea에는 꺽세표시가 잘됨.
			
			$("#con").val(con);
			
			//등록버튼 감추기 + (수정,취소버튼 나타내기)
			$(".insert").hide();//display:none;
			$(".update").show();//display:display;
			
			//작성영역에 포커스
			$("#con").focus();
			
		});
		
		//수정 영역의 취소 버튼
		$("thead #cancelBtn").on("click", function() {
			//입력 내용 초기화
			$("#no").val("");//hidden이라 보이지는 않음.
			$("#con").val("");
			
			//등록버튼 나타내기 + (수정,취소버튼 숨기기)
			$(".insert").show();
			$(".update").hide();
			
		});
		
		//수정 영역의 수정 버튼
		$("thead #updateBtn").on("click", function() {
			action("update"); //여기까지는 쉬움!
		});
		
		
	});//$(document)
	
	var msg={
		"insert" : "등록",
		"update" : "수정",
		"delete" : "삭제",
	}
	
	function action(flag) {//비동기 등록, 수정, 삭제
		
		//con의 <들을 웹문자로 변환 
		$("#con").val($("#con").val().replace(/</gi, "&lt;"));
		//con의 >들을 웹문자로 변환
		$("#con").val($("#con").val().replace(/>/gi, "&gt;"));
		//이제 복호화 작업을 해야함!!!(수정버튼 눌렀을때, 목록 수정버튼 눌를 시 주석을 찾아서 가보면 158라인~159라인)
		
		
		//JavaScript Object에서의 [] : 해당 키값으로 내용을 불러오거나 넣을 수 있다.
		//								java의 Map에서 get, put역할
		console.log(msg[flag]); //ex)문자로 insert가 넘어온 거임
		
		 var params = $("#actionForm").serialize();
         $.ajax({
            url : "AOBAction/"+flag, //동일한 작업을 해야함.
            type : "POST",
            dataType : "json", 
            data : params, 
            success : function(res) { 
	            switch(res.msg){
		            case "success":
						//내용초기화
		            	$("#con").val("");
						
		               switch (flag) {
						case "insert": 
						case "delete":
							$("#page").val("1");//첫페이지에서 나타나게 하려고
							$("#searchGbn").val("0");
							$("#searchText").val("");
							$("#oldGbn").val("0");
							$("#oldText").val("");
						break;

						case "update":
							//업데이트는 기존 값 유지만 하면 된다.
					  		$("#searchGbn").val($("#oldGbn").val());
					  		$("#searchText").val($("#oldText").val());
					  		
					  		//입력내용 초기화
					  		$("#no").val("");
					  		$("#con").val("");
					  		
					  		//등록버튼 + 수정,취소버튼 감추기
					  		$(".insert").show();
					  		$(".update").hide();
							break;
					 }
		               //목록 재조회
		               reloadList();//등록하고 나면 바로 재조회!!!   
		            	break;
		               
		            case "fail":
		                makeAlert("알림", msg[flag] + "에 실패하였습니다.");
		               break;
		               
		            case "error":
		                makeAlert("알림", msg[flag] +" 중 문제가 발생하였습니다.");
		               break;
	            }
            },
            error : function(request, status, error) {
               console.log(request.responseText); 
            }
         });//ajax End
	}//action(flag) function End
	
function reloadList() {
	var params = $("#searchForm").serialize();
	
	$.ajax({
		url : "AOBList", //경로 
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
		
	});//ajax
}	
	
function drawList(list) {//값 들어갈 위치에 "++"
	var html = "";
	
	for(var data of list){
		html += "<tr no = \""+data.NO+"\">";
		html += "<td>"+data.MEM_NM+"</td>";
		html += "<td>"+data.CON+"</td>";
		html += "<td>"+data.DT+"</td>";
		html += "<td>";
		
		if("${sMemNo}" == data.MEM_NO){//작성자가 같으면
			html += "<div class=\"cmn_btn mtb update_btn\">수정</div><br/>";
			html += "<div class=\"cmn_btn mtb delete_btn\">삭제</div>";
		}
		html += "</td>";
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

<div class="wrap">
<div class="board_area">

   <!-- 작성 또는 로그인 -->
   
   <!-- 목록 -->
   <table class="board_table">
      <colgroup>
      <!-- 작성자 -->
         <col width="100" />
         <!-- 내용 -->
         <col width="500" />
         <!-- 날짜 -->
         <col width="100" />
         <!-- 버튼 -->
         <col width="100" />
      </colgroup>
      
      <thead>
      	  <c:choose>
      	  	<c:when test="${empty sMemNo}"> <!-- 비 로그인 시 -->
	      	  <tr>	
		    	  <th colspan="4">
		    	  		로그인이 필요한 서비스입니다.
		    	  		<div class="cmn_btn mtb login" id="loginBtn">로그인</div>
		    	  </th>
		      </tr>
      	  	</c:when>
      	  	
      	  	<c:otherwise> <!-- 로그인시 -->
	      	  <tr>
		      	  <th>${sMemNm}</th>
	              <td colspan="2" class="con_td">
	                 <form action = "#" id="actionForm">
	                 	<input type="hidden" name="no" id="no"/> <!-- 삭제, 수정 시 필요 -->
	                 	<input type="hidden" name="memNo" value="${sMemNo}"/>
	                 	<textarea class="con" name="con" id="con"></textarea>
	                 </form>
	              </td>
	               
	              <th>
              		<div class="insert">
              			<div class="cmn_btn" id="insertBtn">등록</div>
              		</div>
              		 
              		<div class="update">
              			<div class="cmn_btn mtb" id="updateBtn">수정</div><br/>
              			<div class="cmn_btn mtb" id="cancelBtn">취소</div>
              		</div>
	              </th>
		      </tr>
      	  	</c:otherwise>
      	  </c:choose>
	
		<!-- 조회 -->	      
	      <tr>
	      	 <th>작성자</th>
	      	 <th>내용</th>
	      	 <th>작성일</th>
	      	 <th>&nbsp;</th>
	      </tr>
      
      </thead>
      
      <tbody>
         <!-- <tr no = 1>
            <td>홍길동</td>
            <td>테스트</td>
            <td>10:16</td>
            <td>
               <div class="cmn_btn mtb">수정</div><br/>
               <div class="cmn_btn mtb">삭제</div>
            </td>
         </tr> -->
      </tbody>
   </table>
   		<!-- 페이징 -->
   		<div class="paging_area"></div>
   </div>
   
   <div class="search_area">
   	   <!-- 검색어 휴지통 -->
	   <input type="hidden" id="oldGbn" value="0"/>
	   <input type="hidden" id="oldTxt"/>
	   
      <form action="#" id="searchForm">
         <input type="hidden" name="page" id="page" value="1" />
         
         <select name="searchGbn" id="searchGbn">
         	<!-- EL은 숫자로 받지만, 서버에는 SPRING으로 받는다. -->
            <option value="0">작성자</option>
            <option value="1">내용</option>
         </select>
         
         <input type="text" name="searchText" id="searchText"/>
         <div class="cmn_btn_ml" id="searchBtn">검색</div>
      </form>
   </div>
   
</div>

</body>
</html>