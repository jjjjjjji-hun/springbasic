package com.ict.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ict.domain.TestVO;

@RestController
// 클래스 위에 붙인 RequestMapping은 해당 컨트롤러의 공통된 진입주소를 설정해줍니다.
@RequestMapping("/test")
public class TestController {

	// 문자열
	@RequestMapping("/hello")
	public String sayHello() {
		return "Hello Hello";
	}
	
	// 객체 Json문서
	@RequestMapping("/sendVO")
	public TestVO sendTestVO() {
		TestVO testVO = new TestVO();
		
		testVO.setName("김자바");
		testVO.setAge(24);
		testVO.setMno(1);
		return testVO;
	}
	
	// 객체 리스트
	@RequestMapping("/sendVOList")
	public List<TestVO> sendVOList(){
		List<TestVO> list = new ArrayList<>();
		for(int i = 0; i < 10; i++) {
			TestVO vo = new TestVO();
			vo.setMno(i);
			vo.setName(i + "자바");
			vo.setAge(20 + i);
			list.add(vo);
		}
		return list;
	}
	
	// Map
	@RequestMapping("/sendMap")
	public Map<Integer, TestVO> sendMap(){
		Map<Integer, TestVO> map = new HashMap<>();
		for(int i = 0; i < 10; i++) {
			TestVO vo = new TestVO();
			vo.setName("자바");
			vo.setMno(i);
			vo.setAge(50 + i);
			map.put(i, vo);
		}
		return map;
	}
	
	// 400에러
	@RequestMapping("/sendErrorAuth")
	public ResponseEntity<Void> sendListAuth(){
		// ResponseEntity<Void> result = new REsponseEntity<>(HttpStatus.BAD_REQUEST);
		// return result;  
		// 위 두줄을 아래 처럼 익명클래스로 처리해도 상관없습니다.
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
	
	// 에러와 데이터 동시에 전달
	@RequestMapping("/sendErrorNot")
	public ResponseEntity<List<TestVO>> sendListNot(){
		List<TestVO> list = new ArrayList<>();
		for(int i = 0; i < 10; i++) {
			TestVO vo = new TestVO();
			vo.setMno(i);
			vo.setName(i + "자바");
			vo.setAge(20 + i);
			list.add(vo);
		}
		return new ResponseEntity<List<TestVO>>(list, HttpStatus.NOT_FOUND);
	}
}
