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
public class AGalleryControllerKHJ {
	
	@Autowired
	public IACDao dao; //Gallery_SQL.XML과 직결
	
	@Autowired
	public IPagingService ips;

	/**첫 화면*/
	@RequestMapping(value = "/AGALLERY")
	public ModelAndView AGALLERY(ModelAndView mav, @RequestParam HashMap<String,String> params) {
		
		int page = 1;//첫페이지로 나타내려고
		
		if(params.get("page")!= null && params.get("page") != "") {
			page = Integer.parseInt(params.get("page"));
		}
		
		//페이지 번호
		mav.addObject("page", page);
		
		mav.setViewName("testa/AGALLERY/glist");
		return mav;
		
	}
	
	/**등록 페이지 이동*/
	@RequestMapping(value="/AGInsert")
	public ModelAndView AGInsert(HttpSession session, 
										ModelAndView mav,
										 @RequestParam HashMap<String, String> params) {
		
		mav.setViewName("testa/AGALLERY/ginsert");
		
		return mav;
	}
	
	/**상세보기 페이지 이동 */
	@RequestMapping(value="/AGDetail")
	public ModelAndView AGDetail(HttpSession session, 
										ModelAndView mav,
										 @RequestParam HashMap<String, String> params) throws Throwable {
		System.out.println("상세보기 param : "+params.toString());
		if(params.get("no")!=null && params.get("no")!= "") {
		
			if(session.getAttribute("sMemNo") != params.get("memNo")) {
				//작성자가 같으면 조회수 증가 안되게 하자
				dao.update("gallery.updateGalleryHit", params);
			}
			
			HashMap<String, String> data = dao.getMapData("gallery.getG",params);
			mav.addObject("data", data);
			mav.setViewName("testa/AGALLERY/gdetail");
			
		}else {
			System.out.println("no없음");
			//업데이트 했을 때 no가 없다면 다이렉트로 목록화면으로
			mav.setViewName("redirect:AGALLERY");
		}
		
		return mav;
	}
	
	/**비동기화 전체조회*/
	@RequestMapping(value="/AGListAjax", method=RequestMethod.POST, produces ="text/json;charset=UTF-8")
	@ResponseBody
	public String AGListAjax(ModelAndView mav, @RequestParam HashMap<String, String> params)throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = dao.getIntData("gallery.getGalleyCnt", params);
		System.out.println("cnt 성공");
		
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")),cnt, 9, 5);
		
		params.put("start",Integer.toString(pd.get("start")));
		params.put("end",Integer.toString(pd.get("end")));

		List<HashMap<String, String>> list = dao.getList("gallery.getGalleyList", params);
		System.out.println("전체조회 성공");
		
		model.put("list",list);
		model.put("pd", pd);
		
		//json형태로 바꿔줘야지 script에서 받을 수 있다.
		return mapper.writeValueAsString(model);
	}
	
	
	/**action 메소드(수정,등록,삭제)*/
	@RequestMapping(value="/AGAction/{gbn}",
	         method = RequestMethod.POST,
	         produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AGAction(HttpSession session,
							@PathVariable String gbn,
							@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0;
		
		try {
			switch (gbn) {
			case "insert":
					cnt = dao.insert("gallery.insertGallery", params);
				break;
				
			case "update":
				cnt = dao.update("gallery.updateGallery", params);
				break;
				
			case "delete":
				cnt = dao.update("gallery.deleteGallery", params);
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
		
		
		return  mapper.writeValueAsString(model);
	}
	
	//AGUpdate
	@RequestMapping(value="/AGUpdate")
	public ModelAndView AGUpdate(HttpSession session, 
										ModelAndView mav,
										 @RequestParam HashMap<String, String> params) throws Throwable {
		System.out.println("수정하기 param : "+params.toString());
		if(params.get("no")!=null && params.get("no")!= "") {
		
			HashMap<String, String> data = dao.getMapData("gallery.getG",params);
			mav.addObject("data", data);
			mav.setViewName("testa/AGALLERY/gupdate");
			
		}else {
			mav.setViewName("redirect:AGALLERY");
		}
		
		return mav;
	}
}
