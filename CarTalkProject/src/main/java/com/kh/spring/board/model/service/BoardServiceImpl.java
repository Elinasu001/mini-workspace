package com.kh.spring.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;


import com.kh.spring.board.model.dto.BoardDTO;
import com.kh.spring.board.model.mapper.BoardMapper;
import com.kh.spring.util.PageInfo;
import com.kh.spring.util.Pagination;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

	private final BoardMapper boardMapper;
	private final Pagination pagination;

	/**
	 * 페이지 번호를 인자값으로 전달받아서 
	 * 화면에 표시할 List<Board>와 
	 * 페이지 정보가 담긴 PageInfo를 Map에 담아서 반환하는 메서드
	 */
	@Override
	public Map<String, Object> selectBoardList(Long pageNo, String searchBy) {
		Map<String, Object> map = new HashMap();
		List<BoardDTO> boards = new ArrayList();
		
		// 페이지 번호가 1보다 낮은 경우 예외 발생
		if(pageNo < 1) {
			
		}
		int count = boardMapper.selectBoardCount();
		// 게시글이 존재하지 않을 경우 수행하지 않음
		if(count > 0) {
			//페이징 처리용 클래스
			RowBounds rb = new RowBounds((pageNo.intValue() -1)*10, 10);
			boards = boardMapper.selectBoardList(searchBy ,rb);
		}
		
		PageInfo pi = pagination.getPageInfo(count, pageNo.intValue(), 10, 10);
		
		map.put("boards", boards);
		map.put("pi", pi);
		
		return map;
	}

	@Override
	public BoardDTO selectByBoardNo(Long boardNo) {
		
		// 보드 번호가 1보다 낮은 경우 예외 발생
		if(boardNo < 1) {
			
		}
		
		int count = boardMapper.increaseBoardCount(boardNo);
		System.out.println(count);
		
		// 조회수가 늘어나지 않는 경우 예외 발생
		if(count != 1) {
			
		}
		
		BoardDTO board = boardMapper.selectByBoardNo(boardNo);
		
		// 조회된 값이 없는 경우 예외 발생
		if(board == null) {
			
		}
		
		return board;
		
	}
	
}
