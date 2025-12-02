package com.kh.spring.exception;

public class InvalidAttachmentException extends RuntimeException{

	public InvalidAttachmentException(String message) {
		super(message);
	}
}
