package com.gdj51.test.web.sample.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChatDao implements IChatDao {
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getMaxNo() throws Throwable {
		return (int) sqlSession.selectOne("chat.getMaxNo");
	}

	@Override
	public void insertChat(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("chat.insertChat", params);
	}

	@Override
	public List<HashMap<String, String>> getChatList(int lastChatNo) throws Throwable {
		return sqlSession.selectList("chat.getChatList", lastChatNo);
	}
}
