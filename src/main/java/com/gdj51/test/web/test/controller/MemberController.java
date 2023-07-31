package com.gdj51.test.web.test.controller;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gdj51.test.common.service.IPagingService;
import com.gdj51.test.web.test.service.IMemberService;

@Controller
public class MemberController {
	
	@Autowired
	IMemberService iMemberService;
	
	@Autowired
	IPagingService ips;
	
	@RequestMapping(value="/memberList")
	public ModelAndView memberList(@RequestParam HashMap<String, String> params,
									ModelAndView mav) throws Throwable {
		
		int page=1;
		
		if(params.get("page") != null && params.get("page") != "") {
			//페이지가 넘어왔을 때
			page = Integer.parseInt(params.get("page"));
		}
		
		System.out.println("총 조회 수 : "+params.toString());
		int cnt = iMemberService.getMemberCnt(params);
		
		HashMap<String, Integer> pd = ips.getPagingData(page, cnt , 3, 2);
		 
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
		
		//테이터 취득
		List<HashMap<String, String>> list = iMemberService.memberList(params);

		//목록데이터
		mav.addObject("list",list);
		
		//페이징 정보
		mav.addObject("pd", pd);
		
		//현재 페이지
		mav.addObject("page", page);
		
		//총 건수
		mav.addObject("cnt", cnt);
		
		mav.setViewName("member/memberList");
		return mav;
	}
	
	@RequestMapping(value="/insertMemberPage")
	public ModelAndView insertMemberPage(ModelAndView mav) {
		//insert 페이지로 이동
		mav.setViewName("member/memberInsert");
		return mav;
	}
	
	@RequestMapping(value="/memberDetail")
	public ModelAndView memberDetail(@RequestParam HashMap< String, String> params,
									ModelAndView mav) throws Throwable {
		
		System.out.println("상세보기 페이지 : "+ params.toString());
		if(params.get("no") == null && params.get("no") == "") {
			mav.setViewName("redirect:memberList");
		}else {
			System.out.println("상세보기 성공");
			HashMap<String, String> data = iMemberService.getMember(params);
			mav.addObject("data", data);
			mav.setViewName("member/memberDetail");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/updateMemberPage")
	public ModelAndView updateMemberPage(@RequestParam HashMap<String, String> params,
											ModelAndView mav) throws Throwable {
		
		System.out.println("업데이트 페이지 파라미터 : "+ params.toString());
		if(params.get("no") == null && params.get("no") == "") {
			mav.setViewName("redirect:memberList");
		}else {
			System.out.println("업데이트 조회 성공");
			HashMap<String, String> data = iMemberService.getMember(params);
			mav.addObject("data", data);
			mav.setViewName("member/memberUpdate");
		}
		
		return mav;
	}
									
		
	@RequestMapping("/memberRes/{action}")
	public ModelAndView memberRes(@PathVariable String action,
									@RequestParam HashMap<String, String> params,
									ModelAndView mav) throws Throwable{
		int cnt = 0;
		try {
			switch (action) {
			case "insert":
					cnt = iMemberService.insertMember(params);
				break;
			case "update":
				cnt = iMemberService.updateMember(params);
				mav.addObject("flag","u");
			break;
			case "delete":
				System.out.println("삭제 : "+ params.toString());
				cnt = iMemberService.deleteMember(params);
			break;
			}
			
			if(cnt > 0 ) {
				mav.addObject("res", "success");
			}else {
				mav.addObject("res", "failed");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			mav.addObject("res","failed");
		}
		
		mav.setViewName("member/memberRes");
		return mav;
	}
	
	
	
}
