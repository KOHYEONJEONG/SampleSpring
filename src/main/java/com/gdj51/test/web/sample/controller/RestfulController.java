package com.gdj51.test.web.sample.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gdj51.test.web.sample.service.IRestfulService;

@RestController
public class RestfulController {
	@Autowired
	public IRestfulService irfs;
	
	@GetMapping(value = "/restApi", produces = "application/json;charset=UTF-8")
	public List<String> getList() throws Throwable {
		List<String> list = irfs.getList();
		
		return list;
	}
	
	@PostMapping(value = "/restApi", produces = "application/json;charset=UTF-8")
	public List<String> postList() throws Throwable {
		List<String> list = irfs.getList();
		
		return list;
	}
	
	@PutMapping(value = "/restApi", produces = "application/json;charset=UTF-8")
	public String putOne() throws Throwable {
		irfs.putOne();
		
		String txt = irfs.getBottom();
		
		return txt;
	}
	
	@PatchMapping(value = "/restApi", produces = "application/json;charset=UTF-8")
	public String patchOne() throws Throwable {
		irfs.patchOne();
		
		String txt = irfs.getTop();
		
		return txt;
	}
	
	@DeleteMapping(value = "/restApi", produces = "application/json;charset=UTF-8")
	public List<String> deleteOne() throws Throwable {
		irfs.deleteOne();
		
		List<String> list = irfs.getList();
		
		return list;
	}
	
}
