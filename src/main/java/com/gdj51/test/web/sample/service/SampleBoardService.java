package com.gdj51.test.web.sample.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj51.test.web.sample.dao.ISampleBoardDao;

@Service
public class SampleBoardService implements ISampleBoardService {
	@Autowired
	public ISampleBoardDao iSampleBoardDao;

	@Override
	public void insertBoard(HashMap<String, String> params) throws Throwable {
		iSampleBoardDao.insertBoard(params);
	}

	@Override
	public int getBoardCount(HashMap<String, String> params) throws Throwable {
		return iSampleBoardDao.getBoardCount(params);
	}

	@Override
	public List<HashMap<String, String>> getBoardList(HashMap<String, String> params) throws Throwable {
		return iSampleBoardDao.getBoardList(params);
	}

	@Override
	public HashMap<String, String> getBoardDetail(String boardNo) throws Throwable {
		return iSampleBoardDao.getBoardDetail(boardNo);
	}

	@Override
	public void updateHitCnt(String boardNo) throws Throwable {
		iSampleBoardDao.updateHitCnt(boardNo);
	}

	@Override
	public String checkPass(HashMap<String, String> params) throws Throwable {
		return iSampleBoardDao.checkPass(params);
	}

	@Override
	public void updateBoard(HashMap<String, String> params) throws Throwable {
		iSampleBoardDao.updateBoard(params);
	}

	@Override
	public void deleteBoard(HashMap<String, String> params) throws Throwable {
		iSampleBoardDao.deleteBoard(params);
	}
}
