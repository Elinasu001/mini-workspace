package com.kh.spring.member.model.service;

import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.member.model.dto.MemberUpdateDTO;

public interface MemberService {

	MemberDTO login(MemberDTO member) throws Exception;
	
	int signUp(MemberDTO member);
	
	MemberDTO selectMyInfo(MemberDTO member) throws Exception;
	
	int memberUpdate(MemberDTO member);
	
	MemberUpdateDTO selectMemberUpdate(MemberUpdateDTO mudto);
	
	int insertMemberUpdate(MemberUpdateDTO mudto);
		
	int updateMemberUpdate(MemberUpdateDTO mudto);
	
	int deleteMemberUpdate(MemberUpdateDTO mudto);
	
	int deleteMember(MemberDTO mdto);
}
