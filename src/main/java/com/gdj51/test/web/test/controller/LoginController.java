package com.gdj51.test.web.test.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gdj51.test.web.test.service.ILoginService;

@Controller
public class LoginController {
	
	@Autowired
	public ILoginService iLoginService;
	
	@RequestMapping(value="/testLogin")
	public ModelAndView testLogin(HttpSession session, ModelAndView mav) {
		
		//session의 getAttribute(키) : 세션값 취득
		//세션게 값이 존재한다면 main으로 이동(없으면 login 페이지로 이동되게)
		if(session.getAttribute("sMemNm") != null && session.getAttribute("sMemNm")!="") {
			System.out.println("세션 있음.");
			mav.setViewName("redirect:testMain");//testMain으로 이동.
		}else {
			System.out.println("세션 없음");
			mav.setViewName("login/login");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/testLoginAction")
	public ModelAndView testLoginAction(
			//HttpServletRequest req,
			HttpSession session,//2) Spring에 session을 취득
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		
		//1) Request 를 통한 session 취득
		//HttpSession session = req.getSession();
		
		//아이디와 비밀번호가 일치하는 사용자 정보 취득
		HashMap<String, String> data
			= iLoginService.checkMem(params);
		
		if(data != null) {//초기데이터가 있다면
			
			//세션 명칭은 앞에 s를 붙여준다.
			session.setAttribute("sMemNo", data.get("MEM_NO"));
			session.setAttribute("sMemNm", data.get("MEM_NM"));
			
			mav.setViewName("redirect:testMain");
		}else {
			mav.setViewName("login/action");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/testMain")
	public ModelAndView testMain(ModelAndView mav) {
		
		mav.setViewName("login/main");
		return mav;
	}
	
	@RequestMapping(value="/testLogout")
	public ModelAndView testLogout(HttpSession session,
									ModelAndView mav) {
		session.invalidate();//요청 사용자 세션 초기화
		mav.setViewName("redirect:testMain");
		return mav;
	}
	
	@RequestMapping(value="/testHeader")
	public ModelAndView testHeader(ModelAndView mav) {
		//db에서 불러오는 게 아니니까 ModelAndView만 필요
		mav.setViewName("login/header");
		return mav;
	}
}
