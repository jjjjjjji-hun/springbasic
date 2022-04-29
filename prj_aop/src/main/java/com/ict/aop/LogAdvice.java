package com.ict.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {

	// excution( *은 접근제한자 / 가운데는 어느 패키지 어느 클래스까지 / 뒤의 *은 클래스명, 메서드명, 파라미터 종류
	@AfterReturning("execution(* com.ict.service.SampleService*.*(..))")// 표현식
	public void logBefore() {
		log.info("===============");
	}
	
	@Before("execution(* com.ict.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		log.info("str1 : " + str1);
		log.info("str2 : " + str2);
	}
	
	@AfterThrowing(pointcut = "execution(* com.ict.service.SampleService*.*(..))", throwing="exception")
	public void logException(Exception exception) {
		log.info("Exception...!!!!");
		log.info("exception : " + exception);
	}
	
	@Around("execution(* com.ict.service.SampleService*.*(..))")
							// 앞으로 실행될 메서드(pointcut)에 대한 정보를 pjp에 저장중
	public Object logTime(ProceedingJoinPoint pjp) {
		
		// 시작시간 저장
		long start = System.currentTimeMillis();// 메서드 실행 직전 시간 저장
		log.info("Target : " + pjp.getTarget());// 해당 메서드 명칭
		log.info("Param : " + Arrays.toString(pjp.getArgs()));// 해당 메서드 파라미터들
		
		Object result = null;
		
		////////////////////이전까지 핵심 로직은 실행 안 됨/////////////////////////////
		try {
			result = pjp.proceed();//핵심 로직 실행
		////////////////////핵심 로직 실행 후 실행할 코드들/////////////////////////////
		}catch(Throwable e) {
			// 예외 발생 시 실행
			e.printStackTrace();
		}
		
		// 끝난 시간 저장
		long end = System.currentTimeMillis();//메서드 실행이 모두 끝난 직후 시간 저장
		log.info("TIME : " + (end - start));// 소요시간 계산해 로그에 찍기
		
		return result;
	}
}
