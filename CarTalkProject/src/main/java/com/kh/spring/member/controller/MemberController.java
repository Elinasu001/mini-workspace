package com.kh.spring.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	
	private MemberService memberService;
	
	@Autowired
	public MemberController(MemberService memberService) {
		this.memberService = memberService;
		
	}
	
//	@GetMapping("/login")
//	public ModelAndView login(MemberDTO member, HttpSession session, ModelAndView mv) {
//		
//		MemberDTO loginMember = memberService.login(member);
//		
//		if(loginMember != null) {
//			session.setAttribute("loginMember", loginMember);
//			mv.setViewName("redirect:/");
//	} 
//		return "login";
	
	@RequestMapping("/login")
	@ResponseBody
	public MemberDTO login(@RequestBody HashMap<String, String> map, HttpSession session) throws Exception {
		// System.out.println("login : ");
		// log.info("member {}", member);
		// System.out.println("jsp input 값 : " + map);
		MemberDTO member = new MemberDTO();
		member.setUserId(map.get("userId"));
		member.setUserPwd(map.get("userPwd"));
		MemberDTO loginMember = memberService.login(member);
		// System.out.println("로그인" + loginMember);
		if(loginMember != null) {
			session.setAttribute("loginMember", loginMember);
		} 
		JsonObject data = new JsonObject();
		data.keySet(); 
//		System.out.println("보내기 : " + data);
//		System.out.println("보내기 : " + data.toString());
		return loginMember; 
	}
	
	@RequestMapping("/loginPage")
	public String loginPage() {
		// System.out.println("loginPage : ");
		return "login/login";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		// System.out.println("logout : ");
		session.removeAttribute("loginMember");
		return "redirect:/";
	}
}
