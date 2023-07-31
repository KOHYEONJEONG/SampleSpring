<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<!-- Common CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<!-- Popup CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />
<style type="text/css">
.paging_area{
   display: block; 
   position: relative; 
   left: 0;
   margin-bottom: 10px;
   font-size: 14px;
}

.main{
   display: flex;
   padding: 100px 200px;
   justify-content: space-between;
}
.main > div {
   width: 700px;   
}

.left_area img {
   width: 680px;
   height: 400px;
   border-radius: 15px;
   
}



.table {
   border-collapse: collapse;
   width: 100%;
   margin: 15px 0px;
}

.right_area img{ 
   width: 200px;
   height: 180px;
   /* object-fit: cover; */
}

.table tbody tr {
   height: 40px;
   text-align: center;
   color: #7b7b7b;
   font-size: 10.5pt;
}

.table tbody tr {
   
}

.tbody img{
   cursor: pointer;
}

</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
      src="resources/script/common/popup.js"></script>
<script type="text/javascript">
var flag = true;
$(document).ready(function () {

   //목록 조회
   reloadList();
   
   
   //페이징 버튼
   $(".paging_area").on("click", "span", function () {
      
      $("#page").val($(this).attr("page"));
      
      reloadList();
   })
   
   // 등록버튼
   $("#insertBtn").on("click", function () {
      console.log("1");
      
      $("#actionForm").attr("action", "AGInsert_sh");
      $("#actionForm").submit();
   })
   

   $(".tbody").on("click", "td", function () {
      $("#no").val($(this).attr("no"));
      
       /* $("#actionForm").attr("action", "AGDetail");
      $("#actionForm").submit();  */
      
      // 단건을 ajax로 보내서 왼쪽 화면에 그려
      var params = $("#actionForm").serialize();
      
      
      $.ajax({
         url : "AGDetailAjax_sh", //경로
         type : "POST", // 전송방식(GET: 주소형태, POST : 주소 헤더 형태)
         dataType: "json", // 데이터 형태
         data: params, // 보낼데이터
         success : function(res) { //성공했을 때 결과를 res에 받고 함수 실행
            //console.log(res); // 콘솔에  pd랑 list 값이 보임
            
            var html = "";
            
            html += "<tr>";
            html += "<td colspan=\"2\">";
            html += "<img alt=\"\" src=\"resources/upload/"+ res.data.PIC +"\">";
            html += "</td>"
            html += "</tr>"
            html += "<tr>";
            html += "<th>번호</th>"
            html += "<td>" + res.data.NO+ "</td>";
            html += "</tr>"
            html += "<tr>";
            html += "<th>제목</th>"
            html += "<td>" + res.data.TITLE+ "</td>";
            html += "</tr>"
            html += "<tr>";
            html += "<th>작성일</th>"
            html += "<td>" + res.data.DT+ "</td>";
            html += "</tr>"
            html += "<tr>";
            html += "<th>조회수</th>"
            html += "<td>" + res.data.HIT+ "</td>";
            html += "</tr>"
            html += "<th>설명</th>"
            html += "<td>" + res.data.DESCRIPT+ "</td>";
            html += "</tr>"
         

            $(".left_area tbody").html(html);
            
            
             var html1 ="";
            
      
            if("${sMemNo}" == res.data.MEM_NO){
               html1 += "<div class=\"cmn_btn_ml float_right_btn\" id=\"deleteBtn\">삭제</div>";
               html1 += "<div class=\"cmn_btn_ml float_right_btn\" id=\"updateBtn\">수정</div>";
            }
         
            $(".left_area .btn_wrap").html(html1); 
            
            

         },
         error : function(request, status, error) { // 실패했을 때 함수실행
            console.log(request.responseText); // 실패 상세 태역
         }
      });
      
   })
   

   $(".btn_wrap").on("click", "#updateBtn", function () {
      $("#actionForm").attr("action","AGUpdate_sh");
      $("#actionForm").submit();
      
   });
   
	$("body").on("click", "#deleteBtn", function () {
        makePopup({
               title : "알림",
               contents : "삭제하시겠습니까?",
               // draggable : true,
               buttons : [{
                  name : "삭제",
                  func:function() {
                     var params = $("#actionForm").serialize();
                   
                   $.ajax({
                      url : "AGAction_sh/delete", //restful api라는게 여기서 시작한다고?
                      type : "POST", 
                      dataType: "json", 
                      data: params, 
                      success : function(res) { 
                         switch(res.msg){
                         case "success" : 
                            // 카테고리를 유지하고 나머지 정보 초기화
                           $("#page").val("1");
							
                            flag = true;
                            
                            reloadList(); //재로드 하는 이유는 전역변수 flag가 유지가 안되기 때문이다.
                            closePopup();
                            
                           //$("#actionForm").attr("action","AGList");
                           //$("#actionForm").submit();
                            break;
                         case "fail" :
                            makeAlert("알림" , "삭제에 실패하였습니다.");
                            break;
                         case "error" :
                            makeAlert("알림" , "삭제 중 문제가 발생하였습니다.");
                            break;
                         }
                      },
                      error : function(request, status, error) { 
                         console.log(request.responseText); 
                      }
                   });
                  }
               }, {
                  name : "취소"
          }]
      });
   });
});//document

