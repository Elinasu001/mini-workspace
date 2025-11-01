package com.kh.spring.used.model.dto;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class CarInfoDTO {
	
	private Long carNo;
	private Long usedNo;
	private String manufacturer;
	private String model;
	private String carYear;
	private int distance;
	private String transmission;
	private String fuelType;
	private String region;
	private String carColor;
	private String phone;

}
