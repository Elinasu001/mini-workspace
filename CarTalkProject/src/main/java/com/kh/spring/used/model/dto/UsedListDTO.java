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
public class UsedListDTO {
	
	private int usedNo;
    private String usedTitle;
    private int usedPrice;
    private String status;
    private Date enrollDate;
    private int viewCount;
    private String manufacturer;
    private String model;
    private String carYear;
    private int distance;
    private String transmission;
    private String fuelType;
    private String region;
    private String carColor;
    private String phone;
    private String thumbnail;
    private String category;

}
