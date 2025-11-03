package com.kh.spring.board.model.service;

import java.util.Map;

import com.kh.spring.board.model.dto.BoardDTO;

public interface BoardService {
	
	Map<String, Object> selectBoardList(Long pageNo, Map<String, Object> searchBy);
	
	Map<String, Object> selectBoardListByKeyword(Long pageNo, Map<String, Object> searchBy);
	
	BoardDTO selectByBoardNo(Long boardNo);
}
