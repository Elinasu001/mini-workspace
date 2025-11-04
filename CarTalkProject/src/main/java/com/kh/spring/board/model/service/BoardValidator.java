package com.kh.spring.board.model.service;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

import com.kh.spring.board.model.dto.ReplyDTO;
import com.kh.spring.exception.InvalidArgumentsException;
import com.kh.spring.member.model.dto.MemberDTO;

@Component
public class BoardValidator {


	public void validateSelectBoard(Long num) {
		checkBoardParam(num);
	}
	
	private void checkBoardParam(Long num) {
		if(num < 1) {
			throw new InvalidArgumentsException("유효하지 않은 접근입니다.");
		}
	}
	
	private void checkBoardNull() {
		
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
	
	private void checkMemberDuplicate(String userNo ,HttpSession session) {
		
	}
	
	public void validateReply(ReplyDTO reply) {
		checkReplyNull(reply.getReplyContent());
	}
	
	public MemberDTO validateLogin(HttpSession session) {
		
		MemberDTO member = ((MemberDTO)session.getAttribute("loginMember"));
		
		checkUserNull(member);// 로그인하지 않은 사용자가 댓글 입력을 시도 할 경우
		
		return member;
	}
	
}
