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
	
	// 메인 페이지 진행 중 이벤트 조회
	List<EventDTO> selectEventOngoingTop();
	
	// RowBounds (페이징 포함 - MyBatis 페이징 도구 offset 과 limit 내부적으로 계산)
	
	// 진행중 이벤트 개수 조회
	int selectOngoingCount();
	
	// 진행중 이벤트 리스트 조회
	List<EventDTO> selectOngoing(RowBounds rb);
	
	// 종료된 이벤트 개수 조회
	int selectEndedCount();
	
	// 종료된 이벤트 리스트 조회 
	List<EventDTO> selectEnded(RowBounds rb);
	
	// 조회수 증가
	int increaseCount(Long eventNo); 
	
	// 이벤트 게시글 상세 조회
	EventDTO selectByEventNo(Long eventNo);
	
	// 이벤트 게시글 등록
	int insertEvent(EventDTO event);
	
	// 첨부파일 등록
	int insertAttachment(EventAttachment attach);
    
    // 카테고리 목록 조회 
    List<EventCategory> selectCategoryList();
    
    // 이벤트 게시글 수정
    int updateEvent(EventDTO event);
    
    // 특정 첨부파일 조회 (0 == 썸네일/1 == 상세이미지 구분)
    EventAttachment selectAttachmentByFileNo(Long fileNo);
    
    // 이벤트 번호로 전체 첨부파일 조회
    List<EventAttachment> selectAttachmentsByEventNo(Long eventNo);
    
    // 단건 첨부파일 삭제 (STATUS = 'N' 처리)
    int deleteAttachment(Long fileNo);
    
    // 이벤트 게시글 삭제 (STATUS = 'N' 처리)
    int deleteEvent(Long eventNo);
	
}
