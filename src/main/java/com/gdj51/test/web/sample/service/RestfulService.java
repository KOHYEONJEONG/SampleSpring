package com.gdj51.test.web.sample.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj51.test.web.sample.dao.IRestfulDao;

@Service
public class RestfulService implements IRestfulService {
	@Autowired
	public IRestfulDao irfd;
	
	@Override
	public List<String> getList() throws Throwable {
		return irfd.getList();
	}

	@Override
	public void putOne() throws Throwable {
		irfd.putOne();
	}

	@Override
	public String getTop() throws Throwable {
		return irfd.getTop();
	}
	
	@Override
	public String getBottom() throws Throwable {
		return irfd.getBottom();
	}

	@Override
	public void patchOne() throws Throwable {
		irfd.patchOne();
	}

	@Override
	public void deleteOne() throws Throwable {
		irfd.deleteOne();
	}

}
