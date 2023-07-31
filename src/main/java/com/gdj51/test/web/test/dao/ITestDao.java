package com.gdj51.test.web.test.dao;

import java.util.HashMap;
import java.util.List;

public interface ITestDao {

	
	//sell 테이블
	public List<HashMap<String, String>> getSellList(HashMap<String, String> params) throws Throwable;//페이징까지 합쳐서 가져올거임

	public HashMap<String, String> getSell(HashMap<String, String> params) throws Throwable;

	public int insertSell(HashMap<String, String> params) throws Throwable;

	public int deleteSell(HashMap<String, String> params) throws Throwable;

	public int updateSell(HashMap<String, String> params)throws Throwable;
	
	//manager 테이블
	public List<HashMap<String, String>> getManagerList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getManager(HashMap<String, String> params) throws Throwable;

	public int insertManager(HashMap<String, String> params) throws Throwable;

	public int updateManager(HashMap<String, String> params) throws Throwable;

	public int deleteManager(HashMap<String, String> params) throws Throwable;

	//divs 테이블
	public List<HashMap<String, String>> divsList() throws Throwable;

	public HashMap<String, String> getDivs(HashMap<String, String> params) throws Throwable;

	public int divsInsert(HashMap<String, String> params) throws Throwable;

	public int divsUpdate(HashMap<String, String> params) throws Throwable;

	public int divsDelete(HashMap<String, String> params) throws Throwable;

	//book 테이블
	public List<HashMap<String, String>> bookList() throws Throwable;

	public HashMap<String, String> getBook(HashMap<String, String> params) throws Throwable;

	public int bookInsert(HashMap<String, String> params) throws Throwable;

	public int bookUpdate(HashMap<String, String> params) throws Throwable;

	public int bookDelete(HashMap<String, String> params) throws Throwable;

	// ---------------- sell 페이징 ----------------
	public int getSellCnt(HashMap<String, String> params) throws Throwable;

	public int getMangerCnt(HashMap<String, String> params)throws Throwable;



}
