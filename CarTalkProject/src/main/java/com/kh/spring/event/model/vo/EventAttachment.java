package com.kh.spring.event.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class EventAttachment {
    private Long fileNo;
    private Long  refBno;			// 참조 이벤트 번호
    private String originName;
    private String changeName;
    private String filePath;
    private int fileLevel;   		// 0: 썸네일, 1: 상세이미지
    private String status;
}
