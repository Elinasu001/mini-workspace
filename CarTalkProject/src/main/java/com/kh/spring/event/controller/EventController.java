package com.kh.spring.event.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.event.model.dto.EventDTO;
import com.kh.spring.event.model.service.EventService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("event")
@RequiredArgsConstructor
public class EventController {
	
	private final EventService eventService;
	
	// 이벤트 게시글 목록페이지
	@GetMapping("/list")
	public String selectEventPage() {
		return "event/list";
	}
	
	// 진행중인 이벤트 조회
	@GetMapping("/ongoing")
	public String selectOngoing(@RequestParam(name="page", defaultValue="1") Long page, Model model) {
		
		log.info("진행중인 게시글 앞에서 넘어온 페이지 값: {}", page);
		Map<String, Object> map = eventService.selectOngoing(page);
	    model.addAttribute("map", map);
	    log.info("진행중 이미지: {}", map);
	    return "event/listFragment";
	    
	}
	// 종료된 이벤트 조회
	@GetMapping("/ended")
	public String selectEnded(@RequestParam(name="page", defaultValue="1") Long page, Model model) {
		
		log.info("종료된 게시글 앞에서 넘어온 페이지 값: {}", page);
		Map<String, Object> map = eventService.selectEnded(page);
	    model.addAttribute("map", map);
	    log.info("종료된 이미지: {}", map);
	    return "event/listFragment";
	    
	}
	
	// 이벤트 게시글 상세보기
	@GetMapping("/detail/{eventNo}")
	public String selectByEventNo(@PathVariable("eventNo") Long eventNo, Model model) {
		
		log.info("게시글 번호 : {}", eventNo);
		EventDTO event = eventService.selectByEventNo(eventNo);
		model.addAttribute("event", event);
		return "event/detail";
		
	}
	
	// 이벤트 게시글 등록페이지
	@GetMapping("/insertForm")
	public String insertEventForm(HttpSession session){
		 /*테스트중*/
		if (session.getAttribute("loginMember") == null) {
			com.kh.spring.member.model.dto.MemberDTO dummyAdmin = new com.kh.spring.member.model.dto.MemberDTO();
	        dummyAdmin.setUserNo(1);
	        dummyAdmin.setUserId("admin");
	        dummyAdmin.setUserName("관리자");
	        dummyAdmin.setManager("Y"); // 관리자 여부
	        session.setAttribute("loginMember", dummyAdmin);
	    }
		return "event/insertForm";
	}
	
	
	// 이벤트 게시글 등록하기
	@PostMapping("/insert")
	public String insertEvent(
	        @ModelAttribute EventDTO event,
	        @RequestParam("thumbnail") MultipartFile thumbnail,
	        @RequestParam("detailImage") MultipartFile detailImage,
	        HttpSession session,
	        RedirectAttributes ra
	        ) {
		
		log.info("이벤트 등록 요청: {}", event);
        log.info("썸네일 파일명: {}", thumbnail.getOriginalFilename());
        log.info("상세이미지 파일명: {}", detailImage.getOriginalFilename());
	    
	    int result = eventService.insertEvent(event, thumbnail, detailImage, session);
	    
	    if (result > 0) {
	        ra.addFlashAttribute("alertMsg", "이벤트가 성공적으로 등록되었습니다.");
	        return "redirect:/event/list"; // 등록 후 목록으로 이동
	    } else {
	        ra.addFlashAttribute("errorMsg", "이벤트 등록 중 오류가 발생했습니다.");
	        return "redirect:/insertForm";
	    }
	}
	
	
}
