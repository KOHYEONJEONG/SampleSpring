package com.gdj51.test.web.test2.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
public class ACategoryCotroller {
	
	@Autowired
	public IACDao dao; //Cate_SQL.XML과 직결
	
	@Autowired
	public IPagingService ips;//페이징
	
	@RequestMapping("CATE")
	public ModelAndView CATE(ModelAndView mav, @RequestParam HashMap<String, String> params) {
		
		mav.setViewName("testa/ACATEGORY/cate");
		return mav;
	}
	
	//카테고리 전체조ㅇ호
	@RequestMapping(value="/ACateList",
			method=RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ACateList(ModelAndView mav, @RequestParam HashMap<String,String> params) throws Throwable {
		
		System.out.println("전체조회~!~!~!");
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = dao.getIntData("cate.getCateCnt", params);
		
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")),cnt,3,5);
		
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
		
		List<HashMap<String, String>> list = dao.getList("cate.getCateList", params);
		
		model.put("list", list);
		model.put("pd", pd);
		
		return mapper.writeValueAsString(model);
		
	}
	
	@RequestMapping(value="/ACateAction/{gbn}",
	         method = RequestMethod.POST,
	         produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ACateAction(@PathVariable String gbn,
								@RequestParam HashMap<String, String> params) throws Throwable {
			
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object>  model = new HashMap<String, Object>();
		
		int cnt = 0;
		
		try {
			switch (gbn) {
			case "insert":
				 	cnt = dao.insert("cate.insertCate", params);
				break;
			case "update":
			 	cnt = dao.update("cate.updateCate", params);
			break;
			case "delete":
			 	cnt = dao.update("cate.delUpCate", params);
			break;

			}
			
			if(cnt > 0) {
				model.put("msg", "success");
				
			}else {
				model.put("msg","fail");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			model.put("msg","error");
		}
		
		return mapper.writeValueAsString(model);
	}
}
