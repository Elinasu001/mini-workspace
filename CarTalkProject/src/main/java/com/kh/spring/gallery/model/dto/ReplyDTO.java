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
public class ReplyDTO {

	private Long replyNo;
	private Long refGno;
	private String replyWriter;
	private String replyContent;
	private Date enrollDate;
	private String status;
}
