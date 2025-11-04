package com.kh.spring.event.model.dto;

import java.sql.Date;
import java.util.List;

import com.kh.spring.event.model.vo.EventAttachment; 
import com.kh.spring.event.model.vo.EventCategory;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class EventDTO {
	
	private Long eventNo;
    private String eventTitle;
    private String eventContent;
    private Date startDate;
    private Date endDate;
    private int userNo;
    private int viewCount;
    private String status;
    private String userId;
    
    // 카테고리
    private EventCategory category = new EventCategory(); //  초기화
	// 첨부파일 리스트
    private List<EventAttachment> files;
	
    // 썸네일 / 상세
    private String thumbnailPath;
    private String thumbnailName;
    private String detailPath;
    private String detailName;

}
