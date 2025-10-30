package com.kh.spring.gallery.model.dto;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class GalleryDTO {

	private Long galleryNo;
	private String categoryName;
	private String nickname;
	private String galleryTitle;
	private String galleryContent;
	private Long viewCount;
	private Date enrollDate;
	private String status;
	private List<ReplyDTO> replies;
	private List<AttachmentDTO> attatchments;
	private String thumnailPath;
}
