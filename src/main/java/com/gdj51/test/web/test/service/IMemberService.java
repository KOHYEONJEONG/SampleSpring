package com.gdj51.test.web.test.service;

import java.util.HashMap;
import java.util.List;

public interface IMemberService {

	//전체조회+가져올 데이터수
	public List<HashMap<String, String>> memberList(HashMap<String, String> params) throws Throwable;

	public int insertMember(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getMember(HashMap<String, String> params) throws Throwable;

	public int updateMember(HashMap<String, String> params) throws Throwable;

	public int deleteMember(HashMap<String, String> params) throws Throwable;

	//페이징
	public int getMemberCnt(HashMap<String, String> params) throws Throwable;

}
