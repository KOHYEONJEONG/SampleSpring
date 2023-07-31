package com.gdj51.test.web.test.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gdj51.test.common.service.IPagingService;
import com.gdj51.test.web.test.service.ITestService;


@Controller
public class ManagerController {
	
	@Autowired
	public ITestService iTestService;
	
	@Autowired
	public IPagingService ips;//페이징 서비스 객체 주입
	
	@RequestMapping(value="/managerList")
	public ModelAndView managerList(@RequestParam HashMap<String, String> params,
									ModelAndView mav) throws Throwable {

		int page = 1;
		
		if(params.get("page") != null) {
			//페이지가 넘어왔을 때
			page = Integer.parseInt(params.get("page"));//받아온 페이지 할당
		}
		
		//총 데이터 개수 취득
		int cnt = iTestService.getManagerCnt(params);
		
		//페이지 데이터가 자동으로 계산되어 pd에 담김
		HashMap<String, Integer> pd = ips.getPagingData(page, cnt, 3, 2);
		
		//파라미터에 시작, 종료값 추가
		//쓰임? params는 디비에 보내기 위해서 
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
		
		//전체조회 + 페이징
		//데이터취득
		List<HashMap<String, String>> list
			= iTestService.getManagerList(params); 

		
		//목록데이터
		mav.addObject("list",list);
		
		//페이징 정보
		mav.addObject("pd", pd);
		
		System.out.println("현재 페이지 : "+page);
		//현재 페이지
		mav.addObject("page",page);
		
		mav.setViewName("test/managerList");
		return mav;
	}

	@RequestMapping(value="/managerDetail")
	public ModelAndView managerDetail(@RequestParam HashMap<String,String> params,
										ModelAndView mav) throws Throwable {

		System.out.println(params.toString());
		
		if(params.get("no") == null || params.get("no")=="") {
			System.out.println("상세보기 실패");
			mav.setViewName("redirect:managerList");
		}else {
			System.out.println("상세보기 성공");
			HashMap<String, String> data 
				= iTestService.getManager(params);

			mav.addObject("data", data);
			mav.setViewName("test/managerDetail");
		}
		return mav;
	}
	
	@RequestMapping(value="/managerInsert")
	public ModelAndView managerInseret(ModelAndView mav) {
		
		mav.setViewName("test/managerInsert");
		return mav;
	}
	
	@RequestMapping(value="/managerResult")
	public ModelAndView sellRes(
								@RequestParam HashMap<String, String> params,
								ModelAndView mav ) throws Throwable{
		
		//insert, update, delete 한번에 하는 메소드
		System.out.println("삽입할 값 :"+params.toString());
		try {
			int cnt = 0;
			
			switch(params.get("gbn")) {
			case "i":
				cnt = iTestService.insertManager(params);
				break;
			case "u":
				cnt = iTestService.updateManger(params);
				System.out.println("업데이트 상황 : "+cnt);
				break;
			case "d":
				cnt = iTestService.deleteManger(params);
				break;
				
			}
			
			if(cnt > 0) {
				//1건 이상 등록된 경우
				mav.addObject("res", "success");
			}else {
				//등록이 안된 경우.
				mav.addObject("res", "failed");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			mav.addObject("res", "failed");
		}
		
		//글상세보기) 글번호, redirect로 하게되면 값을 가지고 get방식
		mav.setViewName("test/managerResult");
		
		return mav;
	}
	
	@RequestMapping(value="/managerUpdate")
	public ModelAndView sellUpdate(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable{
		
		//데이터를 조회해서 managerUpdate.jsp로 보내줄꺼야.
		HashMap<String, String> data = iTestService.getManager(params);
		
		mav.addObject("data", data);
		
		mav.setViewName("test/managerUpdate");
		return mav;
	}
}
