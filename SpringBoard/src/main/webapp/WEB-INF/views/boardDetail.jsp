<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>${board.bno}번 게시글 상세 페이지</h1>
	글 번호 : <input type="text" value="${board.bno}" readonly/>
	글 제목 : <input type="text" value="${board.title}"/>
	글쓴이 : <input type="text" value="${board.writer}" readonly/><br/><br/>
	쓴날짜 : ${board.regdate}&nbsp;&nbsp;&nbsp;
	마지막 수정날짜 : ${board.updatedate}<br/><br/>
	글 본문 : <textarea rows="15" cols="30">${board.content}</textarea>
	
</body>
</html>