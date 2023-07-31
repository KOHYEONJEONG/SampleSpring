<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- taglib : 커스텀 태그를 사용하겠다. -->
<!-- prefix : 사용할 태그 명칭 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.nickName{
	text-align: right;
	font-size: 14px;
	padding: 10px;
}
</style>

<script>
	$(document).ready(function() {
		$("#logoutBtn").on("click", function() {
			location.href="testALogout";
		});
		
		$("#loginBtn").on("click", function() {
			location.href = "testALogin";
		});
		
	});
</script>
<div class="nickName">
<c:choose>
	<c:when test="${empty sMemNm}"> <!-- el태그의 empty : 해당 값이 비어있는지를 확인 -->
		<!-- 세션이 비어있다면 -->
		<input type="button" value="로그인" id="loginBtn"/>
	</c:when>
	<c:otherwise>
		${sMemNm}님 어서오세요!!
		<input type="button" value="로그아웃" id="logoutBtn"/>	
	</c:otherwise>
</c:choose>
</div>