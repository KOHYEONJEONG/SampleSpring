package com.gdj51.test.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDao implements IMemberDao {
	//root-context.xml에서 mabatis사용할거 불러옴.
	@Autowired
	public SqlSession sqlSession; /*db접속*/

	@Override
	public List<HashMap<String, String>> memberList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("mem.memberList",params);
	}

	@Override
	public int memberInsert(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("mem.memberInsert", params);
	}

	@Override
	public HashMap<String, String> getMember(HashMap<String, String> params) throws Throwable {
		//no
		return sqlSession.selectOne("mem.getMember", params);
	}

	@Override
	public int updateMember(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("mem.updateMember", params);
	}

	@Override
	public int deleteMember(HashMap<String, String> params) throws Throwable {
		//삭제지만 수정(del = 0으로 변경)
		return sqlSession.update("mem.deleteMember", params);
	}

	@Override
	public int getMemberCnt(HashMap<String, String> params) throws Throwable {
		//파라미터 검색어
		return sqlSession.selectOne("mem.getMemberCnt", params);
	}
	
	
	
	
}
