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


/**
 * 이벤트 게시판 DTO
 * - DB Event 테이블 + 관련 연관 데이터(Category, Attachment)
 * - Controller <-> Service <-> Mapper 데이터 전달용
 */

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class EventDTO {
	
 	/** 이벤트 기본 정보 **/
	private Long eventNo;           // 이벤트 번호 (PK)
    private String eventTitle;      // 제목
    private String eventContent;    // 내용
    private Date startDate;         // 시작일
    private Date endDate;           // 종료일
    private int userNo;             // 작성자 회원번호
    private int viewCount;          // 조회수
    private String status;          // 상태 (Y:진행, N:삭제)
    private String userId;          // 작성자 아이디 (조인 결과)

    /** 카테고리 정보 (조인 데이터) **/
    private EventCategory category = new EventCategory(); 
    // Category 테이블 VO 포함 (카테고리명 등 사용)

    /** 첨부 파일 목록 (0: 썸네일, 1: 상세 이미지) **/
    private List<EventAttachment> files;

    /** 화면 표시용 - 파일 경로/이름 분리 저장 */
    private String thumbnailPath;   // 썸네일 경로
    private String thumbnailName;   // 썸네일 파일명
    private String detailPath;      // 상세 이미지 경로
    private String detailName;      // 상세 이미지 파일명
}
