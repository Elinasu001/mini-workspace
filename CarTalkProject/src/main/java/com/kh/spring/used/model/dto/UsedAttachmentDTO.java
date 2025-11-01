package com.kh.spring.used.model.dto;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class UsedAttachmentDTO {
	
	private Long fileNo;
	private Long refBno;
	private String originName;
	private String changeName;
	private String filePath;
	private String uploadDate;
	private String status;

}
