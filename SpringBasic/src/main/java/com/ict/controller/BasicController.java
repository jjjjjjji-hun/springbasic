package com.ict.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

// 어노테이션 네 종류가 있었는데(@Component, @Repository, @Controller, @Service)
// 컨트롤러를 만드는 경우이니 당연히 @Controller를 씁니다.
@Controller
public class BasicController {

	//RequestMapping의 value는 localhost:8181/어떤주소 로 접속시 해당 로직이 실행될지 결정합니다.
	// 아무것도 안 적으면 기본적으로 get 방식을 허용합니다.
	@RequestMapping(value="/goA")
	// 아래에 해당 주소로 접속시 실행하고 싶은 메서드를 작성합니다.
	public String goA() {
		System.out.println("goA 접속이 감지되었습니다.");
		// return "goA"; 라고 적으면 views폴더 내부의 goA.jsp파일을 보여줍니다.
		return "goA";
	}
	
	// goB로 접속했을때 b.jsp 창이 열리도록 아래에 세팅해주세요.
	@RequestMapping(value="/goB")
	public String goB() {
		System.out.println("goB 접속이 감지되었습니다.");
		return "b";
	}
	
	// 여러분들의 성함 성씨 기준으로 패턴을 잡고
	// 결과 페이지는 "XXX의 페이지입니다." 라는 문장이 뜨도록 처리해서 메서드와 어노테이션을 적용합니다.
	@RequestMapping(value="/Kim")
	public String name() {
		return "Kim";
	}
	
	// 외부에서 전송하는 데이터는 메서드 선언부에 선언된 변수로 받습니다.
	// 이름만 일치하면 알아서 받아옵니다.
	// 자료형을 신경쓸 필요가 없습니다.
	@RequestMapping(value="/getData", method=RequestMethod.POST)// localhost:8181/getData
					    // /getData?data1=데이터1&data2=데이터2 에 해당하는 요소를 받아옵니다.
	public String getData(String data1, int data2, Model model) {
		System.out.println("data1에 든 값 : " + data1);
		System.out.println("data2에 든 값 : " + data2);
		System.out.println("data2가 정수임을 증명 : " + (data2+100));
		// data1, data2 변수를 getResult.jsp로 보내서 위 콘솔 메세지를 화면에서 조회 가능하게 하기
		model.addAttribute("data1", data1);
		model.addAttribute("data2", data2);
		return "getResult";
	}
	
	// 외부에서 전송하는 데이터를 /getMoney 주소로 받아오겠습니다.
	// 이 주소는 int won 이라는 형식으로 금액을 받아서
	// 환율에 따른 환전금액을 콘솔에 찍어줍니다. 환전화폐는 임의로 정해주세요.
	// 결과페이지는 exchange.jsp로 하겠습니다.
	// 메서드명은 임의로 만들어주세요.
	@RequestMapping(value="/getMoney", method=RequestMethod.POST)//post방식으로만 받도록 처리
						// 포워딩시 바인딩을 하고 싶다면 Model을 선언합니다.
	public String getMoney(int won, Model model) {
		System.out.println("입력한 금액은 " + won + " 입니다.");
		System.out.println("현재 달러화 환율은 1,220원 당 1달러입니다.");
		System.out.println("입력한 금액에 따른 환전금액은 " + won/1220 + " 달러입니다.");
		double result = (won/1220);
		// model.addAttribute("보낼 이름", 보낼 자료);
		// 넘어간 데이터는 .jsp파일에서 el을 이용해 출력합니다.
		// ex) model.addAttribute("test", 자료);로 바인딩한 경우
		// ${test}로 .jsp에서 출력 가능
		model.addAttribute("result", result);
		// won 벼눗에 해당하는 변수도 추가로 보내기
		model.addAttribute("won", won);
		// exchange.jsp를 타겟으로 하니 views 폴더에 생성
		return "exchange";
	}
	
	// form 페이지와 결과페이지를 분리해야 합니다.
	// 다만 목적지 주소가 .jsp기준이 아닌, @RequestMapping상의 주소 기준으로 갑니다.
	// 주소 moneyForm으로 연결되도록 아래에 어노테이션 + 메서드를 구성해주세요.
	@RequestMapping(value="/moneyForm")
	public String moneyForm() {
		return "moneyForm";
	}
	// moneyForm.jsp로 연결됩니다.
	// moneyForm.jsp 에는 목적지를 #으로 하고
	// name-won 인 폼을 추가로 만들어주세요.
	
	
	// 상단 /getData 주소를 타겟으로 하는 /dataFrom을 만들어주세요.
	// data1, data2를 자료형에 맞게 폼으로 입력받아 전송버튼을 누르면
	// 해당 데이터가 결과 페이지에 나올수 있도록 .jsp 파일부터 시작해서
	// form태그나 세부 로직까지 완성시켜주세요.
	@RequestMapping(value="/dataForm")
	public String dataForm() {
		return "dataForm";
	}
	
	// 스프링 5버전부터 허용
	// @요청 메서드Mapping 은 해당 메서드만 허용하는 어노테이션입니다.
	@GetMapping(value="/onlyGet") // (Form은 보통 get방식으로 접근)
	public String onlyGet() {
		return "onlyGet";
	}
	
	@PostMapping(value="/onlyPost")
	public String onlyPost() {
		return "onlyPost";
	}
	
	@GetMapping(value="/score") 
	public String scoreForm() {
		return "scoreForm";
	}
	
	@PostMapping(value="/score")
	public String scoreResult(int math, int english, int language, int history, int computer, Model model) {
		int total = (math + english + language + history + computer); //총점
		double avg = (total / 5.0); // 평균
		model.addAttribute("math", math);
		model.addAttribute("english", english);
		model.addAttribute("language", language);
		model.addAttribute("history", history);
		model.addAttribute("computer", computer);
		model.addAttribute("total", total);
		model.addAttribute("avg", avg);
		return "scoreResult";
	}
}