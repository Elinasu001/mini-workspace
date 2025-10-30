package com.kh.spring.gallery.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.spring.gallery.model.dto.GalleryDTO;

@Mapper
public interface GalleryMapper {

	List<GalleryDTO> selectGalleryList(Map<String, Object> params);

	int selectTotalcount();

}
