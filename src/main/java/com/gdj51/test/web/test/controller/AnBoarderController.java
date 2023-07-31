package com.gdj51.test.web.test.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gdj51.test.common.service.IPagingService;
import com.gdj51.test.web.test.service.IAnBoardService;

@Controller
public class AnBoarderController {
	
	@Autowired
	public IAnBoardService iAnBoardService;
	
	@Autowired
	public IPagingService ips;
	
	@RequestMapping("/anboardList")
	public ModelAndView anboardList(@RequestParam HashMap<String, String> params,
			                        ModelAndView mav) throws Throwable {//throws Throwable : db붙힐거라서 붙혀줌.
		
		//맨처음 화면 페이지
		int page = 1;
		
		if(params.get("page")!=null && params.get("page")!="") {
			//페이지가 넘어왔을 때
			page = Integer.parseInt(params.get("page"));//받아온 페이지 할당
		}
		//총 데이터 개수 취득
		System.out.println("anBoard 총 조회 수 : "+params.toString());
		int cnt = iAnBoardService.getAnBoardCnt(params);//params 파라미터는 전체	조회시에는 필요없지만, 검색기능이 있다면 필요하다.
		
		//PAGE 데이터가 자동으로 계산되어 pd에 담김.
		HashMap<String, Integer> pd = ips.getPagingData(page, cnt, 3, 2);
		
		//DB에 보내려고(시작과 끝)
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
		
		//데이터 취득
		List<HashMap<String, String>> list = iAnBoardService.getBoardList(params);
		
		//목록 데이터
		mav.addObject("list",list);
		
		//페이징 정보(현재페이지, 다음 버튼, 마지막 버튼에서 사용)
		mav.addObject("pd", pd);
		
		//현재페이지
		mav.addObject("page", page);
		
		mav.addObject("cnt", cnt);//총 몇건
		
		mav.setViewName("anboard/anboardList");
		return mav;
	}
	
	@RequestMapping("/anboardInsert")
	public ModelAndView anboardInsert(ModelAndView mav) {
		System.out.println("등록 페이지 이동");
		mav.setViewName("anboard/anboardInsert");
		return mav;
	}
	
	@RequestMapping("/anboardDetail")
	public ModelAndView anboardDetail(@RequestParam HashMap<String, String> params, 
										ModelAndView mav) throws Throwable {
		
		System.out.println("상세보기 페이지 번호 : "+params.toString());
		
		iAnBoardService.updateHit(params);//조회수
		
		HashMap<String, String> data = iAnBoardService.getAnBoard(params);
		
		mav.addObject("data",data);
		mav.setViewName("anboard/anboardDetail");
		return mav;	
	}
	
	@RequestMapping("/updateAnBoard")
	public ModelAndView updateAnBoard(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = iAnBoardService.getAnBoard(params);
		mav.addObject("data",data);
		mav.setViewName("anboard/anboardUpdate");
		return mav;
	}
	
	//RequestMapping에서 주소 중 특정 내용들을 값으로 활용 가능
	//주소 값에{키}를 지정하면 해당 내용을 변수로 받을 수 있다.
	// /StringSample/SELLLIST
	// ../STRINGSAMPLE/SELLLIST
	@RequestMapping(value= "/ANAction/{action}")
	public ModelAndView ANAction(
								@PathVariable String action,//path에 넘어온 경로를 변수로 활용하여 받아옴
								@RequestParam HashMap<String, String> params,
								ModelAndView mav) throws Throwable{
		//@PathVariable는 주소 자체를 데이터화 할 수도 있따!!!!!
		
		int cnt = 0;
		
		try {
			switch (action) {
			case "insert":
					cnt = iAnBoardService.insertAnBoard(params);
				break;
			case "update":
					cnt = iAnBoardService.updateAnBoard(params);
					mav.addObject("flag","u");
				break;
				
			case "delete":
					cnt = iAnBoardService.delUpdateAnBoard(params);
				break;
			}
			
			if(cnt > 0) {
				mav.addObject("res","success");
			}else {
				mav.addObject("res","failed");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("res","failed");
		}
		
		mav.setViewName("anboard/anboardRes");//jsp로 이동
		return mav;
	}
	
}
