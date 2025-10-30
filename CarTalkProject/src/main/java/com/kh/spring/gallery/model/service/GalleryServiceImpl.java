package com.kh.spring.gallery.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.spring.gallery.model.dto.GalleryDTO;
import com.kh.spring.gallery.model.mapper.GalleryMapper;
import com.kh.spring.util.PageInfo;
import com.kh.spring.util.Pagination;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class GalleryServiceImpl implements GalleryService {
	
	private final GalleryMapper galleryMapper;
	private final Pagination pagination;
	
	@Override
	public Map<String, Object> selectGalleryList(Long page) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<GalleryDTO> gallerys = new ArrayList();
		
		//TODO: 유효성검증- 요청 페이지수가 -1 등 유효하지 않을경우 
		if(page < 1) {}
		
		int count = galleryMapper.selectTotalcount();
//		log.info("{}", count);
		PageInfo pi = pagination.getPageInfo(count, page.intValue(), 5, 4);
//		log.info("{}, {}", count, page.intValue());
		
		
		if(count > 0) {
			int offset = (page.intValue() - 1) * 4;
	        int limit = 4;
	        
	        Map<String, Object> params = new HashMap<>();
	        params.put("offset", offset);
	        params.put("limit", limit);
		
			gallerys = galleryMapper.selectGalleryList(params);
//			log.info("{}", gallerys);
		}
		
		map.put("pi", pi);
		map.put("gallerys", gallerys);
		
		return map;
	}

}
