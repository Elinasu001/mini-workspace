package com.kh.spring.member.model.service;

import javax.xml.validation.Validator;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.member.model.dto.MemberUpdateDTO;
import com.kh.spring.member.model.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private final MemberMapper mapper;
	private final PasswordEncoder encoder;
		
	
	@Override
	public MemberDTO login(MemberDTO member) throws Exception {
		System.out.println("서비스 호출" + member);
		MemberDTO loginMember = mapper.login(member);
		return loginMember;
	}
	
	@Override
	public int signUp(MemberDTO member) {
		int insertOk =0;
		System.out.println("암호화 전 pw " + member.getUserPwd());
		//String encPwd = encoder.encode(member.getUserPwd());
		System.out.println("암호와 pw " + encoder.encode(member.getUserPwd()));
		//member.setUserPwd(encPwd);
		insertOk = mapper.signup(member);
		
		return insertOk;
	}
	
	@Override
	public MemberDTO selectMyInfo(MemberDTO member) throws Exception {
		System.out.println("selectMyInfo call");
		System.out.println(">>>> ["+member.getUserId()+"]");
		MemberDTO out = mapper.selectMyInfo(member);
		System.out.println("result " + out);
		return out;
	}
	
	@Override
	public int memberUpdate(MemberDTO member) {
		return mapper.memberUpdate(member);
	}
	
	public MemberUpdateDTO selectMemberUpdate(MemberUpdateDTO mudto) {
		return mapper.selectMemberUpdate(mudto);
	}
	
	@Override
	public int insertMemberUpdate(MemberUpdateDTO mudto) {
		// TODO Auto-generated method stub
		return mapper.insertMemberUpdate(mudto);
	}
	
	@Override
	public int updateMemberUpdate(MemberUpdateDTO mudto) {
		// TODO Auto-generated method stub
		return mapper.updateMemberUpdate(mudto);
	}
	
	@Override
	public int deleteMember(MemberDTO mdto) {
		return mapper.deleteMemberInfo(mdto);
	}
	
	@Override
	public int deleteMemberUpdate(MemberUpdateDTO mudto) {
		return mapper.deleteMemberUpdateInfo(mudto);
	}
	
}
