package com.cartalk.board.controller;

import org.springframework.stereotype.Controller;

import com.cartalk.board.model.service.BoardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService boardService;
	
}
