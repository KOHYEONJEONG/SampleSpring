package com.gdj51.test.web.test.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDao implements ILoginDao {

	@Autowired
	public SqlSession sqlSession;

	@Override
	public HashMap<String, String> checkMem(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("login.checkMem", params);
	}
}
