package com.gdj51.test.web.sample.service;

import java.util.HashMap;
import java.util.List;

public interface ISampleBoardService {

	public void insertBoard(HashMap<String, String> param) throws Throwable;

	public int getBoardCount(HashMap<String, String> params) throws Throwable;
	
	public List<HashMap<String, String>> getBoardList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getBoardDetail(String boardNo) throws Throwable;

	public void updateHitCnt(String boardNo) throws Throwable;

	public String checkPass(HashMap<String, String> params) throws Throwable;

	public void updateBoard(HashMap<String, String> params) throws Throwable;

	public void deleteBoard(HashMap<String, String> params) throws Throwable;

}
