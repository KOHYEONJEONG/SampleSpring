package com.gdj51.test.web.sample.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gdj51.test.common.service.IPagingService;
import com.gdj51.test.web.sample.service.ISampleBoardService;

@Controller
public class SyncBoardController {
	private static final Logger logger = LoggerFactory.getLogger(SyncBoardController.class);

	@Autowired
	public ISampleBoardService iSampleBoardService;

	@Autowired
	public IPagingService iPagingService;

	@RequestMapping(value = "/syncList")
	public ModelAndView ajaxBoard(@RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
		try {
			// 페이징 정보 추가
			int page = 1;
			
			if (params.get("page") != null && params.get("page") != "") {
				page = Integer.parseInt(params.get("page"));
			}
			
			int count = iSampleBoardService.getBoardCount(params);

			HashMap<String, Integer> pd = iPagingService.getPagingData(page, count, 3, 3);
			params.put("startCount", Integer.toString(pd.get("start")));
			params.put("endCount", Integer.toString(pd.get("end")));

			List<HashMap<String, String>> list = iSampleBoardService.getBoardList(params);

			modelAndView.addObject("page", page);
			modelAndView.addObject("pd", pd);
			modelAndView.addObject("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		modelAndView.setViewName("sample/syncBoard/list");

		return modelAndView;
	}
	
	@RequestMapping(value = "/syncWrite")
	public ModelAndView syncWrite(ModelAndView modelAndView) throws Throwable {
		modelAndView.setViewName("sample/syncBoard/write");
		
		return modelAndView;
	}

	@RequestMapping(value = "/syncAction", method = RequestMethod.POST)
	public ModelAndView bookAction(@RequestParam HashMap<String, String> params,
								 ModelAndView mav) throws Throwable {
		try {
			switch(params.get("gbn")) {
			case "i" :
				iSampleBoardService.insertBoard(params);
				
				break;
			case "u" :
				String uCheck = iSampleBoardService.checkPass(params);
				
				mav.addObject("check", uCheck);

				if(uCheck.equals("TRUE")) {
					iSampleBoardService.updateBoard(params);
					mav.addObject("state", 1);
				} else {
					mav.addObject("state", 0);
				}
				
				break;
			case "d" :
				String dCheck = iSampleBoardService.checkPass(params);
				
				mav.addObject("check", dCheck);
				
				if(dCheck.equals("TRUE")) {
					iSampleBoardService.deleteBoard(params);
					
					mav.addObject("state", 1);
				} else {
					mav.addObject("state", 0);
				}
				
				break;
			}
			
			mav.addObject("res", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("res", "error");
		}
		
		mav.setViewName("sample/syncBoard/syncAction");
		
		return mav;
	}

	@RequestMapping(value = "/syncDetail", method = RequestMethod.POST)
	public ModelAndView ajaxBoardReadDetail(HttpServletRequest request, @RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {

		try {
			String boardNo = request.getParameter("boardNo");

			iSampleBoardService.updateHitCnt(boardNo);

			HashMap<String, String> data = iSampleBoardService.getBoardDetail(boardNo);

			modelAndView.addObject("data", data);
		} catch (Exception e) {
			e.printStackTrace();
		}

		modelAndView.setViewName("sample/syncBoard/detail");
		
		return modelAndView;
	}
	
	@RequestMapping(value = "/syncUpdate", method = RequestMethod.POST)
	public ModelAndView syncUpdate(HttpServletRequest request, @RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
		
		try {
			String boardNo = request.getParameter("boardNo");
			
			HashMap<String, String> data = iSampleBoardService.getBoardDetail(boardNo);
			
			modelAndView.addObject("data", data);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		modelAndView.setViewName("sample/syncBoard/update");
		
		return modelAndView;
	}
}
