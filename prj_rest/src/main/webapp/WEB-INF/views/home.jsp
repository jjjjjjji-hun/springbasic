<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

<button id="getAPI">영화 정보 가져오기</button>
<!--  버튼 클릭시 영화정보를 movieData에 넣도록 해주세요. -->
<div id="movieDataDiv">

</div>
<!-- jquery cdn -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	// 모던 js(es6)에서는 var대신 let과(변수) const(상수) 를 사용해 변수를 선언합니다.
	// 장점은 변수 호이스팅(지역 간섭 문제)에서 자유로운 자료를 사용할 수 있다는 것입니다.
	let movieData= "";
	// http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101
	// 접속용 키는 변동될 일이 없으므로 const로 선언해 상수처리합니다.
	const apiKey ="f5eef3421c602c6cb7ea224104795888";
	// 날짜는 변동될 수 있으므로 let으로 저장합니다.
	let getDt = "20120101";
	
	// 자바 스크립트에서 포맷팅을 쓸 때는 백틱(`)으로 문자열을 감싸주신다음
	// 포맷팅 데이터가 들어갈 자리에는 \${변수명}을 적습니다.
	// getJSON 등으로 얻어온 데이터는 포맷팅 적용이 잘 안됩니다.
	// .jsp에서는 el과 문법이 충돌하므로 $앞에 \를 붙여줍니다.
	let requestUrl = 
		`http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\${apiKey}&targetDt=\${getDt}`;
	console.log(requestUrl);
		
	// 화살표 함수는 (파라미터) => (실행문); 형식으로 작성합니다.
	// 익명함수만 화살표 함수로 만들 수 있습니다. 역시 모던 js에서 사용하는 문법입니다.
	// 화살표 함수는 this키워드를 가지지 않으므로 이벤트 위임 등 this를 사용하는 로직은
	// 어쩔 수 없이 function(파라미터){ 실행문 }; 형식을 그대로 사용해야 합니다.
	
	let movieDataDiv = $("#movieDataDiv");
	$("#getAPI").on("click", function(){
		$.getJSON(requestUrl, (data) =>{
			console.log(data);
			strApiData = data.boxOfficeResult.dailyBoxOfficeList;
			for(let i = 0; i < strApiData.length; i++){
				movieData += strApiData[i].movieNm + ", ";
			}
				console.log(movieData);
				movieDataDiv.html(movieData);
			});
		});
	
</script>
</body>
</html>
