package com.kh.spring.used.model.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.used.model.dto.CarInfoDTO;
import com.kh.spring.used.model.dto.UsedAttachmentDTO;
import com.kh.spring.used.model.dto.UsedDTO;
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
		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
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
	
	@Override
	public void increaseViewCount(int usedNo) {
		usedMapper.increaseViewCount(usedNo);
	}

	@Transactional
	@Override
	public int insertUsed(UsedDTO used, List<MultipartFile> files, HttpSession session) {

	    int usedNo = usedMapper.getNextUsedNo();
	    used.setUsedNo(usedNo);

	    String savePath = session.getServletContext().getRealPath("/resources/upfiles/used/");
	    File folder = new File(savePath);
	    if (!folder.exists()) folder.mkdirs();

	    String thumbnailPath = null;
	    int resultAttach = 1;
	    List<UsedAttachmentDTO> attachList = new ArrayList<>();

	    if (files != null && !files.isEmpty()) {
	        for (MultipartFile mf : files) {
	            if (mf.isEmpty()) continue;

	            String originName = mf.getOriginalFilename();
	            String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	            int randomNum = (int) (Math.random() * 900) + 100;
	            String ext = originName.substring(originName.lastIndexOf("."));
	            String changeName = "USED_" + currentTime + "_" + randomNum + ext;

	            File targetFile = new File(savePath, changeName);
	            try {
	                mf.transferTo(targetFile);
	            } catch (IOException e) {
	                e.printStackTrace();
	                continue;
	            }

	            String dbPath = "/resources/upfiles/used/" + changeName;

	            if (thumbnailPath == null) {
	                thumbnailPath = dbPath;
	            }

	            UsedAttachmentDTO attach = new UsedAttachmentDTO();
	            attach.setRefBno(usedNo);
	            attach.setOriginName(originName);
	            attach.setChangeName(changeName);
	            attach.setFilePath(dbPath);
	            attach.setStatus("Y");

	            attachList.add(attach);
	        }
	    }

	    used.setThumbnail(thumbnailPath);
	    int resultUsed = usedMapper.insertUsed(used);
	    if (resultUsed == 0) return 0;

	    for (UsedAttachmentDTO attach : attachList) {
	        resultAttach *= usedMapper.insertAttachment(attach);
	    }

	    CarInfoDTO car = new CarInfoDTO();
	    car.setUsedNo(usedNo);
	    car.setManufacturer(used.getManufacturer());
	    car.setModel(used.getModel());
	    car.setCarYear(used.getCarYear());
	    car.setDistance(used.getDistance());
	    car.setTransmission(used.getTransmission());
	    car.setFuelType(used.getFuelType());
	    car.setRegion(used.getRegion());
	    car.setCarColor(used.getCarColor());
	    car.setPhone(used.getPhone());

	    int resultCar = usedMapper.insertCarInfo(car);

	    return (resultUsed > 0 && resultAttach > 0 && resultCar > 0) ? usedNo : 0;
	}


	@Override
	public UsedListDTO selectUsedDetail(int usedNo) {
		return usedMapper.selectUsedDetail(usedNo);
	}

	@Override
	public UsedDTO selectCarInfo(int usedNo) {
		return usedMapper.selectCarInfo(usedNo);
	}

	@Override
	public List<UsedAttachmentDTO> selectAttachments(int usedNo) {
		return usedMapper.selectAttachments(usedNo);
	}

	@Transactional
	@Override
	public int deleteUsed(int usedNo) {

		usedMapper.deleteAttachments(usedNo);

		usedMapper.deleteCarInfo(usedNo);

		int result = usedMapper.deleteUsed(usedNo);

		log.info("삭제 처리 결과 (usedNo{}) : {}", usedNo, result);
		return result;
	}

	@Override
	public int selectMyListCount(int userNo, String status) {

		if ("전체".equals(status))
			status = null;

		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("status", status);

		return usedMapper.selectMyListCount(map);
	}

	@Override
	public List<UsedListDTO> selectMyUsedList(PageInfo pi, int userNo, String status) {

		if ("전체".equals(status))
			status = null;

		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;

		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("status", status);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("boardLimit", pi.getBoardLimit());

		return usedMapper.selectMyUsedList(map);
	}

	@Override
	public int updateUsed(UsedDTO used, HttpSession session) {

		int result = usedMapper.updateUsed(used);

		return result;
	}

}
