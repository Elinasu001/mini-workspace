package com.kh.spring.member.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.spring.member.model.dto.MemberDTO;

@Mapper
public interface MemberMapper {

//	@Select("""
//			SELECT USER_NO userNo, USER_ID userId, USER_PWD userPwd, USER_NAME userName, NICKNAME nickname,
//			EMAIL email, ENROLL_DATE enrollDate, MANAGER manager FROM CT_MEMBER WHERE USER_ID = #{userId}")
//			""")
	MemberDTO login(MemberDTO member);
		
}
