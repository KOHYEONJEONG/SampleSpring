package com.gdj51.test.web.test2.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.gdj51.test.common.service.IPagingService;
import com.gdj51.test.web.test2.dao.IACDao;

@Controller
public class AOBControllerTest {

	@Autowired
	public IACDao dao;//OB_SQL.XML 직결
	
	@Autowired
	public IPagingService ips;//페이징
	
	@RequestMapping(value="AOB2")
	public ModelAndView aob2(ModelAndView mav) {
		mav.setViewName("testa/AOB/ob2");
		return mav;
	}
	
}
