package com.kh.spring.used.model.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class insertUsedDTO {
	
	private String usedTitle;
	private String category;
	private String manufacturer;
	private String model;
	private int usedPrice;
	private String carYear;
	private int distance;
	private String transmission;
	private String accident;
	private String carColor;
	private String usedContent;
	private String region;

}
