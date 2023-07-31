package com.gdj51.test.web.test.dao;

import java.util.HashMap;
import java.util.List;

public interface ITBoardDao {

	public int getTBoardCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getTBoardList(HashMap<String, String> params)  throws Throwable;

	public int tBoardInsert(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getT(HashMap<String, String> params) throws Throwable;

	public void updateTboardHit(HashMap<String, String> params) throws Throwable;

	public int tBoardDelete(HashMap<String, String> params) throws Throwable;

	public int tBoardUpdate(HashMap<String, String> params) throws Throwable;

}
