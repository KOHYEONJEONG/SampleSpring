package com.gdj51.test.web.test2.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class TestAController {
	
	@RequestMapping(value="/testA")
	public ModelAndView testA(ModelAndView mav) {
		
		mav.setViewName("testa/testA");
		return mav;
	}
	
// RequestMapping의 method : 해당 주소의 접급 형태를 제한
// produces : 문서의 형태와 언어셋(오타나면 안됨)

//@ResponseBody : 결과가 View로 인식되게 함. 따라서 ViewResolver가 동작 안함.
             // Spring에서 결과가 View인척 하는 역할을 제공
	@RequestMapping(value="/testAAjax", method=RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String testAAjax(
					@RequestParam  HashMap<String, String> params
				) throws Throwable {
		
		System.out.println(params.toString());
		
		//JSON 핸들링(이것 때문에 할일이 많이 줄어든다.)
		ObjectMapper mapper = new ObjectMapper();
		
		//보낼 값들을 담을 객체
		Map<String, Object> model = new HashMap<String, Object>();
		
		model.put("msg","HI");//문자열 담기
		
		int[] arr = {3,6,9};
		model.put("arr",arr);//배열 담기
		
		//JSON으로 바꾸기 => {"msg" : "hi" , "arr" : "[3,6,9]"}
		
		//writeValueAsString(객체) : 객체의 내용을  JSON 문자열로 변환
		//단, 사용불가능한 형식이 들어올 수 있기 때문에 예외처리 필요
		System.out.println(mapper.writeValueAsString(model)); //예외처리 필수 , throws Throwable
		
		
		//java에서 aJax가 없다면 너무 불편하다.
		//자동으로 알아서 객체화 시켜준다.
		
		return mapper.writeValueAsString(model);
	}
}
