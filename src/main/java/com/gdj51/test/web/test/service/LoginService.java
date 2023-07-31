package com.gdj51.test.web.test.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj51.test.web.test.dao.ILoginDao;

@Service
public class LoginService implements ILoginService {

	@Autowired
	public ILoginDao iLoginDao;

	@Override
	public HashMap<String, String> checkMem(HashMap<String, String> params) throws Throwable {
		return iLoginDao.checkMem(params);
	}
	
	
}
