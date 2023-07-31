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

public class AGalleryController { //세희님이 만드신 갤러리

	@Autowired
	public IACDao iACDao;

	@Autowired
	public IPagingService ips;

	@RequestMapping(value = "/AGList")
	public ModelAndView AGList(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {

		int page = 1;
		if (params.get("page") != null && params.get("page") != "") {
			page = Integer.parseInt(params.get("page"));
		}
		mav.addObject("page", page);

		mav.setViewName("testa/Gallery/list");
		return mav;
	}

	@RequestMapping(value = "/AGListAjax_sh", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String AGListAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> model = new HashMap<String, Object>();

		// 페이지 받아오게 되어있음
		int cnt = iACDao.getIntData("G.getGCnt", params);

		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 9, 5);

		params.put("start", Integer.toString(pd.get("start")));

		params.put("end", Integer.toString(pd.get("end")));

		List<HashMap<String, String>> list = iACDao.getList("G.getGList", params);

		model.put("list", list);

		model.put("pd", pd);

		System.out.println(params.toString());
		return mapper.writeValueAsString(model);
	}



	@RequestMapping(value = "/AGInsert_sh")

	public ModelAndView aGInsert(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		System.out.println(params.toString());
		mav.setViewName("testa/Gallery/insert");
		return mav;
	}



	@RequestMapping(value = "/AGAction_sh/{gbn}", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AGAction_sh(@PathVariable String gbn, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> model = new HashMap<String, Object>();
		int cnt = 0;
		try {
			switch (gbn) {

			case "insert":
				cnt = iACDao.insert("G.insertG", params);
				break;
			case "update":
				cnt = iACDao.update("G.updateG", params);
				break;
			case "delete":
				cnt = iACDao.update("G.deleteG", params);
				break;
			}
			if (cnt > 0) {
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
	// 가져오고 변경되는게 없기 때문에 비동기 처리로 안되도 됨
	//	@RequestMapping(value = "/AGDetail")

	//	public ModelAndView aGDetail(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {

	//		// 글번호 안 넘어왔을때 처리

	//		if (params.get("no") != null && params.get("no") != "") {

	//			// 조회수

	//			iACDao.update("G.updateGHit", params);

	//			HashMap<String, String> data = iACDao.getMap("G.getG", params);

	//

	//			mav.addObject("data", data);

	//

	//			mav.setViewName("testa/G/list");

	//		}

	//		/*

	//		 * else { mav.setViewName("redirect:AGList"); }

	//		 */

	//		return mav;

	//	}



	@RequestMapping(value = "/AGDetailAjax_sh", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AGDetailAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();

		HashMap<String, String> data = iACDao.getMapData("G.getG", params);
		model.put("data", data);
		System.out.println(params.toString());
		return mapper.writeValueAsString(model);
	}

	@RequestMapping(value = "/AGUpdate_sh")
	public ModelAndView aGUpdate(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		System.out.println(params.toString());
		// 글번호 안 넘어왔을때 처리
		if (params.get("no") != null && params.get("no") != "") {

			HashMap<String, String> data = iACDao.getMapData("G.getG", params);
			mav.addObject("data", data);
			mav.setViewName("testa/Gallery/update");
		} else {
			mav.setViewName("redirect:AGList");

		}
		return mav;
	}
}