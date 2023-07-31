package com.gdj51.test.web.test.service;

import java.util.HashMap;
import java.util.List;

public interface IAnBoardService {

	public List<HashMap<String, String>> getBoardList(HashMap<String, String> params) throws Throwable;

	public int insertAnBoard(HashMap<String, String> params) throws Throwable;

	public int delUpdateAnBoard(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getAnBoard(HashMap<String, String> params) throws Throwable;

	//검색어 때문에 params가 필요하다, 전체 조회시에는 인자값이 필요 없음
	public int getAnBoardCnt(HashMap<String, String> params) throws Throwable;

	public int updateAnBoard(HashMap<String, String> params) throws Throwable;

	public void updateHit(HashMap<String, String> params) throws Throwable;//조회수 증가

}
