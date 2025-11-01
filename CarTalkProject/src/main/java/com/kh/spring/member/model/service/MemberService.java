package com.kh.spring.member.model.service;

import com.kh.spring.member.model.dto.MemberDTO;

public interface MemberService {

	MemberDTO login(MemberDTO member) throws Exception;
}
