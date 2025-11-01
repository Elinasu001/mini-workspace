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
public class MemberDTO {

	private int userNo;
	private String userId;
	private String userPwd;
	private String userName;
	private String nickName;
	private String email;
	private Date enrollDate;
	private String manager;
}
