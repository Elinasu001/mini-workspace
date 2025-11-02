package com.kh.spring.event.model.dto;

import java.sql.Date;

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
    private int categoryNo;
    private String categoryName;
    private String eventTitle;
    private String eventContent;
    private Date startDate;
    private Date endDate;
    private int userNo;
    private int viewCount;
    private String status;
    private String userId;
    
    private EventCategory category;  // categoryNo, categoryName은 이 객체 안에 포함
    
    /* 썸네일용 */
    private String filePath;        // 썸네일 경로
    private String changeName;      // 썸네일 저장명
    private String originName;      // 썸네일 원본명

    /* 상세이미지용 */
    private String detailPath;         // 상세 경로
    private String detailChangeName;   // 상세 저장명
    private String detailOriginName;   // 상세 원본명

    private String shareUrl;
}
