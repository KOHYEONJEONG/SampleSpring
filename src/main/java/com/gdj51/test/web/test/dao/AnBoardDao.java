package com.gdj51.test.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AnBoardDao implements IAnBoardDao {
	@Autowired
	public SqlSession sqlSession;

	@Override
	public List<HashMap<String, String>> getBoardList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("anboard.getBoardList",params);
	}

	@Override
	public int insertBoard(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("anboard.insertBoard", params);
	}

	@Override
	public int delUpdateBoard(HashMap<String, String> params) throws Throwable {
		// 삭제는 하지만, db에는 보관
		return sqlSession.update("anboard.delUpdateBoard", params);
	}

	@Override
	public HashMap<String, String> getAnBoard(HashMap<String, String> params) throws Throwable {
		// 상세보기
		return sqlSession.selectOne("anboard.getAnBoard",params);
	}

	
	
	@Override
	public int getAnBoardCnt(HashMap<String, String> params) throws Throwable {
		// 페이징과 검색어때문에 사용
		return sqlSession.selectOne("anboard.getAnBoardCnt", params);
	}

	@Override
	public int updateAnBoard(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.update("anboard.updateAnBoard",params);
	}

	@Override
	public void updateHit(HashMap<String, String> params) throws Throwable {
		sqlSession.update("anboard.updateHit",params);
		
	}
	
	
}
