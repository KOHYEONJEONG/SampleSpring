package com.gdj51.test.web.sample.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj51.test.common.CommonProperties;
import com.gdj51.test.common.service.IPagingService;
import com.gdj51.test.web.sample.service.ISampleBoardService;

@Controller
public class AjaxBoardController {
	private static final Logger logger = LoggerFactory.getLogger(AjaxBoardController.class);

	@Autowired
	public ISampleBoardService iSampleBoardService;

	@Autowired
	public IPagingService iPagingService;

	@RequestMapping(value = "/ajaxBoard")
	public ModelAndView ajaxBoard(ModelAndView modelAndView) throws Throwable {
		modelAndView.setViewName("sample/ajaxBoard/ajaxBoard");
		
		logger.info("ajaxBoard실행");
		
		return modelAndView;
	}

	@RequestMapping(value = "/ajaxBoardInsertResult", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ajaxBoardInsertResult(@RequestParam HashMap<String, String> params)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iSampleBoardService.insertBoard(params);

			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/ajaxBoardReadList", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ajaxBoardReadList(@RequestParam HashMap<String, String> params)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			int count = iSampleBoardService.getBoardCount(params);

			HashMap<String, Integer> pd = iPagingService.getPagingData(Integer.parseInt(params.get("page")), count, 3, 3);
			params.put("startCount", Integer.toString(pd.get("start")));
			params.put("endCount", Integer.toString(pd.get("end")));

			List<HashMap<String, String>> list = iSampleBoardService.getBoardList(params);

			modelMap.put("pd", pd);
			modelMap.put("list", list);

			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/ajaxBoardReadDetail", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ajaxBoardReadDetail(@RequestParam String boardNo) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iSampleBoardService.updateHitCnt(boardNo);

			HashMap<String, String> params = iSampleBoardService.getBoardDetail(boardNo);

			modelMap.put("params", params);

			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}
	

	// 조회수 증가 없이 조회
	@RequestMapping(value = "/ajaxBoardReadNoHitDetail", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ajaxBoardReadNoHitDetail(@RequestParam String boardNo) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			HashMap<String, String> params = iSampleBoardService.getBoardDetail(boardNo);
			
			modelMap.put("params", params);
			
			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}
		
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/ajaxBoardPassCheckResult", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ajaxBoardPassCheckResult(@RequestParam HashMap<String, String> params)
			throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			String result = iSampleBoardService.checkPass(params);

			modelMap.put("result", result);

			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/ajaxBoardUpdateResult", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ajaxBoardUpdateResult(@RequestParam HashMap<String, String> params)
			throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iSampleBoardService.updateBoard(params);

			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/ajaxBoardDeleteResult", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ajaxBoardDeleteResult(@RequestParam HashMap<String, String> params)
			throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iSampleBoardService.deleteBoard(params);

			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}
}
