package com.gdj51.test.exception;

public class UserNotFoundException extends RuntimeException{
	private static final long serialVersionUID = 1L;
	private String customMsg;

	// 생성자 
	public UserNotFoundException(String customMsg) {
		this.customMsg = customMsg;
	}
	
	public String getCustomMsg() {
		return customMsg;
	}

	public void setCustomMsg(String customMsg) {
		this.customMsg = customMsg;
	}
}