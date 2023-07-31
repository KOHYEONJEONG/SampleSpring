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
public class SellController {

	@Autowired
	public ITestService iTestService;//컨트롤러부터 마이바티스까지 연결 성공

	@Autowired
	public IPagingService ips;//스프링에 좋은점 이렇게 해주면 필요할때마다 주입받을 수 있다.(페이징 서비스 객체 주입)
	
	/*
	 * database나 파일 같이 외부에 접근하는 경우 외적 요인으로 문제가 발생할 수 있으므로
	 * 예외처리가 반드시 필요하다.
	 * */
	@RequestMapping(value="/sellList")
	public ModelAndView sellList(@RequestParam HashMap<String, String> params,
									ModelAndView mav) throws Throwable {
		//@RequestParam HashMap<String, String> params 페이징 하려고 데이터를 받아온다.
		
		//맨처음 화면 페이지
		int page = 1;
		
		if(params.get("page") != null) {//페이지가 넘어왔을 때
			//페이지가 넘어왔을 때
			page = Integer.parseInt(params.get("page")); //받아온 페이지 할당
					
		}
		
		//총 데이터 개수 취득
		System.out.println("sell 총 조회 수 : "+params.toString());
		int cnt = iTestService.getSellCnt(params);//params 파라미터는 전체 조회할때는 필요없음. 검색할때 필요있음

		//페이지 데이터가 자동으로 계산되어 pd에 담김.(페이징처리)
		HashMap<String, Integer> pd = ips.getPagingData(page,cnt, 3, 2);  //데이터(1), 데이터(20), 보여질 개수(3), 페이지 수 (2)
		
		
		//파라미터에 시작, 종료값 추가
		//(왜 쓰냐면) params는 디비에 보내려고
		params.put("start",Integer.toString(pd.get("start")));
		params.put("end",Integer.toString(pd.get("end")));
		

		//데이터취득(sell 테이블 안에 여러개의 데이터가 존재하지? list로 받으려고)
		List<HashMap<String, String>> list = iTestService.getSellList(params); 
		
		//목록데이터
		mav.addObject("list",list);
		
		//페이징 정보(현재페이지, 다음 버튼, 마지막 버튼에서 사용)
		mav.addObject("pd",pd);
		
		//현재페이지
		mav.addObject("page", page);
		
		mav.setViewName("test/sellList");
		return mav;
	}

	@RequestMapping(value="/sellDetail")
	public ModelAndView sellDetail(@RequestParam HashMap<String,String> params ,ModelAndView mav) throws Throwable {

		System.out.println(params.toString());//{no=20}

		//@RequestParam HashMap<String,String> params을 만들어두고 map을 넣겠다.
		//넘어온 값이 HashMap이잖아?
		if(params.get("no") == null || params.get("no") == "") {
			System.out.println("상세보기 실패");
			mav.setViewName("redirect:sellList");
		}else {
			System.out.println("상세보기 성공");
			HashMap<String, String> data 
				= iTestService.getSell(params);// 몇번을 클릭했는지 알려주기 위해서 params
			
			mav.addObject("data", data);
			mav.setViewName("test/sellDetail");

		}
		return mav;
	}



	@RequestMapping(value="/sellInsert")
	public ModelAndView sellInsert(ModelAndView mav) {
		System.out.println("등록페이지 이동");
		mav.setViewName("test/sellInsert");
		return mav;
	}

	@RequestMapping(value="/sellRes")
	public ModelAndView sellRes(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable{
		// 삽입, 수정, 삭제를 한번에 할 수 있는 곳.(여러 메소드를 만들 필요가 없기에 효율적)
		try {
			int cnt = 0;//insert, delete, update는 실패하면 -1을 반환

			switch (params.get("gbn")) {
			case "i":
				cnt = iTestService.inserSell(params);
				break;
			case "u":
				cnt = iTestService.updateSell(params);
				break;
			case "d":
				cnt = iTestService.deleteSell(params);
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
		mav.setViewName("test/sellRes");

		return mav;
	}
	
	//sellDetail.jsp에서 수정버튼 눌렀을때 페이지 이동해주는 컨트롤러
	@RequestMapping(value="/sellUpdate")
	public ModelAndView sellUpdate(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable{
		
		//데이터를 조회해서 sellUpdate.jsp로 보내줄꺼야.
		HashMap<String, String> data = iTestService.getSell(params);
		
		mav.addObject("data", data);
		
		mav.setViewName("test/sellUpdate");
		return mav;
	}
	
	

}
