package com.kh.spring.event.model.service;

import java.util.Map;

public interface EventService {

	// 이벤트 게시글 목록조회
	Map<String, Object> selectEventList(Long eventNo);
	
}
