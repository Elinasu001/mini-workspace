package com.kh.spring.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.board.model.service.BoardService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping(value="board", produces="application/json; charset=UTF-8")
@RequiredArgsConstructor
public class BoardAjaxController {
	
	private final BoardService boardService;
	
	@GetMapping("/likes")
	public String insertLikes(Long boardNo, HttpSession session) {
		
		int result = boardService.insertLikes(boardNo, session);
		
		return "";
	}
	
	@PostMapping("/replies")
	public String insertReply(@PathVariable(name="boardNo")Long boardNo, HttpSession session) {
		
		//boardService.insertReply(boardNo, session);
		
		return "";
	}
	
	
}
