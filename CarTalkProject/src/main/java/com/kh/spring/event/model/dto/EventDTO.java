package com.kh.spring.event.model.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class EventDTO {
	
	private Long eventNo;         // 이벤트 번호 (PK)
	private int categoryNo;       // 카테고리 번호(FK, CT_EVENT_CATEGORY 참조)
	private String categoryName;  // 카테고리 이름 (1 : 시즌 이벤트 / 2 : 회원 이벤트 / 3: 리뷰 이벤트 / 4: 출석 이벤트
	private Date startDate;       // 이벤트 시작일
	private Date endDate;         // 이벤트 종료일
	private String filePath;	  // 파일 경로
    private String eventTitle;    // 이벤트 제목
    private String eventContent;  // 이벤트 내용
    private int viewCount;        // 조회수
    private String status;        // 게시글 상태 (Y: 게시, N: 삭제)
    private int userNo;           // 작성자 번호 (FK, CT_MEMBER 참조)
    private Date enrollDate;      // 등록일 (기본값: SYSDATE)
    
    /* 첨부파일 관련 필드 */
    private String originName;	  // 파일 원본명
    private String changeName;    // 저장 파일명 (경로 포함)
    
    /* 작성자 아이디만 표시용으로 사용 */
    private String userId;       // 작성자 아이디 (CT_MEMBER.USER_ID)
    
    /* 편의 필드 */
    private String shareUrl;       // 공유하기 링크 (프론트에서 조합)
    
}
