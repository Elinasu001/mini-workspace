package com.kh.spring.event.model.dto;

import lombok.Data;

@Data
public class EventAttachmentDTO {
	private Long fileNo;       // 파일 번호
	private int refBno;        // 참조 게시글 번호
	private String originName; // 원본 파일명
	private String changeName; // 변경 파일명
	private String filePath;   // 저장 경로
	private int fileLevel;     // 파일 구분 (0: 썸네일 / 1: 상세)
}
