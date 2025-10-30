package com.kh.spring.board.controller;

import org.springframework.stereotype.Controller;

import com.kh.spring.board.model.service.BoardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService boardService;
	
}
