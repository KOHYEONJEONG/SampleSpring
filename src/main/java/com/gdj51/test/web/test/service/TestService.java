package com.gdj51.test.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj51.test.web.test.dao.ITestDao;

@Service
public class TestService implements ITestService {
	
	// resouces폴더-mapper폴더-Test_SQL.xml

	@Autowired
	public ITestDao iTestDao; /*dao접속*/
	//인터페이스가 쓰고 있는 주소를 찾아와서 클래스 객체가 넘어옴.
	

	@Override
	public List<HashMap<String, String>> getSellList(HashMap<String, String> params) throws Throwable {
		return iTestDao.getSellList(params);
	}


	@Override
	public HashMap<String, String> getSell(HashMap<String, String> params) throws Throwable {
		return iTestDao.getSell(params);
	}



	@Override
	public int inserSell(HashMap<String, String> params) throws Throwable {
		return iTestDao.insertSell(params);
	}


	@Override
	public int deleteSell(HashMap<String, String> params) throws Throwable {
		return iTestDao.deleteSell(params);
	}


	@Override
	public int updateSell(HashMap<String, String> params) throws Throwable {
		return iTestDao.updateSell(params);
	}

   //manager 테이블	
	@Override
	public List<HashMap<String, String>> getManagerList(HashMap<String, String> params) throws Throwable {
		return iTestDao.getManagerList(params);
	}

	@Override
	public HashMap<String, String> getManager(HashMap<String, String> params) throws Throwable {
		return iTestDao.getManager(params);
	}

	@Override
	public int insertManager(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iTestDao.insertManager(params);
	}


	@Override
	public int updateManger(HashMap<String, String> params) throws Throwable {
		return iTestDao.updateManager(params);
	}


	@Override
	public int deleteManger(HashMap<String, String> params) throws Throwable {
		return iTestDao.deleteManager(params);
	}


	//divs 테이블
	@Override
	public List<HashMap<String, String>> getDivsList() throws Throwable {
		return iTestDao.divsList();
	}


	@Override
	public HashMap<String, String> getDivs(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iTestDao.getDivs(params);
	}


	@Override
	public int insertDivs(HashMap<String, String> params) throws Throwable {
		return iTestDao.divsInsert(params);
	}


	@Override
	public int updateDivs(HashMap<String, String> params) throws Throwable {
		return iTestDao.divsUpdate(params);
	}


	@Override
	public int deleteDivs(HashMap<String, String> params) throws Throwable {
		return iTestDao.divsDelete(params);
	}


	//book 테이블
	@Override
	public List<HashMap<String, String>> getBookList() throws Throwable {
		// TODO Auto-generated method stub
		return iTestDao.bookList();
	}


	@Override
	public HashMap<String, String> getBook(HashMap<String, String> params) throws Throwable {
		return iTestDao.getBook(params);
	}


	@Override
	public int insertBook(HashMap<String, String> params) throws Throwable {
		return iTestDao.bookInsert(params);
	}


	@Override
	public int updateBook(HashMap<String, String> params) throws Throwable {
		return iTestDao.bookUpdate(params);
	}


	@Override
	public int deleteBook(HashMap<String, String> params) throws Throwable {
		return iTestDao.bookDelete(params);
	}


	// ---------------- sell 페이징 ----------------
	@Override
	public int getSellCnt(HashMap<String, String> params) throws Throwable {
		return iTestDao.getSellCnt(params);
	}


	@Override
	public int getManagerCnt(HashMap<String, String> params) throws Throwable {
		return iTestDao.getMangerCnt(params);
	}






	
}
