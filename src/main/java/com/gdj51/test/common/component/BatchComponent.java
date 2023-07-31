package com.gdj51.test.common.component;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component // 객체생성, 메소드를 실행하려면 객체를 생성해야하잖아 그래서 만들어 줘야해, 일반 객체(mvc용은 아니다)
@EnableScheduling //스케쥴링 활성화하겠다.
public class BatchComponent {

	// 초 분 시 일 월 요일
	// * - 모든
	// ? - 월, 요일에 사용. 신경안씀이라는 의미
	// 월은 1 - 12
	// 요일은 1(일) - 7(토). ,(컴마)로 복수지정가능. 예)월수금 - 2,4,6
	// 숫자1/숫자2의 경우 숫자1에서 시작하여 매 숫자2마다 실행. 예) 분에 0/5이면 0분부터 5분마다 실행
	// 일에서 L은 달의 마지막날. W는 지정일자가 휴일(토, 일)이면 인접한 평일에 수행.
	// 예) 25W인경우 25일이 일요일이면 26일 월요일 실행.
	// LW는 마지막 평일
	// 요일에서 숫자1#숫자2의경우 숫자2번째 주의 숫자1번 요일에 실행.
	// 예) 2#4 - 4번째주 월요일에 실행.
	//@Scheduled(cron = "0 0 0 * * *") // 자정에 매일 돌거다. 
	@Scheduled(cron = "0 44 10 * * *") // 오전 10시 44분 실행되게 테스트를 해보았음.
	public void cronTest1() {
		System.out.println("batch!!");
	}

}
