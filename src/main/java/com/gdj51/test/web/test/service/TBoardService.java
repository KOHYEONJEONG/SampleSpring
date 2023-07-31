package com.gdj51.test.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj51.test.web.test.dao.ITBoardDao;

@Service
public class TBoardService implements ITBoardService {
	
	@Autowired
	public ITBoardDao iTBoardDao;

	@Override
	public int getTBoardCnt(HashMap<String, String> params) throws Throwable {
		return iTBoardDao.getTBoardCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getTBoardList(HashMap<String, String> params) throws Throwable {
		return iTBoardDao.getTBoardList(params);
	}

	@Override
	public int tBoardInsert(HashMap<String, String> params) throws Throwable {
		return iTBoardDao.tBoardInsert(params);
	}

	@Override
	public void updateTboardHit(HashMap<String, String> params) throws Throwable {
		//상세보기 전에 조회수 증가
		iTBoardDao.updateTboardHit(params);
	}
	
	@Override
	public HashMap<String, String> getT(HashMap<String, String> params) throws Throwable {
		//상세보기
		return iTBoardDao.getT(params);
	}

	@Override
	public int tBoardDelete(HashMap<String, String> params) throws Throwable {
		return iTBoardDao.tBoardDelete(params);
	}

	@Override
	public int tBoardUpdate(HashMap<String, String> params) throws Throwable {
		// 수정
		return iTBoardDao.tBoardUpdate(params);
	}

	
}
