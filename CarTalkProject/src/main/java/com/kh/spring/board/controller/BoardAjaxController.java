package com.kh.spring.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.board.model.dto.BoardDTO;
import com.kh.spring.board.model.dto.ReplyDTO;
import com.kh.spring.board.model.service.BoardService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping(value="board", produces="html/text; charset=UTF-8")
@RequiredArgsConstructor
public class BoardAjaxController {
	
	private final BoardService boardService;
	
	@GetMapping("/like")
	public String insertLikes(@RequestParam Long boardNo, HttpSession session) {
		
		String result = boardService.insertLikes(boardNo, session);
		
		
		
		return result;
	}
	
	@PostMapping("/replies")
	public String insertReply(ReplyDTO reply,HttpSession session) {
		
		String result = boardService.insertReply(reply, session);
		
		return result;
	}
	
	@GetMapping(value = "/{boardNo}/refresh", produces = "application/json; charset=UTF-8")
	public BoardDTO selectBoardByBoardNo(@PathVariable(name="boardNo")Long boardNo) {
		
		System.out.println(boardService.selectByBoardNo(boardNo));
		
		return boardService.selectByBoardNo(boardNo);
		
	}
	
	@PostMapping("/updateReply")
	public String updateReply(ReplyDTO reply, HttpSession session) {
		
		String result = boardService.updateReply(reply, session);
		
		return result;
	}
	
}
