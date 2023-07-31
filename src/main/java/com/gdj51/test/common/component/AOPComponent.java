package com.gdj51.test.common.component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

@Aspect //AOP용 클래스
@Component //객체생성, 메소드를 실행하려면 객체를 생성해야하잖아 그래서 만들어 줘야해, 일반 객체(mvc용은 아니다)
@EnableAspectJAutoProxy //AspectJ기능 활성화
public class AOPComponent {
	//Pointcut -> 적용범위(상황에 따라 기능구현과 다를 수 있음)
	//@Pointcut(범위설정)
	/*
	 * 범위
	 * execution -> include필터
	 * !execution -> exclude필터 (!가 붙으면 뺐으면 좋겠어~)
	 * * -> 모든것
	 * *(..) -> 모든 메소드
	 * .. -> 모든 경로
	 * &&, ||(또는, 잘안씀) -> 필터 추가
	 * 
	 * execution (반환타입 범위) : 접근권한의 경우 필수가 아님
	 * 보통 컨트롤러에 적용
	 * 경로와 메소드명만 처리하지, 인자까지는 지정안함 *(..) <-- 이렇게~
	 */
	@Pointcut("execution(* com.gdj51.test..HomeController.*(..))")
	public void testAOP() {} //이 pointcut의 이름과 같은 역할로 처리하겠다~ 이 메소드이다.
	                         //testAOP 메소드 명으로 찾아가서 pointcut했으면 좋겠어~
	
	//ProceedingJoinPoint -> 대상 적용 이벤트 필터
	/*
	 * @Before -> 메소드 실행 전
	 * @After -> 메소드 실행 후
	 * @After-returning -> 메소드 정상실행 후
	 * @After-throwing -> 메소드 예외 발생 후
	 * @Around -> 모든 동작시점
	 */
	@Around("testAOP()") //모든 동작 시점에서 체크해볼래~
	public ModelAndView testAOP(ProceedingJoinPoint joinPoint)
														throws Throwable {
		ModelAndView mav = new ModelAndView();
		
		//Request 객체 취득
		HttpServletRequest request
		= ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();

		mav = (ModelAndView) joinPoint.proceed(); //기존 이벤트 처리 행위를 이어서 진행
		
		System.out.println("------- testAOP 실행됨 ------");
		
		return mav;
	}
	
	//pointcut은 여러개 사용가능
	//주의사항 : 범위를 잘 잡아야한다.
	//&&와 ||을 섞어 쓰는 거 비추
	//차리리 pointcut을 여러개 만들어서 사용해라~
	//Ajax의 경우 String을 반환하기 때문에 ModelAndView로 구현이 안됨으로 따로 처리해야함.
	//자바클래스와 메소드만
	@Pointcut("execution(* com.gdj51.test..controller.ATController.*Insert(..))"
			+"|| execution(* com.gdj51.test..controller.ATController.*Update(..))")//ATConroller안에 있는 모든 메소드
	public void atAOP() {}
	
	@Around("atAOP()")
	public ModelAndView atAOP(ProceedingJoinPoint joinPoint) throws Throwable {//예외가 발생할 수 있어서 안전장치 걸어두자!
		ModelAndView mav = new ModelAndView();
		
		//Request 객체 취득
		HttpServletRequest request
		= ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		HttpSession session = request.getSession();//세션가져오기!
		
		//등록과, 수정은 로그인 유무가 중요하지?!
		if(session.getAttribute("sMemNm") != null && session.getAttribute("sMemNm")!="") {//로그인 중인 경우
			mav = (ModelAndView)joinPoint.proceed();
		}else {//비로그인인 경우
			mav.setViewName("redirect:testALogin");
		}
		
		return mav;
	}
}













