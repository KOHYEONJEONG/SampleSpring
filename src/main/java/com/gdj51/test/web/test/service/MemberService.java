package com.gdj51.test.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj51.test.web.test.dao.IMemberDao;

@Service
public class MemberService implements IMemberService {
	
	@Autowired
	IMemberDao iMemberDao;
	
	@Override
	public List<HashMap<String, String>> memberList(HashMap<String, String> params) throws Throwable {
		return iMemberDao.memberList(params);
	}

	@Override
	public int insertMember(HashMap<String, String> params) throws Throwable {
		return iMemberDao.memberInsert(params);
	}

	@Override
	public HashMap<String, String> getMember(HashMap<String, String> params) throws Throwable {
		return iMemberDao.getMember(params);
	}

	@Override
	public int updateMember(HashMap<String, String> params) throws Throwable {
		return iMemberDao.updateMember(params);
	}

	@Override
	public int deleteMember(HashMap<String, String> params) throws Throwable {
		return iMemberDao.deleteMember(params);
	}

	@Override
	public int getMemberCnt(HashMap<String, String> params) throws Throwable {
		//페이징
		return iMemberDao.getMemberCnt(params);
	}

}
