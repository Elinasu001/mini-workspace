package com.kh.spring.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MemberController {
    @Autowired
	MemberService ms; 
	@RequestMapping("/login")
	@ResponseBody 
	public Member getLogin(@RequestBody HashMap<String, String> map, HttpSession session) {
		System.out.println("login " + map);
		String userId = map.get("userId");
		String userPwd = map.get("userPwd");
		System.out.println(userId + " // "  + userPwd);
		MemberDTO mvto = new MemberDTO();
		mvto.setUserId(userId);
		mvto.setUserPwd(userPwd);
		Member member = ms.login(mvto);
		member.setNickName("테스트");
		System.out.println("로그인 " + member);
		if(member !=  null ) {
			session.setAttribute("loginInfo", member);
			return member;
		} 
		
		return member;
	}
	
	@RequestMapping("/loginPage")
	public String loginPage() {
		System.out.println("login page : ");
		return "login/login";
	}
}
