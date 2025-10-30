package com.kh.spring.member.model.service;

import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.member.model.vo.Member;

public interface MemberService {
	
	// 로그인
	Member login(MemberDTO member);
	
//	// 로그아웃
//	void logout();
//	
//	// 회원가입
//	void insertMember();
//	
//	// 마이페이지
//	void selectMemberInfo
//	
//	// 정보수정(비밀번호 변경)
//	void  updateMemberPwd();
//	
//	// 회원탈퇴
//	void deleteMember();

}

