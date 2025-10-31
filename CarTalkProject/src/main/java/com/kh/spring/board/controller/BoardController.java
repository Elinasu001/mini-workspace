package com.kh.spring.board.controller;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.board.model.dto.BoardDTO;
import com.kh.spring.board.model.service.BoardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("board")
public class BoardController {
	
	private final BoardService boardService;
	
	@GetMapping
	public String selectBoardList(@RequestParam(name="page", defaultValue = "1") Long pageNo,@RequestParam(name="searchBy", defaultValue="ENROLL_DATE") String searchBy,Model model){
		
		Map<String, Object> map = boardService.selectBoardList(pageNo,searchBy);
		model.addAttribute("map", map);
		
		return "board/board_list";
	}
	
	@GetMapping("/{boardNo}")
	public String selectByBoardNo(@PathVariable(name="boardNo") Long boardNo, Model model) {
		
		BoardDTO board = boardService.selectByBoardNo(boardNo);
		
		System.out.println(board);
		
		model.addAttribute("board",board);
		
		return "board/board_detail";
	}
	
}
