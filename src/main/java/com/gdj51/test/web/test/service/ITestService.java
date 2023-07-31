package com.gdj51.test.web.test.service;

import java.util.HashMap;
import java.util.List;

public interface ITestService {
	
	//sell 테이블
	//접근권한과 예외처리 ㅎ주기(db에 붙기 때문에)
	public List<HashMap<String, String>> getSellList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getSell(HashMap<String, String> params) throws Throwable;

	public int inserSell(HashMap<String, String> params) throws Throwable;

	public int deleteSell(HashMap<String, String> params) throws Throwable;

	public int updateSell(HashMap<String, String> params) throws Throwable;
	
	//manager 테이블
	public List<HashMap<String, String>> getManagerList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getManager(HashMap<String, String> params) throws Throwable;

	public int insertManager(HashMap<String, String> params) throws Throwable;

	public int updateManger(HashMap<String, String> params) throws Throwable;

	public int deleteManger(HashMap<String, String> params)  throws Throwable;

	//divs 테이블
	public List<HashMap<String, String>> getDivsList() throws Throwable;

	public HashMap<String, String> getDivs(HashMap<String, String> params) throws Throwable;

	public int insertDivs(HashMap<String, String> params) throws Throwable;

	public int updateDivs(HashMap<String, String> params) throws Throwable;

	public int deleteDivs(HashMap<String, String> params) throws Throwable;

	//book 테이블
	public List<HashMap<String, String>> getBookList() throws Throwable;

	public HashMap<String, String> getBook(HashMap<String, String> params)  throws Throwable;

	public int insertBook(HashMap<String, String> params)  throws Throwable;

	public int updateBook(HashMap<String, String> params)  throws Throwable;

	public int deleteBook(HashMap<String, String> params) throws Throwable;

	//sell 페이징
	public int getSellCnt(HashMap<String, String> params) throws Throwable;

	public int getManagerCnt(HashMap<String, String> params) throws Throwable;



}
