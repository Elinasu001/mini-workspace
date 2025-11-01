package com.kh.spring.board.model.service;

import java.util.Map;

public interface BoardService {
	
	Map<String, Object> selectBoardList(Long pageNo);
	
}
