package com.gdj51.test.web.test.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gdj51.test.common.service.IPagingService;
import com.gdj51.test.web.test.service.ITBoardService;

@Controller
public class TBoardController {
	
	@Autowired
	public ITBoardService iTboardService;
	
	@Autowired
	public IPagingService ips;
	
	@RequestMapping(value = "/tBoardList")
	public ModelAndView TBoardList(
					@RequestParam HashMap<String, String> params,
					ModelAndView mav) throws Throwable{
		
			int page = 1;
			
			if(params.get("page") != null && params.get("page")!= "") {
				page = Integer.parseInt(params.get("page"));
			}
			
			int cnt = iTboardService.getTBoardCnt(params);
			
			//페이징
			HashMap<String, Integer> pd = ips.getPagingData(page, cnt, 10, 10);
			
			
			params.put("start", Integer.toString(pd.get("start")));//게시판 시작
			params.put("end", Integer.toString(pd.get("end")));//게시판 끝
			
			//전체 조회(데이터)
			List<HashMap<String, String>> list
					= iTboardService.getTBoardList(params);
		
			
			//view에 보내기
			mav.addObject("list", list);
			mav.addObject("page", page);
			mav.addObject("pd", pd);
			
			mav.setViewName("tboard/tBoardList");
		return mav;
	}
	
	@RequestMapping(value="/tboardInsert")
	public ModelAndView tboardInsert(HttpSession session, ModelAndView mav) {
		//권한체크용 session
		
		if(session.getAttribute("sMemNm") != null && session.getAttribute("sMemNm")!= "") {
			//로그인 중이라면
			mav.setViewName("tboard/tboardInsert");
		}else {
			//로그인 중이 아니라면 로그인창으로 이동.
			mav.setViewName("redirect:testLogin");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/TAction")
	public ModelAndView tAction(@RequestParam HashMap<String, String> params,
								ModelAndView mav)throws Throwable{
		
		int cnt = 0;
		
		try {
			switch (params.get("gbn")) {
				case "i":
					cnt = iTboardService.tBoardInsert(params);
					break;
				case "d":
					cnt = iTboardService.tBoardDelete(params);
					break;
				case "u":
					cnt = iTboardService.tBoardUpdate(params);
					break;
			}
			
			if(cnt > 0) {
				mav.addObject("res","success");
			}else {
				mav.addObject("res","failed");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			mav.addObject("res","error");
		}
		
		
		mav.setViewName("tboard/tboardRes");
		return mav;
	}
	
	@RequestMapping(value="tboardDetail")
	public ModelAndView tboardDetail(
					@RequestParam HashMap<String, String> params,
					ModelAndView mav) throws Throwable {
		
			if(params.get("no") != null && params.get("no") != "") {
				//번호가 들어왔다면

				//조회수(데이터 조회보다 먼저 증가되야함)
				iTboardService.updateTboardHit(params);
				
				//데이터 조회
				HashMap<String, String> data 
							= iTboardService.getT(params);
				
				mav.addObject("data", data);
				mav.setViewName("tboard/tboardDetail");
				
			}else {
				mav.setViewName("redirect:tBoardList");
			}
		return mav;
		
	}
	
	//tBoardUpdate
	@RequestMapping(value="/tBoardUpdate")
	public ModelAndView tBoardUpdate(ModelAndView mav, @RequestParam HashMap<String, String> params) throws Throwable
	{
		System.out.println("수정페이지 이동..." + params.toString());
		//데이터 조회
		HashMap<String, String> data 
					= iTboardService.getT(params);
		mav.addObject("data",data);
		mav.setViewName("tboard/tboardUpdate");
		return mav;
	}
}
