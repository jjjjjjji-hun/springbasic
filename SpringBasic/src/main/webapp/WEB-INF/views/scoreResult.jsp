<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>성적 결과!</h1>
<h3>과목별 성적</h3>
수학 : ${math}, 영어 : ${english}, 언어 : ${language}, 한국사 : ${history}, 컴퓨터 : ${com}<hr/>
<h3>총 점</h3>
${total}<hr/>
<h3>평균</h3>
${avg}
</body>
</html>