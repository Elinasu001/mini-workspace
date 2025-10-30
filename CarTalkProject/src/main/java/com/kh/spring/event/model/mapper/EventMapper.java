package com.kh.spring.event.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.spring.event.model.dto.EventDTO;

@Mapper
public interface EventMapper {
	
	// 페이징 처리용으로 게시글 전체 개수
	int selectEventCount();
	
	// 이벤트 게시글 목록조회 (페이징 포함 - MyBatis 페이징 도구 offset 과 limit 내부적으로 계산)
	List<EventDTO> selectEventList(RowBounds rowBouds); 
}
