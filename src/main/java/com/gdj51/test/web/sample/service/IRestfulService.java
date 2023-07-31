package com.gdj51.test.web.sample.service;

import java.util.List;

public interface IRestfulService {
	public List<String> getList() throws Throwable;

	public void putOne() throws Throwable;

	public String getTop() throws Throwable;
	
	public String getBottom() throws Throwable;

	public void patchOne() throws Throwable;

	public void deleteOne() throws Throwable;
}
