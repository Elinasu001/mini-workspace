package com.kh.spring.member.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.mybatis.spring.annotation.MapperScan;

import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.member.model.dto.MemberUpdateDTO;

@Mapper
@MapperScan
public interface MemberMapper {

	MemberDTO login(MemberDTO member);
	
	int signup(MemberDTO member);
	
	MemberDTO selectMyInfo(MemberDTO member);

	int memberUpdate(MemberDTO member);
	
	MemberUpdateDTO selectMemberUpdate(MemberUpdateDTO muDTO);
	
	int insertMemberUpdate(MemberUpdateDTO muDTO);
	
	int updateMemberUpdate(MemberUpdateDTO muDTO);
	
	int deleteMemberInfo(MemberDTO member);
	
	int deleteMemberUpdateInfo(MemberUpdateDTO muDTO);
}
