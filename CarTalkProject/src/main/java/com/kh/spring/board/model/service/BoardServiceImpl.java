package com.kh.spring.board.model.service;

import org.springframework.stereotype.Service;

import com.kh.spring.board.model.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

	private final BoardMapper boardMapper;
	
}
