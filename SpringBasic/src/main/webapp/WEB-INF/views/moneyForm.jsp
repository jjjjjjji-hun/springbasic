<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="http://localhost:8181/getMoney" method="post">
		<input type="number" name="won" placeholder="원" dir="rtl"/><!-- dir 오른쪽 정렬 -->
		<input type="submit" value="환전"/>
	</form>
</body>
</html>