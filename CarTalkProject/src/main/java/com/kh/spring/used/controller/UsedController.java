package com.kh.spring.used.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.used.model.dto.UsedListDTO;
import com.kh.spring.used.model.service.UsedService;
import com.kh.spring.util.Pagination;
import com.kh.spring.util.PageInfo;

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
						  ,Model model) {
		
		int listCount = usedService.selectListCount(keyword);
		PageInfo pi = pagination.getPageInfo(listCount, currentPage, 10, 10);
		
		List<UsedListDTO> usedList = usedService.selectUsedListAll(pi, keyword);
		
		model.addAttribute("pi", pi);
		model.addAttribute("usedList", usedList);
		model.addAttribute("keyword", keyword);
		
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
