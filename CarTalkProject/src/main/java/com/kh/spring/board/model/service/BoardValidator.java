package com.kh.spring.board.model.service;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

import com.kh.spring.board.model.dto.BoardDTO;
import com.kh.spring.board.model.dto.ReplyDTO;
import com.kh.spring.board.model.mapper.BoardMapper;
import com.kh.spring.exception.AuthenticationException;
import com.kh.spring.exception.InvalidArgumentsException;
import com.kh.spring.exception.PageNotFoundException;
import com.kh.spring.member.model.dto.MemberDTO;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class BoardValidator {

	private final BoardMapper boardMapper;
	
	public void validateSelectBoard(Long boardNo) {
		checkBoardParam(boardNo);
	}
	
	private void checkBoardParam(Long num) {
		if(num < 1) {
			throw new InvalidArgumentsException("유효하지 않은 접근입니다.");
		}
	}
	
	private void checkBoardNull(BoardDTO board) {
		if(board == null) {
			throw new PageNotFoundException("페이지를 찾을 수 없습니다.");
		}
	}
	
	private void checkReplyNull(String replyContent) {
		
		if(replyContent == null && "".equals(replyContent.trim())){
			throw new NullPointerException("값이 존재하지 않습니다.");
		}
		
	}
	
	private void checkUserNull(MemberDTO member) {
		if(member == null) {
			throw new NullPointerException("로그인 한 상태가 아닙니다.");
		}
	}
	
	private void checkAuthorization(String boardWriter, String loginMember) {
		if(!boardWriter.equals(loginMember)) {
			throw new AuthenticationException("사용자 정보가 불일치합니다.");
		}
	}
	
	public void validateReply(ReplyDTO reply) {
		checkReplyNull(reply.getReplyContent());
	}
	
	public MemberDTO validateLogin(HttpSession session) {
		
		MemberDTO member = ((MemberDTO)session.getAttribute("loginMember"));
		
		checkUserNull(member);// 로그인하지 않은 사용자가 댓글 입력을 시도 할 경우
		
		return member;
	}
	
	public void validateAuthorization(String boardWriter, MemberDTO loginMember) {
		
		checkUserNull(loginMember);
		checkAuthorization(boardWriter, loginMember.getNickName());
		
	}

	public void validateBoard(BoardDTO board) {
		checkBoardNull(board);
	}
	
	
}
