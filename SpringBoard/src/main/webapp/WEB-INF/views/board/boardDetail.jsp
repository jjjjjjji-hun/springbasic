<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#modDiv{
		width: 300px;
		height: 100px;
		background-color: green;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-top: -50px;
		margin-left: -150px;
		padding:10px;
		z-index:1000;
	}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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
			
		<div class="row">
			<div class="col-md-3">	
				<a href="/board/boardList?pageNum=${param.pageNum == null ? 1 : param.pageNum }&searchType=${param.searchType}&keyword=${param.keyword}" class="btn btn-success">게시글 목록</a>
			</div>
			<div class="col-md-3">
				<form action="/board/boardUpdateForm" method="post">
					<input type="hidden" value="${board.bno}" name="bno"/>
					<input type="hidden" value="${param.pageNum}" name="pageNum"/>
					<input type="hidden" value="${param.searchType}" name="searchType"/>
					<input type="hidden" value="${param.keyword}" name="keyword"/>
					<input type="submit" value="글 수정하기" class="btn btn-warning"/>
				</form>
			</div>
			<div class="col-md-3">
				<form action="/board/boardDelete" method="post">
					<input type="hidden" value="${board.bno}" name="bno"/>
					<input type="hidden" value="${board.bno}" name="bno"/>
					<input type="hidden" value="${param.pageNum}" name="pageNum"/>
					<input type="hidden" value="${param.searchType}" name="searchType"/>
					<input type="hidden" value="${param.keyword}" name="keyword"/>
					<input type="submit" value="글 삭제하기" class="btn btn-danger"/>
				</form>
			</div>
		</div>

	<hr/>
	<!-- 댓글이 추가될 공간 -->
	<div class="row">
		<h3 class="text-primary">댓글</h3>
		<ul id="replies">
	
		</ul>
	</div>
	<hr/>
	<!-- 댓글 작성 공간 -->
	<h3>댓글 작성하기</h3>
	<div>
		<div>
			댓글 글쓴이 <input type="text" name="replyer" id="newReplyWriter"/>
		</div>
		<div>
			댓글 내용 <input type="text" name="reply" id="newReplyText"/>
		</div>
		<button id="replyAddBtn">댓글 추가</button>
	</div>
	
		<!-- 댓글 modal -->
		<div id="modDiv" style="display:none;">
			<div class="modal-title"></div>
			<div>
				<input type="text" id="reply">
			</div>
			<div>
				<button type="button" id="replyModBtn">수정</button>
				<button type="button" id="replyDelBtn">삭제</button>
				<button type="button" id="closeBtn">닫기</button>
			</div>
		</div>
	</div>
	<!-- jquery cdn -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<!--  여기부터 댓글 비동기 처리 자바스크립트 처리 영역 -->
	<script id="text/javascript">
		let bno = ${board.bno};
		$("#replyAddBtn").on("click", function(){
			
			// 폼이 없기때문에 input태그 내의 입력된 요소를 가져와야 합니다.
			// 버튼을 누르는 시점에 글쓴이와 내용 내부에 적힌 문자열을 변수에 저장합니다.
			var replyer = $("#newReplyWriter").val();
			var reply = $("#newReplyText").val();
			
			// $.ajax({내용물}); 이 기본 형태
			$.ajax({
				type : 'post', 
				url : '/replies', 
				headers : {
					"Content-type" : "application/json",
					"X-HTTP-Method-Override" : "POST"},
				dataType : 'text',
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					reply : reply
				}),
				success : function(result){
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
						getAllList();//댓글 등록 성공시, 다시 목록 갱신
						// 폼 태그 비우기.
						replyer = $("#newReplyWriter").val("");
						reply = $("#newReplyText").val("");
					}
				}
			});
		});
		
		// 전체 댓글 가져오기
		function getAllList(){
				$.getJSON("/replies/all/" + bno, function(data){
				let str= "";

					console.log(data.length);

				$(data).each(function(){
					// 4월 27일 시간 추가
					// 날짜 처리를 위해 자바스크립트의 Date 객체를 이용합니다.
					let timestamp = this.updateDate;
					let date = new Date(timestamp);
					let formattedTime = "게시일 : " + date.getFullYear()
										+ "/" + (date.getMonth()+1)
										+ "/" + date.getDate()
										+ "/" + date.getHours()
										+ "/" + date.getMinutes()
										+ "/" + date.getSeconds()
										
					str += "<div class='replyLi' data-rno='" + this.rno + "'><strong>@"
						// + this.rownum
						+ this.replyer + "</strong> - "+ formattedTime + "<br>"
						+ "<div class='reply'>" + this.reply + "</div>"
						+ "<button type='button' class='btn btn-info'>수정/삭제</button>"
						+ "</div>";
				});

				console.log(str);
				$("#replies").html(str);

				});
		}
		getAllList();// 댓글 전체를 들고와서 #replies에 심어주는 로직 실행
		
		// 이벤트 위임
		$("#replies").on("click", ".replyLi button", function(){
			// 클릭한 요소가 this이고, 현재 button에 걸렸기 때문에
			// this는 button 입니다. button의 부모가 바로 .replyLi 입니다.
			// 즉, 클릭한 버튼과 연계된 li 태그를 replytag 변수에 저장합니다.
			var replytag = $(this).parent();
			var replyContent = $(this).prev();
			// 4월 27일 수정 : this(button)의 부모(.replyLi)가 아닌
			// 형제 태그 .reply의 내용을 대신 가져올 수 있도록
			// 변수 replyContent를 선언해 거기에 저장해주세요.
			console.log(replytag);
			
			// 클릭한 버튼과 연계된 li 태그의 data-rno에 든 값을 가져와 변수 rno에 저장합니다.
			var rno = replytag.attr("data-rno");
			console.log(rno);
			
			// rno값 뿐만 아니라 본문도 가져와야합니다.
			var reply = replyContent.text();// 내부 text를 가져와 reply 변수에 저장합니다.
			
			//alert(rno + ":" + reply);// 내부 text와 댓글번호를 alert로 출력합니다.
			$(".modal-title").html(rno);// modal-title 부분에 글번호 입력
			$("#reply").val(reply);// reply 영역에 리플 내용을 기입(수정/삭제)
			$("#modDiv").show("slow");// 버튼 누르면 모달 열림
		});
		
		// modal 창 닫기 이벤트
		$("#closeBtn").on("click", function(){// #closeBtn 버튼 클릭시
			$("#modDiv").hide("slow");// #modDiv를 닫습니다.
		});
		
		// 삭제버튼 작동
		$("#replyDelBtn").on("click", function(){
			var rno = $(".modal-title").html();
			
			$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				header : {
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				success : function(result) {
					console.log("result : " + result);
					if(result == 'SUCCESS'){
						alert("삭제 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList();// 삭제된 댓글 반영한 새 댓글목록 갱신
					}
				}
			});
		});
		
		// 수정버튼 작동
		$("#replyModBtn").on("click", function(){
			let rno = $(".modal-title").html();
			let reply = $("#reply").val();// 댓글 내용을 가져와서 넣어줘야 수정 가능
			$.ajax({
				type : 'patch',
				url : '/replies/' + rno,
				header : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PATCH"
				},
				contentType : "application/json",// json 자료를 추가로 입력받기 때문에
				data : JSON.stringify({reply : reply}),
				dataType : 'text',
				success : function(result) {
					console.log("result : " + result);
					if(result == 'SUCCESS'){
						alert("수정 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList();// 삭제된 댓글 반영한 새 댓글목록 갱신
					}
				}
			});
		});
	</script>
</body>
</html>