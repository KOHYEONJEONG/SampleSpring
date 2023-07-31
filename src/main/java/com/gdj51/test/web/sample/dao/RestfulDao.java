package com.gdj51.test.web.sample.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RestfulDao implements IRestfulDao {
	@Autowired
	public SqlSessionTemplate sql;
	
	@Override
	public List<String> getList() throws Throwable {
		return sql.selectList("rest.getList");
	}

	@Override
	public void putOne() throws Throwable {
		sql.insert("rest.putOne");
	}

	@Override
	public String getTop() throws Throwable {
		return sql.selectOne("rest.getTop");
	}
	
	@Override
	public String getBottom() throws Throwable {
		return sql.selectOne("rest.getBottom");
	}

	@Override
	public void patchOne() throws Throwable {
		sql.update("rest.patchOne");
	}

	@Override
	public void deleteOne() throws Throwable {
		sql.delete("rest.deleteOne");
	}
}
