package com.gdj51.test.web.sample.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class SampleBoardDao implements ISampleBoardDao {
	@Autowired
	public SqlSessionTemplate sqlSession;

	@Override
	@Transactional(rollbackFor = Exception.class) //요즘에는 어노테이션 하나로 작동이 됨. //rollbackFor = Exception.class 의미: 롤백은 예외가 발생했을 시 실행한다.
	public void insertBoard(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("sampleBoard.insertBoard", params);
	}

	@Override
	public int getBoardCount(HashMap<String, String> params) throws Throwable {
		return (int) sqlSession.selectOne("sampleBoard.getBoardCount", params);
	}

	@Override
	public List<HashMap<String, String>> getBoardList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("sampleBoard.getBoardList", params);
	}

	@SuppressWarnings("unchecked")
	@Override
	public HashMap<String, String> getBoardDetail(String boardNo) throws Throwable {
		return (HashMap<String, String>) sqlSession.selectOne("sampleBoard.getBoardDetail", boardNo);
	}

	@Override
	public void updateHitCnt(String boardNo) throws Throwable {
		sqlSession.update("sampleBoard.updateHitCnt", boardNo);
	}

	@Override
	public String checkPass(HashMap<String, String> abb) throws Throwable {
		return (String) sqlSession.selectOne("sampleBoard.checkPass", abb);
	}

	@Override
	public void updateBoard(HashMap<String, String> abb) throws Throwable {
		sqlSession.update("sampleBoard.updateBoard", abb);
	}

	@Override
	public void deleteBoard(HashMap<String, String> abb) throws Throwable {
		sqlSession.delete("sampleBoard.deleteBoard", abb);
	}
}
