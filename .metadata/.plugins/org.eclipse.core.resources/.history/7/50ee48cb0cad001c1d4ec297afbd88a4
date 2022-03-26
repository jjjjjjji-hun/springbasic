package com.ict.controller.di;

import org.springframework.context.support.GenericXmlApplicationContext;

import com.ict.controller.di.classfile.BalladSinger;
import com.ict.controller.di.classfile.Broadcast;
import com.ict.controller.di.classfile.PopSinger;
import com.ict.controller.di.classfile.Singer;
import com.ict.controller.di.classfile.Stage;

public class DIMainSpringver {

	public static void main(String[] args) {
		// root-context라는 공장에 저장된 객체를 뽑아서 써야합니다.
		// 1. 가져오기 위한 호출코드를 작성해보겠습니다.
		GenericXmlApplicationContext context =
				new GenericXmlApplicationContext("file:src/main/webapp/WEB-INF/spring/root-context.xml");
		// 2. 공장 내부 객체 가져오기
		// context.getBean("공장 내부 명칭", 클래스 파일명.class);
		//Singer singer = context.getBean("singer", Singer.class);
		// 3. 가져온 객체 사용하기
		//singer.sing();

		// 4. 여러분들이 직접 Stage를 가져다가 실행시키는 코드를 작성해주세요.
		//Stage stage = context.getBean("stage", Stage.class);
		//stage.perform();
		
		// 5. Broadcast
		//Broadcast broadcast = context.getBean("broadcast", Broadcast.class);
		//broadcast.onAir();
		
		// 6. 발라드 가수
		//BalladSinger balladsinger = context.getBean("balladSinger", BalladSinger.class);
		//balladsinger.sing();
		
		// 7. 수동생성 bean인 stage1 가져와서 사용하기
		Stage stage1 = context.getBean("Stage1", Stage.class);
		stage1.perform();
		
		Stage stage2 = context.getBean("Stage2", Stage.class);
		stage2.perform();
	}

}
