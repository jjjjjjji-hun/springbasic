<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>Ajax 테스트</h2>
	
	<ul id="replies">
	
	</ul>
	
	<ul id="test">
		<!-- #test 사이에 daum.net으로 이동하는 a태그를 jquery를 이용해 넣어주세요. -->
	</ul>
	<button id="testBtn">테스트</button>
	<!-- jquery cdn 로드 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		let bno = 342;
						// 주소				// 콜백함수 주소 요청으로 얻어온 json을 어떻게 처리할지
		$.getJSON("/replies/all/" + bno, function(data){
			// 문자열을 이용해 태그를 생성하거나 끼워넣을 수 있으므로
			// 빈 문자열을 만들어놓고 거기에 댓글 정보를 지정해 화면에 전송
			let str= "";
			
			// 데이터를 제대로 들고 왔는지 디버깅
			console.log(data.length);
			
			// 들고 온 데이터를 반복해서 출력하기
			// #(JSON형식데이터).each => 내부 JSON을 향상된 for문 형식으로 처리합니다.
		 	// 역시 내부에 콜백함수(로직이  실행되었을때 추가로 실행할 구문을 정의하기 위해 파라미터로 넣는 함수)를 이용해
		 	// data를 하나하나 향상된 for문 형식으로 처리할 때 실행구문을 적을 수 있습니다.
			$(data).each(function(){
				// 하나하나 반복되는 각 데이터는 this라는 키워드로 표현됩니다.
					//console.log("------------");
					//console.log(this);
						str += "<li data-rno='" + this.rno + "' class='replyLi'>"
						+ this.rno + ":" + this.reply
						+ "</li>";
					});
			// #replies사이에 끼워넣을 수 있도록 console.log()로 디버깅
			console.log(str);
			$("#replies").html(str);
			
		});
						
			// 버튼(testBtn) 클릭시 발동되는 이벤트
				// testBtn 버튼 클릭 시     / 43~49번 라인 실행
			$("#testBtn").on("click", function(){
				//1. #test에 넣어줄 문자를 생성합니다.
				let daum = "<a href='http://www.daum.net'>다음으로 가기</a>";
				
				//2. #test를 jquery로 잡고, 태그 내부에 daum을 채워줌
				$("#test").html(daum);
			})
	</script>
</html>