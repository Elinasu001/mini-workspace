package com.kh.spring.event.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.spring.event.model.dto.EventDTO;
import com.kh.spring.event.model.vo.EventAttachment;
import com.kh.spring.event.model.vo.EventCategory;

@Mapper
public interface EventMapper {
	
	//  메인 화면용 Top3 이벤트 조회
	List<EventDTO> selectEventOngoingTop();
	
	// RowBounds (페이징 포함 - MyBatis 페이징 도구 offset 과 limit 내부적으로 계산)
	
	// 진진행 이벤트 개수 (페이징용)
	int selectOngoingCount();
	
	// 진행 이벤트 목록 페이징 조회
	List<EventDTO> selectOngoing(RowBounds rb);
	
	// 종료 이벤트 개수 (페이징용)
	int selectEndedCount();
	
	// 종료 이벤트 목록 페이징 조회
	List<EventDTO> selectEnded(RowBounds rb);
	
	// 조회수 증가
	int increaseCount(Long eventNo); 
	
	// 상세조회 (이벤트 + 첨부파일 JOIN)
	EventDTO selectByEventNo(Long eventNo);
	
	// 이벤트 게시글 등록
	int insertEvent(EventDTO event);
	
	// 첨부파일 등록
	int insertAttachment(EventAttachment attach);
    
    // 카테고리 목록 조회 
    List<EventCategory> selectCategoryList();
    
    // 이벤트 게시글 수정
    int updateEvent(EventDTO event);
    
    // 단건 첨부파일 조회 (기존 파일 확인용)
    EventAttachment selectAttachmentByFileNo(Long fileNo);
    
    // 이벤트별 첨부파일 목록 조회 (파일 교체/삭제 로직용)
    List<EventAttachment> selectAttachmentsByEventNo(Long eventNo);
    
    // 파일 논리 삭제 (STATUS = 'N')
    int deleteAttachment(Long fileNo);
    
    // 이벤트 논리 삭제 (STATUS = 'N')
    int deleteEvent(Long eventNo);
	
}
