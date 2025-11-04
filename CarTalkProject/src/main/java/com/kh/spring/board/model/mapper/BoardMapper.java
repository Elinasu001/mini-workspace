package com.kh.spring.board.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.spring.board.model.dto.AttachmentDTO;
import com.kh.spring.board.model.dto.BoardDTO;
import com.kh.spring.board.model.dto.LikeDTO;
import com.kh.spring.board.model.dto.ReplyDTO;

@Mapper
public interface BoardMapper {
	
	int selectBoardCount(Map<String, Object> searchBy);
	
	List<BoardDTO> selectBoardList(RowBounds rb, Map<String, Object> searchBy);

	int selectBoardCountByKeyword(Map<String, Object> searchBy);
	
	List<BoardDTO> selectBoardListByKeyword(RowBounds rb, Map<String, Object> searchBy);
	
	int increaseBoardCount(Long boardNo);
	
	BoardDTO selectByBoardNo(Long boardNo);
	
	int insertBoard(BoardDTO board);
	
	int updateBoard(BoardDTO board);
	
	int deleteBoard(BoardDTO board);

	int insertAttachment(AttachmentDTO attachment);
	
	int updateAttachment(AttachmentDTO attachment);
	
	int deleteAttachment(AttachmentDTO attachment);

	LikeDTO selectLikes(LikeDTO likeNums);
	
	int insertLikes(LikeDTO likeNums);

	int deleteLikes(LikeDTO likeNums);
	
	int insertReply(ReplyDTO reply);
	
	int updateReply(ReplyDTO reply);
	
	int deleteReply(ReplyDTO reply);

	List<Long> selectAllBoard();
}
