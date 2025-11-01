package com.kh.spring.board.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.spring.board.model.dto.BoardDTO;

@Mapper
public interface BoardMapper {
	
	int selectBoardCount(Map<String, Object> searchBy);
	
	List<BoardDTO> selectBoardList(RowBounds rb, Map<String, Object> searchBy);

	int selectBoardCountByKeyword(Map<String, Object> searchBy);
	
	List<BoardDTO> selectBoardListByKeyword(RowBounds rb, Map<String, Object> searchBy);
	
	int increaseBoardCount(Long boardNo);
	
	BoardDTO selectByBoardNo(Long boardNo);
	
	int insertReply();
	
	int updateReply();
	
	int deleteReply();
	
	int insertBoard();
	
	int updateBoard();
	
	int deleteBoard();
}
