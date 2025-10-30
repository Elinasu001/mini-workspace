package com.kh.spring.member.model.vo;

import java.util.Date;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

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
@Component
@Scope(value = "session", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Member {

	private int userNo;
	private String userId;
	private String userPwd;
	private String userName;
	private String nickName;
	private String email;
	private Date enrollDate;
	private String manager;
	
	
	
	
}
