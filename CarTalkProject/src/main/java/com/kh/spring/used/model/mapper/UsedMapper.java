package com.kh.spring.used.model.mapper;

import java.util.List;
import java.util.Map;

import com.kh.spring.used.model.dto.UsedListDTO;


public interface UsedMapper {

	List<UsedListDTO> selectUsedListAll(Map<String, Object> map);
	int selectListCount(String keyword);

}
