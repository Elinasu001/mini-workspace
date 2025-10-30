package com.kh.spring.used.model.service;

import java.util.List;

import com.kh.spring.used.model.dto.UsedListDTO;
import com.kh.spring.util.PageInfo;

public interface UsedService {

	List<UsedListDTO> selectUsedListAll(PageInfo pi, String keyword);
	int selectListCount(String keyword);
	
}
