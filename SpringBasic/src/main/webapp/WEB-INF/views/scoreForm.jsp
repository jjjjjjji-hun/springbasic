<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="http://localhost:8181/score" method="post">
		<input type="number" name="math" placeholder="수학 점수" required/><br/>
		<input type="number" name="english" placeholder="영어 점수" required/><br/>
		<input type="number" name="language" placeholder="언어 점수" required/><br/>
		<input type="number" name="history" placeholder="한국사 점수" required/><br/>
		<input type="number" name="computer" placeholder="컴퓨터 점수" required/><br/>
		<input type="submit" value="성적 제출"/>
	</form>
</body>
</html>