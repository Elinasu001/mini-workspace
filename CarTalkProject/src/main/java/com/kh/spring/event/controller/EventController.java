package com.kh.spring.event.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	// 진행중인 이벤트 _ AJAX
	@GetMapping("/ongoing")
	public String selectOngoing(@RequestParam(name="page", defaultValue="1") Long page, Model model) {
		
		log.info("진행중인 게시글 앞에서 넘어온 페이지 값: {}", page);
		Map<String, Object> map = eventService.selectOngoing(page);
	    model.addAttribute("map", map);
	    log.info("진행중 이미지: {}", map);
	    return "event/listFragment";
	    
	}
	// 종료된 이벤트 _ AJAX
	@GetMapping("/ended")
	public String selectEnded(@RequestParam(name="page", defaultValue="1") Long page, Model model) {
		
		log.info("종료된 게시글 앞에서 넘어온 페이지 값: {}", page);
		Map<String, Object> map = eventService.selectEnded(page);
	    model.addAttribute("map", map);
	    log.info("종료된 이미지: {}", map);
	    return "event/listFragment";
	    
	}
	
	// 이벤트 게시글 상세보기
	@GetMapping("/{id}")
	public String selectByEnvetNo(@PathVariable(name="id") Long eventNo, Model model) {
		
		log.info("게시글 번호 : {}, 카테고리 : {}", eventNo);
		
		// 조회수 증가
		//EventDTO event = eventService.selectByEventNo(eventNo);
		//model.addAttribute("event", "event");
		
		//return "event/detail";
		return null;
		// 2025-10-31작업중
		
	}
	
}
