package com.kh.spring.used.model.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.used.model.dto.UsedAttachmentDTO;
import com.kh.spring.used.model.dto.UsedDTO;
import com.kh.spring.used.model.dto.UsedListDTO;
import com.kh.spring.util.PageInfo;

public interface UsedService {

	List<UsedListDTO> selectUsedListAll(PageInfo pi, String keyword);
	int selectListCount(String keyword);
	int insertUsed(UsedDTO used, List<MultipartFile> files, HttpSession session);
	UsedListDTO selectUsedDetail(int usedNo);
	UsedDTO selectCarInfo(int usedNo);
	List<UsedAttachmentDTO> selectAttachments(int usedNo);
	int deleteUsed(int usedNo);
	int selectMyListCount(int userNo, String status);
	List<UsedListDTO> selectMyUsedList(PageInfo pi, int userNo, String status);
	
}
