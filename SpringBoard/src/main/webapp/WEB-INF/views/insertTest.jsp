<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>Insert title here</title>
</head>
<body>

	<h2>Ajax 댓글 등록 테스트</h2>
	<!-- 댓글 작성 공간 -->
	<div>
		<div>
			댓글 글쓴이 <input type="text" name="replyer" id="newReplyWriter"/>
		</div>
		<div>
			댓글 내용 <input type="text" name="reply" id="newReplyText"/>
		</div>
		<button id="replyAddBtn">댓글 추가</button>
	</div>
	<hr/>
	<!-- 댓글이 추가될 공간 -->
	<div>
		<ul id="replies">
	
		</ul>
	</div>
	
	<!-- modal은 일종의 팝업입니다.
	단, 새 창을 띄우지는 않고 css를 이용해 특정 태그가 조건부로 보이거나 안 보이도록 처리해서
	마치 새 창이 새로 띄워지는것처럼 만듭니다. 따라서 눈에 보이지는 않아도 modal를 구성하는 태그 자체는
	화면에 미리 적혀있어야 합니다. -->
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
	
	
	<!-- jquery cdn -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script id="text/javascript">
		var bno = 342;
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
					str += "<li data-rno='" + this.rno + "' class='replyLi'>"
						+ this.rno + ":" + this.reply
						+ "<button>수정/삭제</button></li>";
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
			console.log(replytag);
			
			// 클릭한 버튼과 연계된 li 태그의 data-rno에 든 값을 가져와 변수 rno에 저장합니다.
			var rno = replytag.attr("data-rno");
			console.log(rno);
			
			// rno값 뿐만 아니라 본문도 가져와야합니다.
			var reply = replytag.text();// 내부 text를 가져와 reply 변수에 저장합니다.
			
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