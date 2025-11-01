package com.kh.spring.used.model.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
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
	public Long insertUsed(UsedDTO used, List<MultipartFile> files, HttpSession session) {
		Long usedNo = usedMapper.getNextUsedNo();
		used.setUsedNo(usedNo);
		
		int result1 = usedMapper.insertUsed(used);
		if (result1 == 0) return null;

		String savePath = session.getServletContext().getRealPath("/resources/upfiles/used/");
		File folder = new File(savePath);
		if(!folder.exists())folder.mkdirs();
		
		String thumbnailPath = null;
		int result3 = 1;

		if (files != null && !files.isEmpty()) {
			for (MultipartFile mf : files) {
				if (mf.isEmpty())
					continue;

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
					continue; // 실패한 파일은 건너뜀
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

				result3 *= usedMapper.insertAttachment(attach);
			}
		}

		used.setThumbnail(thumbnailPath);

		
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

		int result2 = usedMapper.insertCarInfo(car);

		return (result1 > 0 && result2 > 0 && result3 > 0) ? usedNo : null;
	}

}
