package com.kh.spring.board.model.service;

import java.util.Map;

public interface BoardService {

	int selectBoardCount();
	
	Map<String, Object> selectBoardList(Long pageNo);
	
}
