<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Restful Sample</title>
<link rel="shortcut icon" href="resources/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<style type="text/css">
#res {
	resize: none;
	border: 1px solid #444;
	margin: 10px;
}
</style>
<!-- jQuery Script -->
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
		src="resources/script/common/common.js"></script>
		
<script type="text/javascript">
$(document).ready(function() {
	$("#getListBtn").on("click", function() {
		$.ajax({ //rest부르는 방법은 동일하네~!
            url: "restApi", //RestfulController.java로 이동~
            method: "GET",
            dataType: "json",
            success: function (res) {
            	let txt = "";
            	txt += "==============\n";
            	txt += "GET Test Data\n";
            	txt += "==============\n";
            	
            	for(const data of res) {
            		txt += data + "\n";
            	}
            	
            	txt += "==============\n";
            	
                $('#res').append(txt);
            }
        });//ajax
	});//getListBtn
	
	$("#postListBtn").on("click", function() {
		$.ajax({
            url: "restApi", //RestfulController.java로 이동~
            method: "POST",
            dataType: "json",
            success: function (res) {
            	let txt = "";
            	txt += "==============\n";
            	txt += "POST Test Data\n";
            	txt += "==============\n";
            	
            	for(const data of res) {
            		txt += data + "\n";
            	}
            	
            	txt += "==============\n";
            	
                $('#res').append(txt);
            }
        });
	});
	$("#putBtn").on("click", function() {
		$.ajax({
            url: "restApi", //RestfulController.java로 이동~
            method: "PUT",
            dataType: "text",
            success: function (res) {
            	console.log("aaaaa");
            	console.log(res);
            	let txt = "Add : " + res + "\n";
            	
                $('#res').append(txt);
            }
        });
	});
	$("#patchBtn").on("click", function() {
		$.ajax({
            url: "restApi", //RestfulController.java로 이동~
            method: "PATCH",
            dataType: "text",
            success: function (res) {
				let txt = "Update : " + res + "\n";
            	
                $('#res').append(txt);
            }
        });
	});
	$("#deleteBtn").on("click", function() {
		$.ajax({
            url: "restApi", //RestfulController.java로 이동~
            method: "DELETE",
            dataType: "json",
            success: function (res) {
            	let txt = "";
            	txt += "==============\n";
            	txt += "Delete Result Data\n";
            	txt += "==============\n";
            	
            	for(const data of res) {
            		txt += data + "\n";
            	}
            	
            	txt += "==============\n";
            	
                $('#res').append(txt);
            }
        });
	});
});
</script>
</head>
<body>
<div class="cmn_title">Rest Api 샘플<div class="cmn_btn_mr float_right_btn" id="sampleListBtn">샘플목록</div></div>
<div>
	<div class="cmn_btn_ml" id="getListBtn">GetList</div>
	<div class="cmn_btn_ml" id="postListBtn">PostList</div>
	<div class="cmn_btn_ml" id="putBtn">PutOne</div>
	<div class="cmn_btn_ml" id="patchBtn">PatchTop</div>
	<div class="cmn_btn_ml" id="deleteBtn">DeleteTop</div>
</div>
<textarea rows="20" cols="50" id="res" readonly="readonly"></textarea>
</body>
</html>













