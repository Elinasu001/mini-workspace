package com.kh.spring.used.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class UsedListing {
	
	private int usedNo;
    private int userNo;
    private String usedTitle;
    private String usedContent;
    private int usedPrice;
    private String status;
    private Date enrollDate;
    private int viewCount;
}
