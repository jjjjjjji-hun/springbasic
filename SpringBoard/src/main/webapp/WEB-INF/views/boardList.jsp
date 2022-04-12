<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<h1>게시글 목록</h1>
	<table border="1" class="table table">
		<thead>
			<tr>
				<th>글 번호</th>
				<th>글 제목</th>
				<th>글 본문</th>
				<th>글쓴이</th>
				<th>글쓴 날짜</th>
				<th>글 수정 날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="board" items="${boardList}">
				<tr>
					<td>${board.bno}</td>
					<td><a href="/boardDetail?bno=${board.bno}">${board.title}</a></td>
					<td>${board.content}</td>
					<td>${board.writer}</td>
					<td>${board.regdate}</td>
					<td>${board.updatedate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="/boardInsert" class="btn btn-success">글쓰기</a>
</div>
${pageMaker}<br/>

		<!-- 이전 페이지 버튼 보일지 결정하는 부분 -->
		  <ul class="pagination justify-content-center">
		    <c:if test="${pageMaker.prev}">
		    	<li class="page-item">
		      		<a class="page-link" href="/boardList?pageNum=${pageMaker.startPage-1}">Previous</a>
		    	</li>
		    </c:if>
		    
		<!-- 밑에 깔아줄 버튼들 -->
		    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
				<li class="page-item ${pageMaker.cri.pageNum == idx ? 'active' : '' }">
					<a class="page-link" href="/boardList?pageNum=${idx}">${idx }</a>
				</li>
			</c:forEach>

		<!-- 다음 페이지 버튼 보일지 결정하는 부분 -->
			<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
			    <li class="page-item">
			      <a class="page-link" href="/boardList?pageNum=${pageMaker.endPage + 1}">Next</a>
			    </li>
			</c:if>
		  </ul>
</body>
</html>