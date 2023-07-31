package com.gdj51.test.common.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj51.test.common.CommonProperties;
import com.gdj51.test.util.Utils;

@Controller
public class FileController {
	@RequestMapping(value = "/fileUploadAjax", method = RequestMethod.POST, 
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String fileUploadAjax(HttpServletRequest request, 
								 ModelAndView modelAndView) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String, Object> modelMap = new HashMap<String, Object>();

		/* File Upload Logic */
		MultipartHttpServletRequest multipartRequest 
					= (MultipartHttpServletRequest) request;

		String uploadExts = CommonProperties.FILE_EXT;
		String uploadPath = CommonProperties.FILE_UPLOAD_PATH;
		String fileFullName = "";
		
		File folder = new File(uploadPath);//폴더 자체를 파일로 인식한다.

		if (!folder.exists()) { // 폴더 존재여부
			folder.mkdir(); // 폴더 생성
		}

		List<String> fileNames = new ArrayList<String>();//실제올라가는 파일명
		
		try {
			@SuppressWarnings("rawtypes")
			final Map files = multipartRequest.getFileMap();//파일명(name속성)을 가져와야함.
			Iterator<String> iterator = multipartRequest.getFileNames();

			while (iterator.hasNext()) {//첨부파일이 하나라도 있으면 실행하겠다.
				String key = iterator.next();//KEY로 취득한다(쉽게 말해 파일네임으로 가져온다)
				
				MultipartFile file = (MultipartFile) files.get(key);//파일로 끄내와 MultipartFile로 변경(하나만 꺼내옴) 
				
				if (file.getSize() > 0) {//파일을 보면 내용물의 크기를 확인 할 수 있다.
											//getSize() 넘어오는 바이트
											//0보다 커야지 올릴 수 있다.
					
					String fileRealName = file.getOriginalFilename(); // 실제파일명
					String fileTmpName = Utils.getPrimaryKey(); // 고유 날짜키 받기
					String fileExt = FilenameUtils.getExtension(
				
							file.getOriginalFilename()).toLowerCase(); // 파일
					// 확장자추출

					if (uploadExts.toLowerCase().indexOf(fileExt) < 0) {
						throw new Exception("Not allowded file extension : " 
												+ fileExt.toLowerCase());//확장자
					} else {
						// 물리적으로 저장되는 파일명(실제파일명을 그대로 저장할지 rename해서 저장할지는 협의 필요)
						fileFullName = fileTmpName + fileRealName;
						//File(경로) - 폴더
						//File(경로, 파일명) - 파일
						// new File(new File(uploadPath), fileFullName)
						// uploadPath경로의 폴더에 fileFullName 이름의 파일
						// 파일.transferTo(새파일) - 새파일에 파일의 내용을 전송
						
						file.transferTo(new File(new File(uploadPath), fileFullName));
						//(스프링에서 새로나옴, 엄청좋음!) 해당파일을 만들고 내용을 전송하겟다~
						//transferTo가 없을때는 엄청 길었음..
						//이 한줄로 파일 업로드가 끝난다!!!!!!!
						
						fileNames.add(fileFullName);
					}
				}
			}

			modelMap.put("result", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			// 공통 Exception 처리
			e.printStackTrace();
			modelMap.put("result", CommonProperties.RESULT_ERROR);
		}

		modelMap.put("fileName", fileNames);

		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/imageUploadAjax", method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String imageUploadAjax(HttpServletRequest request, 
			ModelAndView modelAndView) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String, Object> modelMap = new HashMap<String, Object>();
		
		/* File Upload Logic */
		MultipartHttpServletRequest multipartRequest 
		= (MultipartHttpServletRequest) request;
		
		String uploadExts = CommonProperties.IMG_EXT;
		String uploadPath = CommonProperties.FILE_UPLOAD_PATH;
		String fileFullName = "";
		
		File folder = new File(uploadPath);
		
		if (!folder.exists()) { // 폴더 존재여부
			folder.mkdir(); // 폴더 생성
		}
		
		List<String> fileNames = new ArrayList<String>();
		try {
			@SuppressWarnings("rawtypes")
			final Map files = multipartRequest.getFileMap();
			Iterator<String> iterator = multipartRequest.getFileNames();
			
			while (iterator.hasNext()) {
				String key = iterator.next();
				MultipartFile file = (MultipartFile) files.get(key);
				if (file.getSize() > 0) {
					String fileRealName = file.getOriginalFilename(); // 실제파일명
					String fileTmpName = Utils.getPrimaryKey(); // 고유 날짜키 받기
					String fileExt = FilenameUtils.getExtension(
							file.getOriginalFilename()).toLowerCase(); // 파일
					// 확장자추출
					
					if (uploadExts.toLowerCase().indexOf(fileExt) < 0) {
						throw new Exception("Not allowded image file extension : " 
								+ fileExt.toLowerCase());
					} else {
						fileFullName = fileTmpName + fileRealName;
						file.transferTo(new File(new File(uploadPath), fileFullName));
						
						fileNames.add(fileFullName);
					}
				}
			}
			
			modelMap.put("result", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			// 공통 Exception 처리
			e.printStackTrace();
			modelMap.put("result", CommonProperties.RESULT_ERROR);
		}
		
		modelMap.put("fileName", fileNames);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	/**
	 * CKEditor용 image업로드
	 **/
	@RequestMapping(value = "/imageUpload", method = RequestMethod.POST)
	public void editorImageUploadAjax(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload, ModelAndView modelAndView) throws Throwable {
		PrintWriter printWriter = null;
		try {
			String uploadExts = CommonProperties.IMG_EXT; // 확장자
			String uploadPath = CommonProperties.FILE_UPLOAD_PATH; // 업로드경로
			String fileFullName = "";

			File fileDir = new File(uploadPath);

			if (!fileDir.exists()) {
				fileDir.mkdirs(); // 디렉토리가 존재하지 않는다면 생성
			}

			if (upload.getSize() > 0) {
				String fileRealName = upload.getOriginalFilename().replace(" ", "_").toLowerCase(); // 실제파일명
				String fileTmpName = Utils.getPrimaryKey(); // 고유 날짜키 받기
				String fileExt = FilenameUtils.getExtension(upload.getOriginalFilename()).toLowerCase(); // 파일

				if (uploadExts.toLowerCase().indexOf(fileExt) >= 0) {
					fileFullName = fileTmpName + fileRealName;
					upload.transferTo(new File(fileDir, fileFullName));

				} else {
					// 파일 확장자가 틀릴 경우
					printWriter = response.getWriter();

					printWriter.println("<script type='text/javascript'>alert('파일 확장자가 지원을 하지 않습니다.');</script>");
					printWriter.flush();
					printWriter.close();
				}

				// 성공 시
				String callback = request.getParameter("CKEditorFuncNum");

				printWriter = response.getWriter();

				printWriter.println("<script type='text/javascript'>" + "window.parent.CKEDITOR.tools.callFunction("
						+ callback + ",'" + "resources/upload/" + fileFullName + "','이미지를 업로드 하였습니다.'" + ")</script>");
				printWriter.flush();
				printWriter.close();

			} else {
				// 파일 크기가 0이거나 없는 경우
				printWriter = response.getWriter();

				printWriter.println("<script type='text/javascript'>alert('파일 업로드에 실패하였습니다.');</script>");
				printWriter.flush();
				printWriter.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (printWriter != null) {
				printWriter.close();
			}
		}
	}
}
