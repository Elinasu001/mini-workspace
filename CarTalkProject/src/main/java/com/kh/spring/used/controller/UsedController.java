package com.kh.spring.used.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/used")
@RequiredArgsConstructor
public class UsedController {
	
	@GetMapping("/list")
	public String usedList() {
		log.info("요청확인");
		return "used/usedList";
	}
	
	@GetMapping("/insert")
	public String usedForm() {
		return "used/usedForm";
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
