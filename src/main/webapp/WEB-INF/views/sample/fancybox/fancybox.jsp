<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Fancybox Sample</title>
<link rel="shortcut icon" href="resources/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<!-- fancybox css -->
<link type="text/css" rel="stylesheet" href="resources/css/jquery/jquery.fancybox.css" />
<!-- jQuery Script -->
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
		src="resources/script/common/common.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.fancybox.js"></script>
<!-- fancybox 스크립트 -->
<script type="text/javascript">
$(document).ready(function() {
	$("a[name='ori_img']").each(function(i) {
		$(this).css("cursor", "pointer");
	}).fancybox({
		openEffect	: 'elastic',
    	closeEffect	: 'elastic',
    	title : null
    	/* helpers : {
    		title : {
    			type : 'inside'
    		}
    	} */
	});
});
</script>
</head>
<body>
<div class="cmn_title">Fancybox 샘플<div class="cmn_btn_mr float_right_btn" id="sampleListBtn">샘플목록</div></div>
	<a rel="gallery1" name="ori_img" href="resources/images/kitty.png" title="고양이"><img alt="고양이" name="images" src="resources/images/kitty.png"></a>
	<a rel="gallery1" name="ori_img" href="resources/images/pic.jpg" title="피자">
		<img alt="피자" name="images3" src="resources/images/pic.jpg" style="width: 300px; height: 200px;" />
	</a>
</body>
</html>













