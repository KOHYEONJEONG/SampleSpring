package com.gdj51.test.web.test.controller;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gdj51.test.web.test.service.ITestService;

@Controller
public class DivsController {

	@Autowired
	public ITestService iTestService;

	@RequestMapping(value="/divsList")
	public ModelAndView divsList(ModelAndView mav) throws Throwable{

		List<HashMap<String, String>> list 
		= iTestService.getDivsList();

		mav.addObject("list", list);
		mav.setViewName("divs/divsList");
		return mav;
	}
	
	@RequestMapping(value="/divsDetail")
	public ModelAndView divsDetail(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		HashMap<String,String> data = iTestService.getDivs(params);
		mav.addObject("data", data);
		mav.setViewName("divs/divsDetail");
		
		return mav;
	}

	@RequestMapping(value="/divsInsertPage")
	public ModelAndView divsInsertPage(ModelAndView mav) {
		mav.setViewName("divs/divsInsert");
		return mav;
	}

	@RequestMapping(value="/divsResult")
	public ModelAndView divsResult(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		


		try {
			int cnt = 0;
			switch (params.get("gbn")) {
			case "i":
				cnt = iTestService.insertDivs(params);
				break;

			case "u":
				cnt = iTestService.updateDivs(params);
				break;

			case "d":
				System.out.println("삭제할 값 :"+params.toString());
				cnt = iTestService.deleteDivs(params);
				break;
			}
			
			if(cnt > 0) {
				//1건 이상 등록된 경우
				mav.addObject("res","success");
			}else {
				//등록이 안된 경우
				mav.addObject("res","failed");
				
			}

		}catch (Exception e) {
			e.printStackTrace();
			mav.addObject("res", "failed");
		}

		mav.setViewName("divs/divsResult");
		return mav;
	}
	
	@RequestMapping(value="/divsUpdatePage")
	public ModelAndView divsUpdatePage(@RequestParam HashMap<String, String> params,ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = iTestService.getDivs(params);
		mav.addObject("data",data);
		mav.setViewName("divs/divsUpdate");
		return mav;
	}



}

