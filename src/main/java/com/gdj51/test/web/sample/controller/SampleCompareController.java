package com.gdj51.test.web.sample.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SampleCompareController {
	/**
	 * Calendar Sample Mapping
	*/
	@RequestMapping(value = "/calendar")
	public ModelAndView calendar(ModelAndView mav) {
		
		mav.setViewName("sample/calendar/calendar");
		
		return mav;
	}
	
	/**
	 * Fancybox Sample Mapping
	*/
	@RequestMapping(value = "/fancybox")
	public ModelAndView fancybox(ModelAndView mav) {
		mav.setViewName("sample/fancybox/fancybox");
		
		return mav;
	}
	
	/**
	 * Fileupload Sample Mapping
	*/
	@RequestMapping(value = "/fileUpload")
	public ModelAndView fileUpload(ModelAndView mav) {
		mav.setViewName("sample/fileUpload/fileUpload");
		
		return mav;
	}
	
	/**
	 * Popup Sample Mapping
	*/
	@RequestMapping(value = "/popup")
	public ModelAndView popup(ModelAndView mav) {
		mav.setViewName("sample/popup/popup");
		
		return mav;
	}
	
	/**
	 * Zoom Sample Mapping
	*/
	@RequestMapping(value = "/zoom")
	public ModelAndView zoom(ModelAndView mav) {
		mav.setViewName("sample/zoom/zoom");
		
		return mav;
	}
	
	/**
	 * Slimscroll Sample Mapping
	*/
	@RequestMapping(value = "/scroll")
	public ModelAndView scroll(ModelAndView mav) {
		mav.setViewName("sample/scroll/scroll");
		
		return mav;
	}
	
	/**
	 * Restful Sample Mapping
	*/
	@RequestMapping(value = "/rest")
	public ModelAndView rest(ModelAndView mav) {
		mav.setViewName("sample/rest/rest");
		
		return mav;
	}
}
