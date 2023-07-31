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
public class KHJAccBookController {
	@Autowired
	public IACDao dao; //ACCBOOK_SQL.XML과 직결
	
	@Autowired
	public IPagingService ips;
	
	@RequestMapping(value="ACCBOOK")
	public ModelAndView ACCBOOK(ModelAndView mav) {
		mav.setViewName("testa/ACCBOOK/khjacclist");
		return mav;
	}
	
	//ACCListAjax
	@RequestMapping(value="/ACCListAjax",
			method=RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ACCListAjax(ModelAndView mav, @RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = dao.getIntData("acc.getAccCnt", params);
		
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 10, 5);
		
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
		System.out.println("start"+params.get("start"));
		System.out.println("end"+params.get("end"));
		
		List<HashMap<String, String>> list = dao.getList("acc.getAccList", params);
		System.out.println("조회?" + list.toString());
		model.put("list",list);
		model.put("pd", pd);
		
		return mapper.writeValueAsString(model);
	}
	
	//AOBAction
	@RequestMapping(value="/AccAction/{gbn}",
	         method = RequestMethod.POST,
	         produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AccAction(HttpSession session,
			@PathVariable String gbn,
			@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0;
		
		try {
			
			switch (gbn) {
			case "insert":
				  cnt = dao.insert("acc.insertAcc", params);
				break;
			case "update":
				  cnt = dao.insert("acc.updateAcc", params);
				break;
			case "delete":
				  cnt = dao.insert("acc.deleteAcc", params);
				break;
			}
			
			if(cnt > 0) {
				model.put("msg", "success");
			}else {
				model.put("msg", "file");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			model.put("msg", "error");
		}
		
		
		return mapper.writeValueAsString(model);
	}
}
