package com.kh.spring.event.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.event.model.service.EventService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("event")
@RequiredArgsConstructor
public class EventController {
	
	private final EventService eventService;
	
	// 이벤트 게시글 목록조회
	@GetMapping("/list")
	public String selectEventList(@RequestParam(name="page", defaultValue="1") Long page, Model model) {
		
		log.info("앞에서 넘어온 페이지 값: {}", page);
		
		// 이벤트 목록(events) : 현재 페이지에 표시할 이벤트 게시글 리스트(List<EventDTO>) + 페이지 정보(pi) : 전체 게시글 수, 현재 페이지, 마지막 페이지 (PageInfo) + 
		Map<String, Object> map = eventService.selectEventList(page);
		
		model.addAttribute("map", map);
		
		
		log.info("이미지: {}", map);
		
		return "event/list";
	}
	
}
