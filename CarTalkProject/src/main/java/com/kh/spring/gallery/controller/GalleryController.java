package com.kh.spring.gallery.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.gallery.model.service.GalleryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("gallery")
@RequiredArgsConstructor
public class GalleryController {

	private final GalleryService galleryService;
	
	@GetMapping("")
	public String selectGalleryList(@RequestParam(name="page",defaultValue = "1") Long page, Model model) {
		
//		log.info("현재 페이지: {}",page);
		
		Map<String, Object> map = galleryService.selectGalleryList(page);
		model.addAttribute("map", map);
		
		return "gallery/list";
	}
	
	@GetMapping("/{id}")
	public String selectGalleryByNo(@PathVariable(name="id")Long galleryNo,
															Model model) {
		return "gallery/detail";
	}
}
