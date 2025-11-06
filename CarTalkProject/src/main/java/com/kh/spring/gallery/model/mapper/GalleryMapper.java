package com.kh.spring.gallery.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.spring.gallery.model.dto.AttachmentDTO;
import com.kh.spring.gallery.model.dto.GalleryDTO;
import com.kh.spring.gallery.model.dto.ReplyDTO;

@Mapper
public interface GalleryMapper {

	List<GalleryDTO> selectGalleryList(Map<String, Object> params);

	int selectTotalcount();

	List<AttachmentDTO> selectAttachmentsByNo(Long galleryNo);

	List<ReplyDTO> selectReplysByNo(Long galleryNo);

	GalleryDTO selectGalleryByNo(Long galleryNo);
	
	int selectReplyCount(Long galleryNo);

	int insertGallery(GalleryDTO gallery);

	int insertAttachment(AttachmentDTO at);

	void increaseCount(Long galleryNo);

	int updateGallery(GalleryDTO gallery);

	int updateAttachment(AttachmentDTO at);

	void deleteAllAttachment(Long galleryNo);

	void deleteGallery(Long galleryNo);

	void insertReply(ReplyDTO reply);
}
