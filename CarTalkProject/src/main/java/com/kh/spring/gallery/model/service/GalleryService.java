package com.kh.spring.gallery.model.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.gallery.model.dto.GalleryDTO;
import com.kh.spring.gallery.model.dto.ReplyDTO;

public interface GalleryService {

	Map<String, Object> selectGalleryList(Long page);
	
	GalleryDTO selectGalleryByNo(Long galleryNo);

	int insertGallery(GalleryDTO gallery, MultipartFile thumnail, List<MultipartFile> upfiles, HttpSession session);

	void updateGallery(GalleryDTO gallery, MultipartFile thumnail, List<MultipartFile> upfiles, HttpSession session);

	void deleteGallery(Long galleryNo);

	void insertReply(Long galleryNo, ReplyDTO reply, HttpSession session);

}
