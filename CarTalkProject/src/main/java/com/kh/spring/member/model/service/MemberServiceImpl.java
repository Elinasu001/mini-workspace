package com.kh.spring.member.model.service;

import org.springframework.stereotype.Service;

import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	@Override
	public Member login(MemberDTO member) {
		Member vo = new Member();
		vo.setUserId("admin");
		vo.setNickName("테스트");
		vo.setUserName("관리자");
		return vo;
	}
}
