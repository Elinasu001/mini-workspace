package com.kh.spring.gallery.model.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class AttachmentDTO {

	private Long attachmentNo;
	private Long refGno;
	private Long orderNo;
	private String originName;
	private String changeName;
	private String filePath;
	private Date enrollDate;
	private String status;
}
