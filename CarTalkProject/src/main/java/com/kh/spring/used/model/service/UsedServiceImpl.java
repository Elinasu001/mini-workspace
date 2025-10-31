package com.kh.spring.used.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.spring.used.model.dto.UsedListDTO;
import com.kh.spring.used.model.mapper.UsedMapper;
import com.kh.spring.util.PageInfo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class UsedServiceImpl implements UsedService {
	
	
	private final UsedMapper usedMapper;

	@Override
	public List<UsedListDTO> selectUsedListAll(PageInfo pi, String keyword) {
		int startRow = (pi.getCurrentPage() -1 ) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;
		
		Map<String, Object> map = new HashMap<>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("keyword", keyword);
		return usedMapper.selectUsedListAll(map);
	}
	
	@Override
	public int selectListCount(String keyword) {
		return usedMapper.selectListCount(keyword);
	}
	
	
}
