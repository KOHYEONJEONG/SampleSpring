<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리 전체 화면</title>
<link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="resources/gallery/lightboxed.css" rel="stylesheet" />

<script type="text/javascript" src="resources/gallery/lightboxed.js" ></script>
<script type="text/javascript"
      src="resources/script/common/popup.js"></script>  
<script type="text/javascript" 
		src="resources/script/jquery/jquery.form.js"></script>

<style>
	html, * {
		font-family: 'Inter';
		box-sizing: border-box;
	}
	
	body {
		background-color: #fafafa;
		line-height: 1.6;
	}
	
	.lead {
		font-size: 1.5rem;
		font-weight: 300;
	}
	
	.container {
		margin: 70px auto;
		max-width: 960px;
	}
	
	.btn {
		padding: 1.25rem;
		border: 0;
		border-radius: 3px;
		background-color: #4F46E5;
		color: #fff;
		cursor: pointer;
	}
	
	.container img {
		width: 300px;
	}
	
	.fileInsertBox{
		border-bottom: 1px solid black;
		border-top: 1px solid black;
		text-align: right;
		padding-top: 10px;
		padding-bottom: 10px;
	}
	
	.search_area{
		text-align: center;
		padding: 20px 0;
	}

	/* paging */
	.paging_area {
		display: inline-block;
		min-width: 300px;
		text-align:center;
		height: 30px;
		position: absolute;
		left: calc(50% - 150px);
	}
	
	.page_btn {
		background-color: #f2f2f2;
		color: #7b7b7b;
	}
	
	.page_btn, .page_btn_on {
		display: inline-block;
		vertical-align: top;
		width: 30px;
		height: 30px;
		line-height: 30px;
		font-size: 11pt;
		font-weight: bold;
		margin: 0px 2px;
		border-radius: 2px;
		cursor: pointer;
	}
	
	.page_btn:hover {
		background-color: #d7d7d7;
	}
	
	.page_first, .page_prev, .page_next, .page_last {
		font-size: 0pt;
	}
	
	.page_first {
		background-image: url('resources/images/cmn/first_icon.png');
		background-repeat: no-repeat;
		background-position: center;
		background-size: 15px;
	}
	
	.page_prev {
		background-image: url('resources/images/cmn/prev_icon.png');
		background-repeat: no-repeat;
		background-position: center;
		background-size: 15px;
	}
	
	.page_next {
		background-image: url('resources/images/cmn/next_icon.png');
		background-repeat: no-repeat;
		background-position: center;
		background-size: 15px;
	}
	
	.page_last {
		background-image: url('resources/images/cmn/last_icon.png');
		background-repeat: no-repeat;
		background-position: center;
		background-size: 15px;
	}

	.picBox{
		display: inline-block;
		vertical-align: top;
		margin-right: 10px;
		margin-bottom: 10px;
	}
	
	.picBoxChildren{
		margin-right: 10px;
    	margin-bottom: 10px;
	}
	
	#insertBtn{
	    position: relative;
	    border: none;
	    display: inline-block;
	    padding: 15px 30px;
	    border-radius: 15px;
	    font-family: "paybooc-Light", sans-serif;
	    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
	    text-decoration: none;
	    font-weight: 600;
	    transition: 0.25s;
	    
	    background-color: #6aafe6;
    	color: #fff;
    }
    
    #insertBtn:hover {/*볼록 튀어나오게 해줌*/
	    letter-spacing: 2px;
	    transform: scale(1.2);
	    cursor: pointer;
	}
	
	.picBoxChildren > img {
		display: block;
	}
	
	.picBoxChildren > input{
		display: inline-block;
	    width: 100%;

		padding: 3px;
    	box-sizing: border-box;
	    border-radius: 5px;
	    border: 1px solid gray;
	    background-color: lightblue;
	    font-weight: 700;
	    cursor: pointer;
	}
	
	img{
		width: 300px;
		height: 170px;
	}
	
</style>
<script type="text/javascript">
$(document).ready(function() {
	
	//검색구분 유지
	if("${param.searchGbn}" != ""){
		$("#searchGbn").val("${param.searchGbn}");
	}else{
		$("#oldGbn").val("0");//없으면 0으로 고정
	}
	
	
	reloadList();
	
	//검색버튼
	$("#searchBtn").on("click", function() {
		$("#page").val("1");
		
		//신규 상태 등록(검색구분, 검색어 유지하려고)
		$("#oldGbn").val($("#searchGbn").val());
		$("#oldTxt").val($("#searchTxt").val());
		
		//목록을 다시 화면에 그렸으면 좋겠엉!
		reloadList();
	});
	
	//페이징버튼
	$(".paging_area").on("click", "span", function() {
		
		//기본 검색 상태 유지(검색구분, 검색어 유지하려고)
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		//페이지 속성에 값을 서버에 보낸 page id에 담아서 보내기.
		$("#page").val($(this).attr("page"));
		
		//목록 조회
		reloadList();
		
	});
	
	//등록버튼
	$("#insertBtn").on("click", function() {
		
		//기존 검색 상태 유지(insert창에서 값을 가지고 있고, 목록으로 돌아와도 검색어와, 구분 유지 되게)
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action", "AGInsert");//ginsert.jsp로 이동하려고 
		$("#actionForm").submit();
	});
	
	//상세보기 버튼
	$(".gallery_box").on("click", ".picBoxChildren",function() {
		 $("#no").val($(this).attr("no"));
		
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action", "AGDetail");//ginsert.jsp로 이동하려고 
		$("#actionForm").submit();
	});
	
	
});//document

