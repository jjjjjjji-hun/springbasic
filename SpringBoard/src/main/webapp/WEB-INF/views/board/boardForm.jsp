<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.uploadResult{
	width:100%;
	background-color: gray;
	}
	.uploadResult ul{
	display : flex;
	flex-flow : row;
	justify-content : center;
	align-items: center;
	}
	.uploadResult ul li{
	list-style : none;
	padding : 10px;
	}
	.uploadResult ul li img{
	width : 20px;
	}
</style>
<script src="/resources/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- /boardInsert로 보내는 post 방식 폼을 생성해주세요.
	폼에서 보내는 요소의 name 속성값은 쿼리문을 참조해서 만들어주세요.
	Insert로직을 실행하는 컨트롤러도 생성해주시고 return 값은"";로 우선 두겠습니다. -->
	<div class="container">
		<form action="/board/boardInsert" method="post">
			글 제목 : <input type="text" name="title" required/><br/>
			글쓴이 : <input type="text" name="writer" required/><br/>
			본문 : <textarea name="content" rows="15" cols="30"></textarea>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }"/>
			<input id="submitBtn" type="submit" value="글쓰기"/>&nbsp;&nbsp;&nbsp;<input type="reset" value="초기화"/>
		</form>
	</div>
	<h3>첨부파일 영역</h3>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<div class="uploadResult">
		<ul>
			<!-- 업로드된 파일이 들어갈 자리 -->
		</ul>
	</div>
	<button id="uploadBtn">Upload</button>
	

	<script>
		var csrfHeaderName = "${_csrf.headerName}"
		var csrfTokenValue="${_csrf.token}"
		$(document).ready(function(){
									// .(문자한개)*(개수제한없음) \. (.을  아무문자 1개가 아닌 . 자체로 쓸때)
									// "(.*?)@(.*?)\.(com|net)$" <- 이메일 검증 정규표현식
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; // 5MB
			
			function checkExtension(fileName, fileSize){
				if(fileSize >= maxSize){
					alert("파일 사이즈 초과");
					return false;
				}
				
				if(regex.test(fileName)){
					alert("해당 종류의 파일은 업로드 할 수 없습니다.");
					return false;
				}
				return true;
			}
			
			var cloneObj = $(".uploadDiv").clone();
			
			$("#uploadBtn").on("click", function(e){
				let formData = new FormData();
				let inputFile = $("input[name='uploadFile']");
				let files = inputFile[0].files;
				console.log(files);
				
				// 파일 데이터를 폼에 집어넣기
				for(var i = 0; i < files.length; i++){
					if(!checkExtension(files[i].name, files[i].size)){
						return false;
					}
					
					formData.append("uploadFile", files[i]);
				}
				
				$.ajax({
					url : '/uploadAjaxAction',
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					dataType : 'json',
					success : function(result){
						console.log(result);
						
						showUploadedFile(result);
						// 업로드 성공 시 미리 복사해둔 .uploadDiv로 덮어씌워서 첨부파일이 없는 상태로 되돌리기
						$(".uploadDiv").html(cloneObj.html())
						alert("Uploaded");
					}
				});//ajax
			});// onclick uploadBtn
			
			var uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr){
				var str = "";
				
				$(uploadResultArr).each(function(i, obj){
					// BoardAttachVO내부에서 이미지여부를 fileType변수에 저장하므로 obj.image -> obj.fileType
					if(!obj.fileType){
						
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						
						str += "<li "
							+ "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid
							+ "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType
							+ "'><a href='/download?fileName=" + fileCallPath
							+ "'>" + "<img src='/resources/attach.jpg'>"
							+ obj.fileName + "</a>"
							+ "<span data-file=\'" + fileCallPath + "\' data-type='file'> X </span>"
							+ "</li>";
					}else{
						//str += "<li>" + obj.fileName + "</li>"
						// 수정 코드
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						var fileCallPathOriginal = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						
						str += "<li "
							+ "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid
							+ "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType
							+ "'><a href='/download?fileName=" + fileCallPathOriginal
							+ "'>" + "<img src='/display?fileName=" + fileCallPath 
							+ "'>" + obj.fileName + "</a>"
							+ "<span data-file=\'" + fileCallPath + "\' data-type='image'> X </span>"
							+ "</li>";
						
					}
					
				});
				uploadResult.append(str);
			}// showUploadedFile			
			
			$(".uploadResult").on("click", "span", function(e){
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				
				var targetLi = $(this).closest("li");
				
				$.ajax({
					url : '/deleteFile',
					beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					data : {fileName : targetFile, type : type},
					dataType : 'text',
					type : 'POST',
					success : function(result){
						alert(result);
						targetLi.remove();
					}
				})//ajax
			});//click span
			
			// 글쓰기 버튼 클릭 시, 첨부파일 정보를 폼에 추가해서 전달하는 코드
			$("#submitBtn").on("click", function(e){
				// 1. 글쓰기버튼을 눌렀을때 바로 작동하지 않도록 기능 막기
				e.preventDefault();
				
				// 2. var formObj = $("form"); 로 폼태그를 가져옵니다
				var formObj = $("form");
				
				// formObj내부에 hidden 태그들을 순서대로 만들어줍니다.
				var str="";
				
				// 3. 5월 19일 수업에서는 첨부파일 내에 들어있던 이미지 정보를 콘솔에 찍기만 하고 종료하고
				// 내일 수업에 DB에 넣는부분까지 진행합니다.
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					console.log(jobj);
					str += "<input type='hidden' name='attachList[" + i + "].fileName'"
						+ " value='" + jobj.data("filename") + "'>"
						+ "<input type='hidden' name='attachList[" + i + "].uuid'"
						+ " value='" + jobj.data("uuid") + "'>"
						+ "<input type='hidden' name='attachList[" + i + "].uploadPath'"
						+ " value='" + jobj.data("path") + "'>"
						+ "<input type='hidden' name='attachList[" + i + "].fileType'"
						+ " value='" + jobj.data("type") + "'>"				
				});
				// 폼태그에 위의 str내부 태그를 추가해주는 명령어, .submit() 을 추가로 넣으면 제출 완료
				formObj.append(str).submit();
			});
			
		});// document
		
		
	</script>
	
</body>
</html>