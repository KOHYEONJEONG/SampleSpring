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
import com.gdj51.test.common.service.PagingService;
import com.gdj51.test.util.Utils;
import com.gdj51.test.web.test2.dao.IACDao;

@Controller
public class AMemberController {
	@Autowired
	public IACDao iacDao;
	
	@Autowired
	public PagingService ips;
	
	@RequestMapping(value="/AMList")
	public ModelAndView AMList(@RequestParam HashMap<String, String> params, ModelAndView mav) {
		
		int page = 1;//중요
		
		if(params.get("page") != null && params.get("page") != "") {
			page = Integer.parseInt(params.get("page"));
			
		}
		
		mav.addObject("page", page);
		mav.setViewName("testa/Member/mList");
		return mav;
	}
	
	@RequestMapping(value="/AMListAjax", method=RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ATListAjax(ModelAndView mav, @RequestParam HashMap<String, String> params) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		System.out.println("(*)member 전체 조회 params : "+params.toString());
		
		int cnt = iacDao.getIntData("mem.getMemberCnt", params);
		
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")),cnt,3,5);
		
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
		
		List<HashMap<String, String>> list=iacDao.getList("mem.memberList", params);
		
		model.put("list",list);
		model.put("pd",pd);
		
		return mapper.writeValueAsString(model); 
	}
	
	@RequestMapping(value="/AMDetail")
	public ModelAndView AMDetail(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		if(params.get("no")!=null &&params.get("no")!="") {
			
			HashMap<String, String> data = iacDao.getMapData("mem.getMember", params);
			
			mav.addObject("data", data);
			mav.setViewName("testa/Member/mDetail");
		}else {
			mav.setViewName("redirect:AMList");
		}
		return mav;
	}
	
	@RequestMapping(value="/AMInsert")
	public ModelAndView AMInsert(HttpSession session,ModelAndView mav) {
		
		if(session.getAttribute("sMemNm") !=  null && session.getAttribute("sMemNm")!= "") {
			mav.setViewName("testa/Member/mInsert");
		}else {
			mav.setViewName("redirect:testALogin");
		}
		
		return mav;
	}
	
	@RequestMapping(value="AMUpdate")
	public ModelAndView AMUpdate(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		if(params.get("no")!=null && params.get("no")!="") {
			HashMap<String, String> data = iacDao.getMapData("mem.getMember", params);
			
			mav.addObject("data", data);
			
			mav.setViewName("testa/Member/mUpdate");
			
		}else {
			mav.setViewName("redirect:AMList");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/AMAction/{gbn}",
	         method = RequestMethod.POST,
	         produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ATAction(	HttpSession session,
							@PathVariable String gbn,
							@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0;
		
		try {
			switch (gbn) {
			case "insert":
					//암호화
					params.put("pw",Utils.encryptAES128(params.get("pw")));
				
					cnt = iacDao.insert("mem.memberInsert", params);
				break;
			case "update":
					if(params.get("pw") != null && !params.get("pw").equals("")) {//!params.get("pw").equals("") : 느낌표 필수!, 비어있지 않으면
						//비밀번호가 비어있지 않다면 암호화를 하겠다.
						params.put("pw",Utils.encryptAES128(params.get("pw")));
					}
				
					cnt = iacDao.update("mem.updateMember",params);
					
				break;
			case "delete":
					cnt = iacDao.update("mem.deleteMember",params);
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
