package com.kh.spring.event.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.spring.event.model.dto.EventDTO;
import com.kh.spring.event.model.vo.EventAttachment;
import com.kh.spring.event.model.vo.EventCategory;

@Mapper
public interface EventMapper {
	
	
	// 이벤트 게시글 목록조회 (페이징 포함 - MyBatis 페이징 도구 offset 과 limit 내부적으로 계산)
	List<EventDTO> selectEventList(RowBounds rb); 
	
	// 진행중 이벤트 개수 조회
	int selectOngoingCount();
	
	// 진행중 이벤트 리스트 조회
	List<EventDTO> selectOngoing(RowBounds rb);
	
	// 진행중 이벤트 개수 조회
	int selectEndedCount();
	
	// 종료된 이벤트 리스트 조회 
	List<EventDTO> selectEnded(RowBounds rb);
	
	// 조회수 증가
	int increaseCount(Long eventNo); 
	
	// 이벤트 게시글 상세조회
	EventDTO selectByEventNo(Long eventNo);
	
	// 게시글 등록
	int insertEvent(EventDTO event);
	
	// 첨부파일 등록
	int insertAttachment(EventAttachment attach);
    
    // 카테고리 목록 조회 
    List<EventCategory> selectCategoryList();
    
    // 게시글 수정
    int updateEvent(EventDTO event);
    
    // 기존 첨부파일 조회 (썸네일/상세이미지 구분)
    EventAttachment selectAttachmentByLevel(Long  eventNo, int fileLevel);
    
    // 첨부파일 삭제 (STATUS = 'N' 처리)
    int deleteAttachment(Long fileNo);

	Long deleteEvent(Long eventNo);
    
	
    // 이벤트 첨부파일 전체 조회 (썸네일 + 상세이미지)
    //List<EventAttachmentDTO> saveAttachment(Long eventNo);
	
}