function reloadList() {
	var params = $("#actionForm").serialize();
	console.log(params);
	$.ajax({
		url : "AGListAjax",  
		type:"POST",
		dataType : "json",
		data : params,
		success : function(res) {
			console.log("전체조회 성공");
			drawList(res.list);
			drawPaging(res.pd);
		},
		error: function(request, status, error) {
			console.log("전체조회 실패");
			console.log(request.responseText);
		}
	});
}

function drawList(list) {
	var html = "";
	
	for(var data of list){
		html +="<div class=\"picBox\">";
		if(typeof(data.PIC) != "undefined"){ //첨부파일이 있다면
			// html+= "<img class=\"lightboxed\" rel=\"group1\" src=\"resources/upload/\""+${data.PIC}+"\" alt=\"Image Alt\" data-caption=\"Image Caption\">";
			// 스크립트에서 ${data.PIC}는 사용 못함.(${param.gbn}이렇게 페이지 이동해서 값 받는 거는 가능.)
			// 스크립트꺼를 불러옴(jsp문법이랑 스크립트 문법은 다름.)
			// 스크립트로 ajax로 불러서 받은 거는 스크립트
			// jsp문법에서 스크립트를 못부름
			
			html +="<input type=\"hidden\" name=\"memNo\" value="+data.MEM_NO+"/>";
			html +="<input type=\"hidden\" name=\"noG\" id=\"noG\" value="+data.NO+"/>";
			
			html += "<img class=\"lightboxed\" rel=\"group1\" src=\"resources/upload/"+data.PIC+"\" data-link=\"resources/upload/"+data.PIC+"\" alt=\"Image Alt\" data-caption=\""+data.DESCRIPT+"\" />"; 
			
			html += "<div class=\"picBoxChildren\" no=\""+data.NO+"\">";
				html += "<input type=\"button\" id=\"detailBtn\" value=\"상세보기\"/>";
			html += "</div>";
			
		}
		html +="</div>";
	}
	
	$(".gallery_box").html(html);
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

	<c:import url="/testAHeader"/>
	
	<div class="container">
		<h1>그깽 사진 갤러리</h1>
		<div id="carbon-block" style="margin:30px auto">
	</div>

	<div style="margin:30px auto">
		<script type="text/javascript">
			<!--
			google_ad_client = "ca-pub-2783044520727903";
			/* jQuery_demo */
			google_ad_slot = "2780937993";
			google_ad_width = 728;
			google_ad_height = 90;
			//-->
		</script>
		
		<script type="text/javascript"
		src="https://pagead2.googlesyndication.com/pagead/show_ads.js">
		</script>
	</div>
	
	<p class="lead">2022</p>

	<br/>
	
	<div style="text-align: right;">
		<c:if test="${!empty sMemNo}">
			<hr>
			 <input type="button" id="insertBtn" value="등록"/>
			 <hr>
		</c:if>
	</div>
	
	<div class="gallery_box" id="gallery_box">
		<!-- 갤러리 -->
	</div>
	
	<div class="search_area">
		<form action="#" id="actionForm" method="post">
			<input type="hidden" id="no" name="no"/>
			<input type="hidden" id="page" name="page" value="${page}"/>
			
	
			<select name="searchGbn" id="searchGbn">
				<option value="0">제목</option>	
				<option value="1">작성자</option>	
			</select>
			
			<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}"/>
			
			<input type="button" id="searchBtn" value="검색"/> 
		</form>
	</div>
	
	
     <div class="paging_area">
     	<!-- 페이징 -->
     </div> 
	
	<!--
		<img class="lightboxed" rel="group1" src="https://www.jqueryscript.net/dummy/1.jpg" data-link="https://www.jqueryscript.net/dummy/1.jpg" alt="Image Alt" data-caption="Image Caption" />
		<br /><a href="https://www.jqueryscript.net/dummy/1.jpg" class="lightboxed">Text Link</a>
		<br /><a href="#inline" class="lightboxed">Inline content</a>
	 -->
	
	<div id="inline" style="display: none;">
		<div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%,-50%); color: #fff;">
			Some inline content
		</div>
	</div>
</div>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-36251023-1']);
  _gaq.push(['_setDomainName', 'jqueryscript.net']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<script>
try {
  fetch(new Request("https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js", { method: 'HEAD', mode: 'no-cors' })).then(function(response) {
    return true;
  }).catch(function(e) {
    var carbonScript = document.createElement("script");
    carbonScript.src = "//cdn.carbonads.com/carbon.js?serve=CK7DKKQU&placement=wwwjqueryscriptnet";
    carbonScript.id = "_carbonads_js";
    document.getElementById("carbon-block").appendChild(carbonScript);
  });
} catch (error) {
  console.log(error);
}
</script>

</body>
</html>