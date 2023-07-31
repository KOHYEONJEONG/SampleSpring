<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FileUpload Test</title>
<link rel="shortcut icon" href="resources/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<style type="text/css">
.wrap {
	width: 700px;
	margin: 0 auto;
}

.btn_wrap {
	height: 30px;
}

#uploadInfo {
	margin-top: 10px;
	padding: 5px;
	width: calc(100% - 10px);
	height: 80px;
	overflow: auto;
	border: 1px solid #7b7b7b;
	font-size: 10.5pt;
}
</style>
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
		src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" 
		src="resources/script/common/common.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#uploadBtn").on("click", function(){
		var fileForm = $("#fileForm");
		// ajaxForm : form의 동작을 동기화에서 비동기화 방식으로 변경(추가적으로 옵션만 적어주면 됨., $.ajax({..})보다 간편함.(그치만 파일업로드할때만 사용함))
		fileForm.ajaxForm({
			success: function(res){
				if(res.result =="SUCCESS"){
					alert("저장완료");
					
					console.log(res);
					if(res.fileName.length > 0) {
						let html = "";
						for(file of res.fileName) {
							html += "<a href=\"resources/upload/" + file + "\" download>" + file + "</a><br/>";
						}
						
						$("#uploadInfo").append(html);
					}
					
				} else {
					alert("저장실패");
				} 
			}, //ajax error
			error: function(){
				alert("에러발생!!"); 
			}
		});
		
		fileForm.submit();
	});
});
</script>
</head>
<body>
	<div class="cmn_title">파일 업로드/다운로드 샘플<div class="cmn_btn_mr float_right_btn" id="sampleListBtn">샘플목록</div></div>
	<!-- 
		enctype : form전송 데이터 형태
		multipart : 파일데이터를 포함한 형태
	 -->
	<div class="wrap">
		<form id="fileForm" name="fileForm" action="fileUploadAjax" 
			  method="post" enctype="multipart/form-data">
			
			<div class="headline">첨부파일</div>
			
			<table class="board_detail_table">
				<colgroup>
					<col width="100" />
					<col width="600" />
				</colgroup>
				<tbody>
				<tr>
					<th>첨부파일1</th>
					<td class="board_cont_left"><input type="file" name="attFile1" size="85" /></td>
				</tr>
				<tr>
					<th>첨부파일2</th>
					<td class="board_cont_left"><input type="file" name="attFile2" size="85" /></td>
				</tr>
				<tr>
					<th>첨부파일3</th>
					<td class="board_cont_left"><input type="file" name="attFile3" size="85" /></td>
				</tr>
				</tbody>
			</table>
		</form>
	
		<div class="btn_wrap">
			<div class="cmn_btn_ml float_right_btn" id="uploadBtn">저장</div>
		</div>
		
		<div class="headline">첨부결과</div>
		<div id="uploadInfo"></div>
	</div>
</body>
</html>