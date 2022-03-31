<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="http://localhost:8181/userInfo" method="post">
		유저 번호 : <input type="number" name="userNum" required/><br/>
		유저 아이디 : <input type="text" name="userId" required/><br/>
		유저 비밀번호 : <input type="text" name="userPw" required/><br/> 
		유저 이름 : <input type="text" name="userName" required/><br/> 
		유저 나이 : <input type="number" name="userAge" required/><br/>
		<input type="submit" value="제출"/>
	</form>
</body>
</html>