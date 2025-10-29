package com.kh.spring.board.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.board.model.service.BoardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("board")
public class BoardController {
	
	private final BoardService boardService;
	
	@GetMapping
	public String selectBoardList(@RequestParam(name="page", defaultValue = "1") Long pageNo, Model model){
		
		Map<String, Object> map = boardService.selectBoardList(pageNo);
		model.addAttribute("map", map);
		
		return "board/board_list";
	}
	
}
