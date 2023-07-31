package com.gdj51.test.web.test2.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mysql.jdbc.Util;
import com.gdj51.test.util.Utils;
import com.gdj51.test.web.test2.dao.IACDao;

@Controller
public class ALoginController {
	
	@Autowired
	public IACDao iacDao;
	
	@RequestMapping(value ="/testALogin")
	public ModelAndView testALogin(HttpSession session , ModelAndView mav) {
		
		if(session.getAttribute("sMemNm") != null && session.getAttribute("sMemNm")!= "") {
			
			mav.setViewName("redirect:testAMain");
		}else {
			mav.setViewName("testa/login/login");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/testALoginAjax", method=RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String testALoginAjax(HttpSession session,
									@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String ,Object> model = new HashMap<String, Object>();
		
		
		//암호화
		params.put("pw", Utils.encryptAES128(params.get("pw")));
		System.out.println(params.get("pw"));
		
		//복호화
		System.out.println(Utils.decryptAES128(params.get("pw")));
		
		
		HashMap<String, String> data = iacDao.getMapData("login.checkMem", params);//이제 암호화된 PW 키가 들어간다(DB에는 이제 1234를 암호화한 키가 들어가는 거다)
		
		if(data != null) {
			session.setAttribute("sMemNo", data.get("MEM_NO"));
			session.setAttribute("sMemNm", data.get("MEM_NM"));
			
			model.put("msg", "success");
		}else {
			model.put("msg", "failed");
		}
		
		return mapper.writeValueAsString(model);
	}
	
	@RequestMapping(value = "/testAMain")
	public ModelAndView testAMain(ModelAndView mav) {
		mav.setViewName("testa/login/main");
		return mav;
	}
	
	@RequestMapping(value = "/testAHeader")
	public ModelAndView testAHeader(ModelAndView mav) {
		mav.setViewName("testa/login/header");
		return mav;
	}
	
	@RequestMapping(value = "/testALogout")
	public ModelAndView testALogout(HttpSession session,ModelAndView mav) {
		
		session.invalidate();//세션 해제
		
		mav.setViewName("redirect:testAMain");
		return mav;
	}
}
