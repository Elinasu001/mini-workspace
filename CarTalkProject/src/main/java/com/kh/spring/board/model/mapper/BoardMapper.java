package com.kh.spring.board.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.spring.board.model.dto.BoardDTO;

@Mapper
public interface BoardMapper {
	
	int selectBoardCount();
	
	List<BoardDTO> selectBoardList(RowBounds rb);
	
	List<BoardDTO> selectBoardListByKeyword(BoardDTO board);
	
	int increaseBoardCount(Long boardNo);
	
	BoardDTO selectByBoardNo(Long boardNo);
	
	int insertReply();
	
	int updateReply();
	
	int deleteReply();
	
	int insertBoard();
	
	int updateBoard();
	
	int deleteBoard();
}
