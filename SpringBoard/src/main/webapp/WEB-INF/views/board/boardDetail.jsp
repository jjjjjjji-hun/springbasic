<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h1 class="text text=primary">${board.bno}번 게시글 상세 페이지</h1>
		글 번호 : <input type="text" class="form-control" value="${board.bno}" readonly/>
		글 제목 : <input type="text" value="${board.title}" readonly/>
		글쓴이 : <input type="text" value="${board.writer}" readonly/><br/><br/>
		글 본문 : <textarea rows="15" class="form-control" readonly>${board.content}</textarea>
		<div class="row">
			<div class="col-md-6">쓴날짜 : ${board.regdate}&nbsp;&nbsp;&nbsp;</div>
			<div class="col-md-6">마지막 수정날짜 : ${board.updatedate}</div><br/><br/>
		</div>
			
		<a href="/board/boardList?pageNum=${param.pageNum == null ? 1 : param.pageNum }&searchType=${param.searchType}&keyword=${param.keyword}" class="btn btn-success">게시글 목록</a>
		
		<form action="/board/boardUpdateForm" method="post">
			<input type="hidden" value="${board.bno}" name="bno"/>
			<input type="hidden" value="${param.pageNum}" name="pageNum"/>
			<input type="hidden" value="${param.searchType}" name="searchType"/>
			<input type="hidden" value="${param.keyword}" name="keyword"/>
			<input type="submit" value="글 수정하기" class="btn btn-warning"/>
		</form>
		
		<form action="/board/boardDelete" method="post">
			<input type="hidden" value="${board.bno}" name="bno"/>
			<input type="hidden" value="${board.bno}" name="bno"/>
			<input type="hidden" value="${param.pageNum}" name="pageNum"/>
			<input type="hidden" value="${param.searchType}" name="searchType"/>
			<input type="hidden" value="${param.keyword}" name="keyword"/>
			<input type="submit" value="글 삭제하기" class="btn btn-danger"/>
		</form>
	</div>
</body>
</html>