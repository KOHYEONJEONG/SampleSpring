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
public class KhjBookController { //시험

	@Autowired
	public ITestService iTestService;
	
	@RequestMapping("/bookList")
	public ModelAndView bookList(ModelAndView mav) throws Throwable {
		
		List<HashMap<String, String>> list = iTestService.getBookList();
		
		mav.addObject("list",list);
		mav.setViewName("book/bookList");
		return mav;
	}
	
	//상세보기
	@RequestMapping("/bookDetail")
	public ModelAndView bookDetail(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		System.out.println(params.toString());
		
		if(params.get("no") == null || params.get("no") == "") {
			System.out.println("상세보기 실패");
			mav.setViewName("redirect:bookList");
		}else {
			System.out.println("상세보기 성공");
			HashMap<String, String> data
				= iTestService.getBook(params);
			mav.addObject("data", data);
			mav.setViewName("book/bookDetail");
		}

		return mav;
	}
	
	//등록페이지로 이동
	@RequestMapping("/bookInsert")
	public ModelAndView bookInsert(ModelAndView mav) {
		mav.setViewName("book/bookInsert");
		return mav;
	}
	
	@RequestMapping("/bookUpdate")
	public ModelAndView bookUpdate(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		
		System.out.println("수정페이지로 이동 ... , "+params.toString());
		HashMap<String, String> data = iTestService.getBook(params);
		mav.addObject("data", data);
		mav.setViewName("book/bookUpdate");
		//수정페이지로 이동
		return mav;
	}
	
	//등록,수정,삭제
	@RequestMapping("/bookRes")
	public ModelAndView bookRes(@RequestParam HashMap<String, String> params,
							ModelAndView mav) throws Throwable {
		
		try {
			int count = 0;
			
			switch (params.get("gbn")) {
			case "i":
				count = iTestService.insertBook(params);
				break;
			
			case "u":
				count = iTestService.updateBook(params);
				break;
			
			case "d":
				count = iTestService.deleteBook(params);
				break;
			}
			
			
			if(count > 0) {
				mav.addObject("res", "success");
			}else {
				mav.addObject("res", "failed");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			mav.addObject("res","failed");//실패
		}
		
		mav.setViewName("book/bookRes");
		return mav;
	}
	
	
}
