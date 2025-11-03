package com.kh.spring.gallery.model.service;

import java.util.Map;

import com.kh.spring.gallery.model.dto.GalleryDTO;

public interface GalleryService {

	Map<String, Object> selectGalleryList(Long page);
	
	GalleryDTO selectGalleryByNo(Long galleryNo);
}
