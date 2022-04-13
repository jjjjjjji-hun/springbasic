<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<form action="/boardUpdate" method="post">
			<h1>${board.bno}번 글 수정페이지</h1>
			<input type="hidden" name="bno" value="${board.bno}"/>
			글 제목 : <input type="text" name="title" value="${board.title}" required/><br/>
			글쓴이 : <input type="text" value="${board.writer}" readonly/><br/>
			쓴 날짜 : ${board.regdate}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			마지막 수정날짜 : ${board.updatedate}<br/><br/>
			본문 : <textarea name="content" rows="15" cols="30">${board.content }</textarea>
			<input type="submit" value="수정"/>&nbsp;&nbsp;&nbsp;<input type="reset" value="초기화"/>
		</form>
	</div>
</body>
</html>