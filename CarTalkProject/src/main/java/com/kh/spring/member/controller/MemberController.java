package com.kh.spring.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.member.model.dto.MemberUpdateDTO;
import com.kh.spring.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	
	private final Gson gson = new GsonBuilder().setPrettyPrinting().create();
	@Autowired
	private MemberService memberService;
	
	
	// 로그인
	@RequestMapping("/login")
	@ResponseBody
	public String login(@RequestBody HashMap<String, String> map, HttpSession session) throws Exception {
		 System.out.println("login : ");
		// log.info("member {}", member);
		String resultStr = "";
		
		System.out.println("jsp input 값 : " + map);
		MemberDTO member = new MemberDTO();
		member.setUserId(map.get("userId"));
		member.setUserPwd(map.get("userPwd"));
		MemberDTO loginMember = memberService.login(member);
		 System.out.println("로그인" + loginMember);
		if(loginMember != null) {
			if(loginMember.getUserName() != null 
				&& !"".equals(loginMember.getUserName())) {
				resultStr = gson.toJson(loginMember);
				session.setAttribute("loginMember", loginMember);
				resultStr = gson.toJson("1");
			} else {
				resultStr = gson.toJson("2");
			}
			
		} else {
			resultStr = gson.toJson("3");
		}
		System.out.println(resultStr);
		return resultStr; 
	}
	
	@RequestMapping("/loginPage")
	public String loginPage() {
		// System.out.println("loginPage : ");
		return "login/login";
	}
	
	// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		// System.out.println("logout : ");
		session.removeAttribute("loginMember");
		return "redirect:/";
	}
	
	// 회원가입
	@RequestMapping("/join")
	public ModelAndView joinForm() {
		System.out.println("joinForm call ");
		// 포워딩할 JSP파일의 논리적인 경로
		// /WEB-INF/views/member/signup.jsp
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageFlag", "join");
		mav.setViewName("login/signup");
		return mav;
	}
	
	@RequestMapping("/joinUp")
	@ResponseBody
	public String joinUp(@RequestBody HashMap<String, String> map, HttpSession session) throws Exception {
		System.out.println("joinUp call ");
		System.out.println("joinUp input --> " +map);
		MemberDTO inDTO = new MemberDTO();
		//{userPwd=12, nickname=fdssd, userName=21, userId=12, email=sadfasdfada}
		inDTO.setUserId(map.get("userId"));
		inDTO.setUserPwd(map.get("userPwd"));
		inDTO.setNickName(map.get("nickname"));
		inDTO.setUserName(map.get("userName"));
		inDTO.setEmail(map.get("email"));
		int insertCnt = memberService.signUp(inDTO);
		return insertCnt+"";
	}
	
	// 마이페이지
	@RequestMapping("/mypageForm")
	public ModelAndView mypageForm(HttpSession session)throws Exception{
		ModelAndView mav = new ModelAndView();
		System.out.println("mypageForm call ");
		// 포워딩할 JSP파일의 논리적인 경로
		// /WEB-INF/views/member/signup.jsp
		MemberDTO in = (MemberDTO) session.getAttribute("loginMember");
		if(in != null ) {
			MemberDTO myUserInf =  memberService.selectMyInfo(in);
			mav.addObject("Member", myUserInf);
			mav.setViewName("login/myPage");
		} else {
			mav.setViewName("main");
		}
		return mav;
	}
	
	// 정보수정
	@RequestMapping("/updateInfo")
	@ResponseBody
	public String updateForm(@RequestBody HashMap<String, String> map, HttpSession session) throws Exception {
		System.out.println("updateInfo call " + map) ;
		int resultCnt = 0;
		String str= "";
		MemberDTO inDTO = new MemberDTO();
		inDTO.setUserId(map.get("userId"));
		inDTO.setUserPwd(map.get("userPwd"));
		System.out.println(" select Input : " +inDTO);
		MemberDTO myUserInf =  memberService.selectMyInfo(inDTO);
		System.out.println("member : " +myUserInf);
		if (myUserInf != null ) {
			MemberUpdateDTO changeVO =  new MemberUpdateDTO();
			changeVO.setChangePwd(myUserInf.getUserPwd());
			changeVO.setUserNo(myUserInf.getUserNo());
			
			myUserInf.setUserPwd(map.get("changePwd"));
			System.out.println(" myUserInf : " +myUserInf);
			int memberCnt = memberService.memberUpdate(myUserInf);
			System.out.println(" memberCnt : [" +memberCnt);
			if (memberCnt > 0) {
				System.out.println(" selectMemberUpdate : [" +changeVO);
				MemberUpdateDTO outInf = memberService.selectMemberUpdate(changeVO);
				System.out.println(" outInf [" +outInf);
				if(outInf != null && !"".equals(outInf.getChangePwd()) ) {
					//등록
					changeVO.setUserNo(outInf.getUserNo());
					changeVO.setChangePwd(inDTO.getUserPwd());
					changeVO.setUpdateNo(outInf.getUpdateNo());
					resultCnt = memberService.updateMemberUpdate(changeVO);
					session.removeAttribute("loginMember");
				} else {
					System.out.println(" insert [" +outInf);
					changeVO.setUserNo(myUserInf.getUserNo());
					changeVO.setChangePwd(inDTO.getUserPwd());
					System.out.println(" insert input [" +changeVO);
					resultCnt = memberService.insertMemberUpdate(changeVO);
					session.removeAttribute("loginMember");
				}
			}
			str= "1";
		} else {
			str= "0";
		}
		
		return str;
	}
	
	// 정보수정
	@RequestMapping("/deletInfo")
	@ResponseBody
	public String deletInfo(@RequestBody HashMap<String, String> map, HttpSession session) throws Exception {
		String str= "";
		System.out.println("deletInfo call");
		int userNo = Integer.parseInt(map.get("userNo"));
		MemberDTO inDTO = new MemberDTO();
		inDTO.setUserId(map.get("userId"));
		inDTO.setUserNo(userNo);
		
		int deleteCnt = 0;
		MemberUpdateDTO changeVO =  new MemberUpdateDTO();
		changeVO.setUserNo(userNo);
		MemberUpdateDTO outInf = memberService.selectMemberUpdate(changeVO);
		System.out.println("MemberUpdate 존재 : " + outInf);
		if(outInf != null && !"".equals(outInf.getChangePwd())) {
			deleteCnt = memberService.deleteMemberUpdate(outInf);
			if( deleteCnt > 0 ) {
				deleteCnt = memberService.deleteMember(inDTO);
				if(deleteCnt > 0 ) {
					session.removeAttribute("loginMember");
					str = "1";
				}
			} 
		} else {
			deleteCnt = memberService.deleteMember(inDTO);
			if(deleteCnt > 0 ) {
				session.removeAttribute("loginMember");
				str = "1";
			}
		}
		
		return str;
	}
	
}
