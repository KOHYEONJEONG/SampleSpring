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
import com.gdj51.test.web.test2.dao.IACDao;

@Controller
public class ATController { //db는 TBoard_SQL.xml이고 name은 T(대문자)이다.

	@Autowired
	public IACDao iacDao;
	
	@Autowired
	public PagingService ips;
	
	@RequestMapping(value="/ATList")
	public ModelAndView ATList(@RequestParam HashMap<String, String> params,
									ModelAndView mav) throws Throwable {
		
		int page = 1;//첫페이지로 나타내려고
		
		if(params.get("page")!= null && params.get("page") != "") {
			page = Integer.parseInt(params.get("page"));
		}
		
		//페이지 번호
		mav.addObject("page", page);
		
		//카테고리 목록 취득
		List<HashMap<String,String>> cate = iacDao.getList("cate.getCateAllList");
		mav.addObject("cate", cate);
		
		mav.setViewName("testa/T/list");
		
		return mav;
	}
	
	@RequestMapping(value="/ATListAjax", method=RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ATListAjax(ModelAndView mav, @RequestParam HashMap<String, String> params)throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt =iacDao.getIntData("T.getTBoardCnt", params);
		
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")),cnt, 3, 5);
		
		params.put("start",Integer.toString(pd.get("start")));
		params.put("end",Integer.toString(pd.get("end")));

		List<HashMap<String, String>> list = iacDao.getList("T.getTBoardList", params);
		
		model.put("list",list);
		model.put("pd", pd);
		
		//json형태로 바꿔줘야지 script에서 받을 수 있다.
		//ObjectMapper를 사용하는 이유는 :
		//==>객체(list)를 그대로 보내면 JSON으로 못받으니 json 형태의 문자열로 만든 다음 보냄(list로 바로 보낼 수는 있지만 json으로 못받을 뿐)
		return mapper.writeValueAsString(model);
	}
	
	@RequestMapping(value="/ATInsert")
	public ModelAndView ATInsert(HttpSession session,
									@RequestParam HashMap<String, String> params,
										ModelAndView mav) throws Throwable {
			
		String cateNm = iacDao.getStringData("cate.getCate", params); //카테고리 선택한걸 가지고 insert.jsp로 들어감.
		
		mav.addObject("cateNm", cateNm);
		
		mav.setViewName("testa/T/insert");
		
		return mav;
	}
	
	  @RequestMapping(value="/ATAction/{gbn}",
		         method = RequestMethod.POST,
		         produces = "text/json;charset=UTF-8")
		   @ResponseBody
		   public String ATAction(
		         @PathVariable String gbn,
		         @RequestParam HashMap<String, String> params) throws Throwable{
		      ObjectMapper mapper = new ObjectMapper();
		      
		      Map<String, Object> model = new HashMap<String, Object>();
		      
		      int cnt = 0;
		      try {
		         switch (gbn) {
		         case "insert": 
		        	 cnt = iacDao.insert("T.tBoardInsert", params);
		            break;
		            
		         case "update": 
		        	 cnt = iacDao.update("T.tBoardUpdate", params);
		            break;
		            
		         case "delete": 
		        	 cnt = iacDao.update("T.tBoardDelete", params);
		            break;
		         }
		         
			         if(cnt > 0) {
			            model.put("msg", "success");
			         } else {
			            model.put("msg", "fail");
			         }
			         
		      } catch (Exception e) {
		         e.printStackTrace();
		         model.put("msg", "error");
		     
		      }
		      
		      
		      return mapper.writeValueAsString(model);
		   }

	 //가져오고나서 변경될 일 없음.
	  @RequestMapping(value="ATDetail")
	   public ModelAndView aTDetail (@RequestParam HashMap<String, String> params,
	         ModelAndView mav) throws Throwable {
	     
		  if(params.get("no")!=null && params.get("no")!= "") {
			  
			  //조회수 증가(상세보기 조회 전에 증가되야한다.)
			  iacDao.update("T.updateTboardHit", params);
			  
			  HashMap<String, String> data
              = iacDao.getMapData("T.getT", params);
  
			  String cateNm = iacDao.getStringData("cate.getCate", params);
				
				mav.addObject("cateNm", cateNm);
			  
			  mav.addObject("data", data);
			  
			  mav.setViewName("testa/T/detail");
		  }else {
			  mav.setViewName("redirect:ATList");
		  }
		  
		  
	      
	      return mav;
	   }
	  
	  @RequestMapping(value="ATUpdate")
	   public ModelAndView ATUpdate (@RequestParam HashMap<String, String> params,
	         ModelAndView mav) throws Throwable {
	     
		  if(params.get("no")!=null && params.get("no")!= "") {//수정도 로그인이 안되면 못하게 하잖아?
			  HashMap<String, String> data
             = iacDao.getMapData("T.getT", params);
			  
			  String cateNm = iacDao.getStringData("cate.getCate", params);
				
			  mav.addObject("cateNm", cateNm);
 
			  mav.addObject("data", data);
			  
			  mav.setViewName("testa/T/update");
		  }else {
			  mav.setViewName("redirect:ATList");
		  }
		  
		  
	      
	      return mav;
	   }
	
}
