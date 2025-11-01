package com.kh.spring.used.model.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.used.model.dto.UsedDTO;
import com.kh.spring.used.model.dto.UsedListDTO;
import com.kh.spring.util.PageInfo;

public interface UsedService {

	List<UsedListDTO> selectUsedListAll(PageInfo pi, String keyword);
	int selectListCount(String keyword);
	Long insertUsed(UsedDTO used, List<MultipartFile> files, HttpSession session);
	
}
