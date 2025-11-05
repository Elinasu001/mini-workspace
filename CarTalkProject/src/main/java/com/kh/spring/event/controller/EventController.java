package com.kh.spring.event.controller;

import java.util.List;
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
import com.kh.spring.event.model.vo.EventCategory;

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
	public String selectEventPage(HttpSession session) {
		return "event/list";
	}
	
	// 진행중인 이벤트 조회_Ajax 
	@GetMapping("/ongoing")
	public String selectOngoing(@RequestParam(name="page", defaultValue="1") Long page, Model model) {
		Map<String, Object> map = eventService.selectOngoing(page);
	    model.addAttribute("map", map);
	    return "event/listFragment";
	    
	}
	// 종료된 이벤트 조회_Ajax 
	@GetMapping("/ended")
	public String selectEnded(@RequestParam(name="page", defaultValue="1") Long page, Model model) {
		Map<String, Object> map = eventService.selectEnded(page);
	    model.addAttribute("map", map);
	    return "event/listFragment";
	    
	}
	
	// 이벤트 게시글 상세
	@GetMapping("/detail/{eventNo}")
	public String selectByEventNo(@PathVariable("eventNo") Long eventNo, Model model) {
		EventDTO event = eventService.selectByEventNo(eventNo);
		model.addAttribute("event", event);
		return "event/detail";
	}
	
	// 이벤트 게시글 등록페이지
	@GetMapping("/insertForm")
	public String insertEventForm(HttpSession session, Model model){
	    List<EventCategory> categoryList = eventService.selectCategoryList();
	    model.addAttribute("categoryList", categoryList);
	    return "event/insertForm";
	}
	
	
	// 이벤트 게시글 등록
	@PostMapping("/insert")
	public String insertEvent(
	        @ModelAttribute EventDTO event,
	        @RequestParam("thumbnail") MultipartFile thumbnail,
	        @RequestParam("detailImage") MultipartFile detailImage,
	        HttpSession session,
	        RedirectAttributes ra
	        ) {
	    
	    eventService.insertEvent(event, thumbnail, detailImage, session);
	    ra.addFlashAttribute("alertMsg", "이벤트가 성공적으로 등록되었습니다.");
	    return "redirect:/event/list";
	}
	
	// 이벤트 게시글 수정페이지
	@GetMapping("/updateForm")
	public String updateEventForm(@RequestParam("eventNo") Long eventNo, Model model) {
	    EventDTO event = eventService.selectByEventNo(eventNo);// 기존 이벤트 상세 정보 조회
	    List<EventCategory> categoryList = eventService.selectCategoryList();// 카테고리 목록 조회
	    model.addAttribute("event", event);
	    model.addAttribute("categoryList", categoryList);
	    return "event/updateForm";
	}
	
	// 이벤트 게시글 수정
	@PostMapping("/update")
	public String updateEvent(
			@ModelAttribute EventDTO event,
	        @RequestParam(value = "thumbnail", required = false) MultipartFile thumbnail,
	        @RequestParam(value = "detailImage", required = false) MultipartFile detailImage,
	        HttpSession session,
	        RedirectAttributes ra) {

		eventService.updateEvent(event, thumbnail, detailImage, session);
	    ra.addFlashAttribute("alertMsg", "이벤트가 성공적으로 수정되었습니다.");
	    return "redirect:/event/detail/" + event.getEventNo();
	}
	
	// 이벤트 게시글 삭제
	@GetMapping("/delete")
    public String deleteEvent(
    		@RequestParam("eventNo") Long eventNo,
    		HttpSession session,
    		RedirectAttributes ra) {
       eventService.deleteEvent(eventNo, session);
       ra.addFlashAttribute("alertMsg", "이벤트가 성공적으로 삭제되었습니다.");
       return "redirect:/event/list";
    }
	
	
}
