package com.cartalk.board.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cartalk.board.model.dto.BoardDTO;

@Mapper
public interface BoardMapper {
	
	int boardListCount();
	
	List<BoardDTO> selectBoardList();
	
	List<BoardDTO> selectBoardListByKeyword();
	
	BoardDTO selectByBoardNo();
	
	int insertReply();
	
	int updateReply();
	
	int deleteReply();
	
	int insertBoard();
	
	int updateBoard();
	
	int deleteBoard();
}
