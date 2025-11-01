package com.kh.spring.member.model.service;

import org.springframework.stereotype.Service;

import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.member.model.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private final MemberMapper mapper;
		
	
	@Override
	public MemberDTO login(MemberDTO member) throws Exception {
		System.out.println("서비스 호출" + member);
		MemberDTO loginMember = mapper.login(member);
		
		return loginMember;
	}
	
}
