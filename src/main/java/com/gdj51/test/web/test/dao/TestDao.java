package com.gdj51.test.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository //저장소에 붙는다.(dao는 개발자가 쓰는 말이라 @dao는 아님)  
public class TestDao implements ITestDao {

	//root-context.xml에서 mabatis사용할거 불러옴.
	@Autowired
	public SqlSession sqlSession; /*db접속*/

	@Override
	public List<HashMap<String, String>> getSellList(HashMap<String, String> params) throws Throwable {
		// selectList로 한이유는 return형태가 List이기때문에
		return sqlSession.selectList("test.getSellList", params);
		//selectList("namespace.id"); : 해당 namespace에 있는 id를 찾아서 조회 실행, 결과 '목록'을 받음
	}

	@Override
	public HashMap<String, String> getSell(HashMap<String, String> params) {
		//selectOne(쿼리, 데이터) : 한줄만 받아오기
		                       //해당 퀴리에 데이터를 전달하고 '한건'을 돌려받음
		return sqlSession.selectOne("test.getSell",params);
	}

	@Override
	public int insertSell(HashMap<String, String> params) throws Throwable {
		//sellInsert.jsp에서 등록
		//등록이니까 insert(쿼리, 데이터)
		return sqlSession.insert("test.insertSell",params);
	}

	@Override
	public int deleteSell(HashMap<String, String> params) throws Throwable {
		// sellDetail.jsp에서 삭제버튼 
		// 삭제니까 delete(쿼리, 데이터)
		return sqlSession.delete("test.deleteSell", params);
	}

	@Override
	public int updateSell(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("test.updateSell", params);
	}

	//manager 테이블
	@Override
	public List<HashMap<String, String>> getManagerList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("test.getManagerList", params);
	}

	@Override
	public HashMap<String, String> getManager(HashMap<String, String> params) throws Throwable {
		//매니저 한명만 조회
		return sqlSession.selectOne("test.getManager",params);// "test.getManager"는 namespace에 있는 id를 찾아서 조회 실행, 결과 '목록'을 받음
	}

	@Override
	public int insertManager(HashMap<String, String> params) throws Throwable {
		//매니저 등록
		return sqlSession.insert("test.insertManager", params);
	}

	@Override
	public int updateManager(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("test.updateManager", params);
	}

	@Override
	public int deleteManager(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("test.deleteManager", params);
	}

	// divs 테이블
	@Override
	public List<HashMap<String, String>> divsList() throws Throwable {
		return sqlSession.selectList("test.divsList");
	}

	@Override
	public HashMap<String, String> getDivs(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("test.getDivs",params);
	}

	@Override
	public int divsInsert(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("test.divsInsert", params);
	}

	@Override
	public int divsUpdate(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("test.divsUpdate", params);
	}

	@Override
	public int divsDelete(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("test.divsDelete", params);
	}

	
	//book 테이블
	@Override
	public List<HashMap<String, String>> bookList() throws Throwable {
		return sqlSession.selectList("test.bookList");
	}

	@Override
	public HashMap<String, String> getBook(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("test.getbook", params);
	}

	@Override
	public int bookInsert(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("test.bookInsert",params);
	}

	@Override
	public int bookUpdate(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("test.bookUpdate", params);
	}

	@Override
	public int bookDelete(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("test.bookDelete", params);
	}

	
	// ---------------- sell 페이징 ----------------
	@Override
	public int getSellCnt(HashMap<String, String> params) throws Throwable {
		//페이징을 하기 위해서
		return sqlSession.selectOne("test.getSellCnt", params); //총개수를 구하기 때문에 selectOne 사용
		
	}

	@Override
	public int getMangerCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("test.getManagerCnt",params);
	}

	
	


	
}
