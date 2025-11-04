package com.kh.spring.member.model.dto;

import java.util.Date;

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
public class MemberUpdateDTO {

	
	private int  updateNo;
	private int  userNo;
	private String changePwd;
	private String updateDate;
	private String status;
}
