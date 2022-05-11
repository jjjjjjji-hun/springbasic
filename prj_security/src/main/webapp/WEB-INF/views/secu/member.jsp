<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>member 주소</h2>
	
	<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
	<!-- 로그인 안한(익명) 사용자인 경우 -->
		<a href="/secu/admin">admin페이지로</a>
	</sec:authorize>
	
	<a href="/customLogout">로그아웃 페이지 이동</a>
</body>
</html>