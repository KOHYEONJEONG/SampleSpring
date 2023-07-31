package com.gdj51.test.web.test2.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj51.test.common.service.IPagingService;
import com.gdj51.test.web.test2.dao.IACDao;

@Controller
public class AOBController {
	
	@Autowired
	public IACDao dao; //OB_SQL.XML과 직결
	
	@Autowired
	public IPagingService ips;
	
	@RequestMapping(value="AOB")
	public ModelAndView aob(ModelAndView mav) {
		mav.setViewName("testa/AOB/ob");
		return mav;
	}
	
	
	//전체조회
	@RequestMapping(value="/AOBList",
			method=RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AOBList(ModelAndView mav, @RequestParam HashMap<String, String> params)throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt =dao.getIntData("ob.getObCnt", params);
		
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")),cnt, 3, 5);
		
		params.put("start",Integer.toString(pd.get("start")));
		params.put("end",Integer.toString(pd.get("end")));

		List<HashMap<String, String>> list = dao.getList("ob.getObList", params);
		
		model.put("list",list);
		model.put("pd", pd);
		
		//json형태로 바꿔줘야지 script에서 받을 수 있다.
		return mapper.writeValueAsString(model);
	}
	
	
	
	//AOBAction
	@RequestMapping(value="/AOBAction/{gbn}",
	         method = RequestMethod.POST,
	         produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AOBAction(HttpSession session,
							@PathVariable String gbn,
							@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0;
		
		try {
			switch (gbn) {
			case "insert":
					cnt = dao.insert("ob.InsertOb", params);
				break;
			case "update":
					cnt = dao.update("ob.UpdateOb",params);
				break;
			case "delete":
					cnt = dao.update("ob.DeleteOb",params);
				break;
				
			}
			
			if(cnt > 0) {
				model.put("msg", "success");
			}else {
				model.put("msg", "fail");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			model.put("msg","error");
		}
		
		return mapper.writeValueAsString(model);
	}
}
