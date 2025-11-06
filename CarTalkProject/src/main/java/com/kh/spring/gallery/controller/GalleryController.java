package com.kh.spring.gallery.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.gallery.model.dto.GalleryDTO;
import com.kh.spring.gallery.model.dto.ReplyDTO;
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
		
//		log.info("결과 : {}", map.values());
		
		return "gallery/list";
	}

	@GetMapping("/{id}")
	public String selectGalleryByNo(@PathVariable(name="id")Long galleryNo,
															Model model) {
		
		GalleryDTO gallery = galleryService.selectGalleryByNo(galleryNo);
		model.addAttribute("gallery", gallery);
//		log.info("{}", gallery);
		
		return "gallery/detail";
	}
	
	@GetMapping("/form")
	public String toGalleryForm() {
		return "gallery/form";
	}
	
	@PostMapping("/insert")
	public String insertGallery(GalleryDTO gallery, MultipartFile thumnail, List<MultipartFile> upfiles, HttpSession session) {
		log.info("gallery: {} / thumnail: {}", gallery, thumnail);
//		log.info("upfiles: {}", upfiles);
		
		galleryService.insertGallery(gallery, thumnail, upfiles, session);
		
		return "redirect:/gallery";
	}
	
	@GetMapping("/{id}/form")
	public String toGalleryUpdate(@PathVariable(name="id")Long galleryNo,
														  Model model) {
		
//		log.info("업데이트 들어감:");
		
		GalleryDTO gallery = galleryService.selectGalleryByNo(galleryNo);
		model.addAttribute("gallery", gallery);
		
		return "gallery/update";
	}
	
	@PostMapping("/{id}/update")
	public String updateGallery(@PathVariable(name="id") Long galleryNo, GalleryDTO gallery, 
	                            MultipartFile thumnail, List<MultipartFile> upfiles, HttpSession session) {
	    gallery.setGalleryNo(galleryNo);
	    log.info("업데이트 요청 galleryNo = {}", gallery.getGalleryNo());
	    galleryService.updateGallery(gallery, thumnail, upfiles, session);
	    return "redirect:/gallery";
	}

	
	@GetMapping("/{id}/delete")
	public String deleteGallery(@PathVariable(name="id")Long galleryNo) {
		
//		log.info("딜리트 들어감:");
		
		galleryService.deleteGallery(galleryNo);
		
		return "redirect:/gallery";
	}
	
	@PostMapping("/{id}/reply")
	public String insertReply(@PathVariable(name="id") Long galleryNo, ReplyDTO reply, HttpSession session) {
//		log.info("id:{}, reply:{}", galleryNo, reply);
		
		galleryService.insertReply(galleryNo, reply, session);
		
		return "redirect:/gallery/{id}";
	}
	
}
