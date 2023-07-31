package com.gdj51.test.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gdj51.test.web.test.service.ITBoardService;

@Repository
public class TBoardDao implements ITBoardDao {

	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getTBoardCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("T.getTBoardCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getTBoardList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("T.getTBoardList",params);
	}

	@Override
	public int tBoardInsert(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("T.tBoardInsert", params);
	}

	@Override
	public HashMap<String, String> getT(HashMap<String, String> params) throws Throwable {
		//상세보기 조회
		return sqlSession.selectOne("T.getT",params);
	}

	@Override
	public void updateTboardHit(HashMap<String, String> params) throws Throwable {
		//조회수 증가(조건: 상세보기 조회되기잔에 증가되야함)
		sqlSession.update("T.updateTboardHit" , params);
	}

	@Override
	public int tBoardDelete(HashMap<String, String> params) throws Throwable {
		//말은 삭제지만, 사실 업데이트임 (del컬럼 값을 0으로 바껴야함.)
		return sqlSession.update("T.tBoardDelete", params);
	}

	@Override
	public int tBoardUpdate(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("T.tBoardUpdate", params);
	}
}

