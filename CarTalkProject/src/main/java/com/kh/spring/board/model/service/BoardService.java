package com.kh.spring.board.model.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.board.model.dto.BoardDTO;

public interface BoardService {
	
	Map<String, Object> selectBoardList(Long pageNo, Map<String, Object> searchBy);
	
	Map<String, Object> selectBoardListByKeyword(Long pageNo, Map<String, Object> searchBy);
	
	BoardDTO selectByBoardNo(Long boardNo);
	
	void insertBoard(BoardDTO board, MultipartFile boardUpfile, HttpSession session);
	
	void updateBoard(BoardDTO board, MultipartFile boardUpfile, HttpSession session);
	
	void deleteBoard(BoardDTO board, HttpSession session);
}
