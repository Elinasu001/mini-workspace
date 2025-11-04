package com.kh.spring.exception;

public class BadRequestException extends RuntimeException {
	
	public BadRequestException(String msg) {
		super(msg);
	}
	
}
