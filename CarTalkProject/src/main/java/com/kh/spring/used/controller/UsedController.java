package com.kh.spring.used.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.used.model.dto.UsedDTO;
import com.kh.spring.used.model.dto.UsedListDTO;
import com.kh.spring.used.model.service.UsedService;
import com.kh.spring.util.PageInfo;
import com.kh.spring.util.Pagination;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/used")
@RequiredArgsConstructor
public class UsedController {
	
	@Autowired
	private UsedService usedService;
	
	@Autowired
	private Pagination pagination;
	
	
	
	@GetMapping("/list")
	public String usedList(@RequestParam(value="page", defaultValue="1") int currentPage
						  ,@RequestParam(value="keyword", required = false) String keyword	
						  ,Model model
						  ,HttpSession session) {
		
		int listCount = usedService.selectListCount(keyword);
		PageInfo pi = pagination.getPageInfo(listCount, currentPage, 10, 8);
		
		List<UsedListDTO> usedList = usedService.selectUsedListAll(pi, keyword);
		
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		model.addAttribute("loginMember", loginMember);
		
		
		model.addAttribute("pi", pi);
		model.addAttribute("usedList", usedList);
		model.addAttribute("keyword", keyword);
		
		//System.out.println(pi);
		
		return "used/usedList";
	}
	
	@GetMapping("/insert")
	public String insertForm() {
	    return "used/usedForm";
	}
	
	@PostMapping("/insert")
	public String usedForm(@ModelAttribute UsedDTO used
						  ,@RequestParam(value = "upfile", required = false) List<MultipartFile> files
						  , HttpSession session
						  , RedirectAttributes redirectAttr) {
		
		
		// 로그인이 안됐을 경우 글쓰기 기능 막음 (로그인 구현되면 활성화)
		/*
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if( loginMember == null) {
			return "redirect:/ct/login";
		}
		*/
		used.setUserNo(1L); // 테스트용
		
		//used.setUserNo(loginMember.getUserNo());
		
		Long usedNo = usedService.insertUsed(used, files, session);
		
		if(usedNo != null) {
			redirectAttr.addFlashAttribute("message", "게시글 작성 완료!");
			return "redirect:/used/detail/" + usedNo;
		} else {
			redirectAttr.addFlashAttribute("message", "등록에 실패하였습니다. 다시 등록해주세요!");
			return "redirect:/used/insert";
		}
	}
	
	@PostMapping("/list")
	public String usedFileSave() {
		
		return "redirect:list";
	}
	
	@GetMapping("/detail")
	public String usedDetail() {
		return "used/usedDetail";
	}
	
	@GetMapping("/myList")
	public String myUsetList() {
		return "used/myUsedList";
	}

}
