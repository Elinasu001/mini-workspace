package com.kh.spring.event.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.spring.event.model.dto.EventDTO;
import com.kh.spring.event.model.mapper.EventMapper;
import com.kh.spring.exception.InvalidArgumentsException;
import com.kh.spring.util.PageInfo;
import com.kh.spring.util.Pagination;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
class EventServiceImpl implements EventService {
	
	private final EventMapper eventMapper;
	private final Pagination pagination;
	/*
	@Override
	public Map<String, Object> selectEventList(Long page){
		
		Map<String, Object> map = new HashMap();
		List<EventDTO> events = new ArrayList();
		
		// 유효성검증
		if(page < 1) {
			throw new InvalidArgumentsException("잘못된 접근입니다.");
		}
		
		// 조회수
		int viewCount = eventMapper.selectEventCount();
		
		// 확인
		log.info("총 게시글 개수 : {}", viewCount);
		
		// 보여줄 게시글 수"와 "페이지 묶음 수"
		PageInfo pi = pagination.getPageInfo(viewCount, page.intValue(), 6, 6);
		
		// 게시글 있을 경우
		if(viewCount > 0) {
			RowBounds rb = new RowBounds((page.intValue() - 1) * 6, 6);
			events = eventMapper.selectEventList(rb);
		}
		
		map.put("pi", pi);
		map.put("events", events);
		
		return map;
		
	}
	*/
	
	// 진행중인 이벤트 _ AJAX
	@Override
	public Map<String, Object> selectOngoing(Long page) {
	    Map<String, Object> map = new HashMap<>();
	    List<EventDTO> events = new ArrayList<>();

	    if (page < 1) {
	        throw new InvalidArgumentsException("잘못된 접근입니다.");
	    }

	    int viewCount = eventMapper.selectOngoingCount(); // 진행중인 이벤트 개수
	    PageInfo pi = pagination.getPageInfo(viewCount, page.intValue(), 6, 6);

	    if (viewCount > 0) {
	        RowBounds rb = new RowBounds((page.intValue() - 1) * 6, 6);
	        events = eventMapper.selectOngoing(rb);
	    }
	   
	    map.put("pi", pi);
	    map.put("events", events);

	    return map;
	}
	
	// 종료된 이벤트 _ AJAX
	@Override
	public Map<String, Object> selectEnded(Long page) {
	    Map<String, Object> map = new HashMap<>();
	    List<EventDTO> events = new ArrayList<>();

	    if (page < 1) {
	        throw new InvalidArgumentsException("잘못된 접근입니다.");
	    }

	    int viewCount = eventMapper.selectEndedCount(); // 종료된 이벤트 개수
	    PageInfo pi = pagination.getPageInfo(viewCount, page.intValue(), 6, 6);

	    if (viewCount > 0) {
	        RowBounds rb = new RowBounds((page.intValue() - 1) * 6, 6);
	        events = eventMapper.selectEnded(rb);
	    }
	    log.info("종료된 게시글 개수: {}", viewCount);
	    map.put("pi", pi);
	    map.put("events", events);

	    return map;
	}

	
	
}
