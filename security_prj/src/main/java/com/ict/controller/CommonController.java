package com.ict.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {

	// 사용자가 직접 접근하지 않고 이용하다가 저절로 끌려 들어갈 주소 값에 대해서만 
	// CommonController에 코드를 작성합니다.
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("접근 거부 : " + auth);
		model.addAttribute("errorMessage", "접근 거부");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error 여부 : " + error);
		log.info("logout 여부 : " + logout);
		
		if(error != null) {
			model.addAttribute("error", "로그인 관련 에러입니다. 계정확인을 다시해주세요.");
		}
		if(logout != null) {
			model.addAttribute("logout", "로그아웃 했습니다.");
		}
	}
}
