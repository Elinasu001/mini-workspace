package com.cartalk.board.model.dto;

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
public class BoardDTO {
	
	private Long boardNo;
	private String category;
	private String boardTitle;
	private String boardContent;
	private String boardWriter;
	private int count;
	private String status;
	private Date createDate;
	
}
