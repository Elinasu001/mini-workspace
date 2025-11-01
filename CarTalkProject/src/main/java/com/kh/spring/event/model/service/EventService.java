package com.kh.spring.event.model.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.event.model.dto.EventDTO;

public interface EventService {

	// 이벤트 게시글 목록조회
	//Map<String, Object> selectEventList(Long page);
	
	// 진행중인 이벤트 _ AJAX
	Map<String, Object> selectOngoing(Long page);
	// 종료된 이벤트 _ AJAX
	Map<String, Object> selectEnded(Long page);
	
	// 이벤트 게시글 상세보기 (+ 조회수 증가)
	EventDTO selectByEventNo(Long eventNo);
	
	// 등록하기
    int insertEvent(EventDTO event, MultipartFile thumbnail, MultipartFile detailImage, HttpSession session);
}
