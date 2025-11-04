package com.kh.spring.board.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AttachmentDTO {

	private Long fileNo;
	private Long refBno;
	private String originName;
	private String changeName;
	private String filePath;
	private Date uploadDate;
	private String status;
}
