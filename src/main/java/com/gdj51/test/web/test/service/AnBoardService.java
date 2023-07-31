package com.gdj51.test.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj51.test.web.test.dao.IAnBoardDao;

@Service
public class AnBoardService implements IAnBoardService {

	@Autowired
	public IAnBoardDao iAnBoardDao;
	
	@Override
	public List<HashMap<String, String>> getBoardList(HashMap<String, String> params) throws Throwable {
		return iAnBoardDao.getBoardList(params);
	}

	@Override
	public int insertAnBoard(HashMap<String, String> params) throws Throwable {
		return iAnBoardDao.insertBoard(params);
	}

	@Override
	public int delUpdateAnBoard(HashMap<String, String> params) throws Throwable {
		return iAnBoardDao.delUpdateBoard(params);
	}

	@Override
	public HashMap<String, String> getAnBoard(HashMap<String, String> params) throws Throwable {
		// 상세보기
		return iAnBoardDao.getAnBoard(params);
	}

	@Override
	public int getAnBoardCnt(HashMap<String, String> params) throws Throwable {
		//페이징처리와 검색
		return iAnBoardDao.getAnBoardCnt(params);
	}

	@Override
	public int updateAnBoard(HashMap<String, String> params) throws Throwable {
		return iAnBoardDao.updateAnBoard(params);
	}

	@Override
	public void updateHit(HashMap<String, String> params) throws Throwable {
		// 조회수 증가
		iAnBoardDao.updateHit(params);
		
	}

	
}
