package com.kh.spring.event.model.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.event.model.dto.EventDTO;
import com.kh.spring.event.model.vo.EventCategory;

public interface EventService {
	
	// 메인 페이지 진행 중 이벤트 조회
	List<EventDTO> selectEventOngoingTop();
	
	
	// 진행중인 이벤트 게시글 조회
	Map<String, Object> selectOngoing(Long page);
	
	// 종료된 이벤트 게시글 조회
	Map<String, Object> selectEnded(Long page);
	
	// 이벤트 게시글 상세 조회
	EventDTO selectByEventNo(Long eventNo);
	
	// 이벤트 게시글 등록
    int insertEvent(EventDTO event, MultipartFile thumbnail, MultipartFile detailImage, HttpSession session);
    
    // 카테고리 목록 조회
    List<EventCategory> selectCategoryList();
    
    // 이벤트 게시글 수정
    int updateEvent(EventDTO event, MultipartFile thumbnail, MultipartFile detailImage, HttpSession session);
    
    // 이벤트 게시글 삭제
    Long deleteEvent(Long eventNo, HttpSession session);
    
}
