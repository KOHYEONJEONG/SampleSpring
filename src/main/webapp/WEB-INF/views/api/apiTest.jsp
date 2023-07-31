<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css"/>
<style type="text/css">
.wrap{
   width: 500px;
   margin: 0 auto;
}

body{
	overflow: auto;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	$("#btn").on("click", function() {
		$.get({
			url : "getAPIRequest",
			dataType : "json",
			success : function(result) {
				console.log(result);
				var rows = Object.values(result)[0].row; //javascript get object first value
				
				var html = "";
				for(var data of rows) {
					html += "<tr>";
					html += "<td>" + data.BPLCNM + "</td>";
					html += "<td>" + data.DTLSTATENM + "</td>";
					html += "<td>" + data.RDNWHLADDR + "</td>";
					html += "</tr>";
				}
				
				$("tbody").html(html);
				
			}
		});
	});
});

</script>
</head>
<body>
<input type="button" value="버튼" id="btn" />

<div class="wrap">
<div class="board_area">
		
		<table class="board_table">
			<colgroup>
				<col width="150">
				<col width="150">
				<col width="700">
			</colgroup>
			
			<thead>
				<tr>
					<th>상호</th>
					<th>영업상태</th>
					<th>주소</th>
				</tr>
			</thead>
			
			<tbody>
			</tbody>
		
		</table>
</div>
</div>
</body>
</html>