package com.gdj51.test.web.sample.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class ChartController {
	@RequestMapping(value = "/chart")
	public ModelAndView chart(ModelAndView modelAndView) {
		
		modelAndView.setViewName("sample/chart/chart");
		
		return modelAndView;
	}
	

	@RequestMapping(value = "/getChartData", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String getChartData(
			HttpServletRequest request) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int size = Integer.parseInt(request.getParameter("size"));
		
		int series = Integer.parseInt(request.getParameter("series"));
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		for(int s = 0 ; s < series ; s++) {
			HashMap<String, Object> data = new HashMap<String, Object>();
			
			data.put("name", "S" + s);
			data.put("pointInterval", 1);
			data.put("pointStart", 1999);
			
			ArrayList<Integer> y = new ArrayList<Integer>();
			
			for(int i = 0 ; i < size ; i++) {
				y.add((int) (Math.random() * 100)); 
			}
			
			data.put("data", y);
			
			list.add(data);
		}
		
		modelMap.put("list", list);
		
        return mapper.writeValueAsString(modelMap);
	}
}
