package com.gdj51.test.web.test.dao;

import java.util.HashMap;
import java.util.List;

public interface IAnBoardDao {

	public List<HashMap<String, String>> getBoardList(HashMap<String, String> params) throws Throwable;

	public int insertBoard(HashMap<String, String> params) throws Throwable;

	public int delUpdateBoard(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getAnBoard(HashMap<String, String> params) throws Throwable;

	public int getAnBoardCnt(HashMap<String, String> params) throws Throwable;

	public int updateAnBoard(HashMap<String, String> params) throws Throwable;

	public void updateHit(HashMap<String, String> params)throws Throwable;

}
