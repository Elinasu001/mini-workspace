package com.kh.spring.board.controller;
import java.util.HashMap;
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
	public String selectBoardList(@RequestParam(name="page", defaultValue = "1") Long pageNo,@RequestParam(name="category", defaultValue="0") Long category,@RequestParam(name="orderBy", defaultValue="ENROLL_DATE") String orderBy,Model model){
		
		Map<String, Object> searchBy = new HashMap();
		searchBy.put("orderBy", orderBy);
		searchBy.put("category", category);
		
		Map<String, Object> map = boardService.selectBoardList(pageNo,searchBy);
		model.addAttribute("map", map);
		model.addAttribute("category", category);
		model.addAttribute("orderBy", orderBy);
		
		return "board/board_list";
	}
	
	@GetMapping("/search")
	public String selectBoardListByKeyword(@RequestParam(name="page", defaultValue = "1") Long pageNo
										  ,@RequestParam(name="orderBy", defaultValue="ENROLL_DATE") String orderBy
										  ,@RequestParam(name="category", defaultValue="0") String category
										  ,@RequestParam(name="condition") String condition
										  ,@RequestParam(name="keyword") String keyword
										  ,Model model) {
		
		Map<String, Object> searchBy = new HashMap();
		
		searchBy.put("condition", condition);
		searchBy.put("keyword", keyword);
		searchBy.put("orderBy", orderBy);
		searchBy.put("category", category);
		
		Map<String, Object> map = boardService.selectBoardListByKeyword(pageNo, searchBy);
		
		model.addAttribute("map", map);
		model.addAttribute("category", category);
		model.addAttribute("keyword",keyword);
		model.addAttribute("condition",condition);
		model.addAttribute("orderBy", orderBy);
		
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
