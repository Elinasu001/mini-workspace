package com.kh.spring.board.model.dto;

import java.sql.Date;
import java.util.List;

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
public class BoardDTO {
	
	private Long boardNo;
	private String category;
	private String boardTitle;
	private String boardContent;
	private String boardWriter;
	private int viewCount;
	private String status;
	private Date enrollDate;
	private int likes;
	private List<ReplyDTO> replies;
	private AttachmentDTO attachment;
	
}
