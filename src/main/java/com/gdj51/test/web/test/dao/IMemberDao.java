package com.gdj51.test.web.test.dao;

import java.util.HashMap;
import java.util.List;

public interface IMemberDao {

	public List<HashMap<String, String>> memberList(HashMap<String, String> params) throws Throwable;

	public int memberInsert(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getMember(HashMap<String, String> params) throws Throwable;

	public int updateMember(HashMap<String, String> params) throws Throwable;

	public int deleteMember(HashMap<String, String> params) throws Throwable;

	public int getMemberCnt(HashMap<String, String> params) throws Throwable;
	

}
