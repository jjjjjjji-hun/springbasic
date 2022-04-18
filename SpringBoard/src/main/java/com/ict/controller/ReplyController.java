package com.ict.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ict.domain.ReplyVO;
import com.ict.service.ReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {

	@Autowired
	private ReplyService service;
	
	// consumes는 이 메서드의 파라미터를 넘겨줄때 어떤 형식으로 넘겨줄지를 설정하는데 기본적으로
	// rest방식에서는 json을 사용합니다. produces는 입력받은 데이터를 토대로 로직을 실행한 다음
	// 사용자에게 결과로 보여줄 데이터의 형식을 나타냅니다.
	// jackson-databind 추가해야 작동
	@PostMapping(value="", consumes="application/json", 
							produces= {MediaType.TEXT_PLAIN_VALUE})
	// produces에 TEXT_PLAIN_VALUE를 줬으므로 결과코드와 문자열을 넘김
	public ResponseEntity<String> register
						// rest컨트롤러에서 받는 파라미터 앞에 @RequestBody 어노테이션이 붙어야
						// Consumes와 연결됨
						(@RequestBody ReplyVO vo){
		// 에러 나는 경우랑 안 나는 경우를 대비해서 빈 ResponseEntity를 생성
		ResponseEntity<String> entity = null;
		try {
			// 먼저 글쓰기 로직 실행 후 에러가 없다면
			service.addReply(vo);
			// 성공했을때 띄울 ResponseEntity 생성
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			// catch로 넘어왔다라는건 글쓰기 로직에 문제가 생긴 상황
			// 에러메시지와 함께 ResponseEntity 생성
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		// 위의 try블럭이나 catch블럭에서 얻어온 entity변수 리턴
		return entity;
	}
}