// 목록 조회 호출, ajax불러오기
function reloadList() {
   var params = $("#actionForm").serialize();
   
   $.ajax({
      url : "AGListAjax_sh", //경로
      type : "POST", // 전송방식(GET: 주소형태, POST : 주소 헤더 형태)
      dataType: "json", // 데이터 형태
      data: params, // 보낼데이터
      success : function(res) { //성공했을 때 결과를 res에 받고 함수 실행
         console.log(res); // 콘솔에  pd랑 list 값이 보임
         drawList(res.list);
         drawPaging(res.pd);
   
         
      },
      error : function(request, status, error) { // 실패했을 때 함수실행
         console.log(request.responseText); // 실패 상세 태역
      }
   });
   
}


function drawList(list) {
   var html = "";

   var cnt = 0;
     console.log(list[0].PIC);
     
   for(var data of list){
      if(cnt == 0) {
         html += "<tr>";
      }
      
      html += "<td no=\"" + data.NO + "\">";
      html += "<img alt=\"\" src=\"resources/upload/"+ data.PIC +"\">";
      html += "</td>"
      
      if(cnt == 2) {
         html += "</tr>";
      }
      cnt++;
      
      if(cnt >= 3) {
         cnt = 0;
      }
   }   
   $(".tbody").html(html);
   
   
   //처음일때만..
   // 강제로 tr td
   // enter키 누린것처럼
   

   if("${param.no}" != "") {
      console.log("${param.no}");
      flag = false;
      
      $("td[no='${param.no}']").click();
   } else if(flag) {
      console.log("else")
      flag = false;
      if($(".tbody").html() != "") {
         $(".tbody").children().eq(0).children().eq(0).click(); // click()는 위에 있는 클릭이벤트를 지칭
      }
   }
   
}


function drawPaging(pd) {
   var html = "";
   
   html += "<span class=\"page_btn page_first\" page=\"1\">처음</span>";
   // 이전
   if($("#page").val() == "1"){
      html += "<span class=\"page_btn page_prev\" page=\"1\">이전</span>";
   } else{
      // 문자열을 숫자로 바꾸기위해 *1
      html += "<span class=\"page_btn page_prev\" page=\"" + ($("#page").val() *1 - 1) + "\">이전</span>";
   }
   
   for(var i = pd.startP; i <= pd.endP; i++){
      if($("#page").val() * 1 == i){ // 현재 페이지
         html += "<span class=\"page_btn_on\" page=\"" + i + "\">" + i + "</span>";
      } else { // 다른 페이지
         html += "<span class=\"page_btn\" page=\"" + i + "\">" + i + "</span>";
      }
   }
   
   if($("#page").val() *1 == pd.endP){ // 현재페이지가 마지막 페이지라면
      html += "<span class=\"page_btn page_next\" page=\"" +pd.maxP+ "\">다음</span>";
   } else {
      html += "<span class=\"page_btn page_next\" page=\"" + ($("#page").val() *1 + 1) + "\">다음</span>";
   }
   
   html += "<span class=\"page_btn page_last\" page=\"" +pd.maxP+ "\">마지막</span>";
   
   $(".paging_area").html(html);
                                                                     
}
</script>      
</head>
<body>
<c:import url="/testAHeader"></c:import>
<hr/>
<div class="main">
<form action="#" id="actionForm" method="post">
   <input type="hidden" name="no" id="no" value="${data.NO}"/>
   <input type="hidden" name="page" id="page" value="${page}" />
</form>
<div class="left_area">
<table class="board_table">
   <colgroup>
      <col width="100" />
      <col width="600" />
   </colgroup>   
   <thead>
   </thead>
   
   <tbody>
   		<!-- ajax로 넣어줄거임 -->
   </tbody>
   
</table>
<div class="btn_wrap">

</div>
</div>
<div class="right_area">
<table class="table">
   <colgroup>
      <col width="100" />
      <col width="100" />
      <col width="100" />
   </colgroup>
   
   <tbody class="tbody">
   		<!-- ajax로 넣어줄거임 -->
   </tbody>
   
</table>
<div class="paging_area"></div>
<c:if test="${!empty sMemNo}">
         <div class="cmn_btn_ml float_right_btn" id="insertBtn">등록</div>
</c:if>
</div>
</div>
</body>
</html>