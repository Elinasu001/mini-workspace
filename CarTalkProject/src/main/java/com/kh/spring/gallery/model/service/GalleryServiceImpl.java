package com.kh.spring.gallery.model.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.gallery.model.dto.AttachmentDTO;
import com.kh.spring.gallery.model.dto.GalleryDTO;
import com.kh.spring.gallery.model.dto.ReplyDTO;
import com.kh.spring.gallery.model.mapper.GalleryMapper;
import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.util.PageInfo;
import com.kh.spring.util.Pagination;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class GalleryServiceImpl implements GalleryService {
	
	private final GalleryMapper galleryMapper;
	private final Pagination pagination;
	
	@Override
	public Map<String, Object> selectGalleryList(Long page) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<GalleryDTO> gallerys = new ArrayList();
		
		//TODO: 유효성검증- 요청 페이지수가 -1 등 유효하지 않을경우 
		if(page < 1) {}
		
		int count = galleryMapper.selectTotalcount();
//		log.info("{}", count);
		PageInfo pi = pagination.getPageInfo(count, page.intValue(), 5, 4);
//		log.info("{}, {}", count, page.intValue());
		
		
		if(count > 0) {
			int offset = (page.intValue() - 1) * 4;
	        int limit = 4;
	        
	        Map<String, Object> params = new HashMap<>();
	        params.put("offset", offset);
	        params.put("limit", limit);
		
			gallerys = galleryMapper.selectGalleryList(params);
//			log.info("{}", gallerys);
		}
		
		map.put("pi", pi);
		map.put("gallerys", gallerys);
		
		return map;
	}

	@Override
	public GalleryDTO selectGalleryByNo(Long galleryNo) {
		
		List<AttachmentDTO> attachments = new ArrayList();
		List<ReplyDTO> replys = new ArrayList();
//		log.info("{}",galleryNo);
		
		//TODO: 유효성검증
		/*			*/
		attachments = galleryMapper.selectAttachmentsByNo(galleryNo);
		
		replys = galleryMapper.selectReplysByNo(galleryNo);
		
		int replyCount = galleryMapper.selectReplyCount(galleryNo);
		
		GalleryDTO gallery = galleryMapper.selectGalleryByNo(galleryNo);
		
		gallery.setAttatchments(attachments);
		
		gallery.setReplies(replys);
		
		gallery.setReplyCount(replyCount);
		
		return gallery;
	}

	@Override
	public int insertGallery(GalleryDTO gallery, MultipartFile thumnail, 
							 List<MultipartFile> upfiles, HttpSession session) {
		
		int result = 0;
		
		int userNo = ((MemberDTO)session.getAttribute("loginMember")).getUserNo();
		
		gallery.setNickname(String.valueOf(userNo));
		
		log.info("유저넘버 뜨냐 {}", gallery);
	
		int gallResult = galleryMapper.insertGallery(gallery);
		
		Long galleryNo = gallery.getGalleryNo();
		log.info("{}", galleryNo);
//		log.info("썸네일:{} 파일:{}", thumnail, upfiles);
		
//		if(gallResult == 1) {
//			
//			result = insertAttachment(gallery, thumnail, upfiles, session);
//		}
		
		return result;
	}

	private int insertAttachment(GalleryDTO gallery, MultipartFile thumnail, List<MultipartFile> upfiles,
			HttpSession session) {
		
		int result = 0;
		int orderNo = 1;
		
		// 1. 첨부파일 정렬
		List<MultipartFile> sortedUpfiles = sortUpfiles(thumnail, upfiles);
		
		// 2. 반복해서 올려잇
		for(MultipartFile upfile : sortedUpfiles) {
			
			AttachmentDTO at = new AttachmentDTO();
			
			Map<String, String> saveAt = setAttachmentNamePath(upfile, session);
			
//			log.info("진짜 되나? {}, {}", saveAt.get("changeName"), saveAt.get("savePath")); 되네;;;왜됨;;
			
			try {
				upfile.transferTo(new File(saveAt.get("savePath") + saveAt.get("changeName")));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			at.setOriginName(upfile.getOriginalFilename());
			at.setChangeName(saveAt.get("changeName"));
			at.setFilePath("/ct/resources/upfiles/gallery");
			at.setRefGno(gallery.getGalleryNo());
			at.setOrderNo(Long.valueOf(orderNo++));
			
			log.info("뽑아: {}", at);
			
			int atResult = galleryMapper.insertAttachment(at);
			
			// 실패하면 예외 ㄱㄱ
			if(atResult != 1) {
				log.info("먼가잘못된거임!!!!");
			}
			
			
			result++;
			
		}
		
		return result;
	}

	private Map<String, String> setAttachmentNamePath(MultipartFile upfile, HttpSession session) {

		Map<String, String> saveAt = new HashMap();
		
		StringBuilder sb = new StringBuilder();
		sb.append("CarTalk_");
		String CurrentDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
		sb.append(CurrentDay);
		sb.append("_");
		int randNum = (int)(Math.random() * 9000)+1000;
		sb.append(randNum);
		String ext = upfile.getOriginalFilename().substring(upfile.getOriginalFilename().lastIndexOf(".")); 
		sb.append(ext);
		
		ServletContext application = session.getServletContext();
		String savePath = application.getRealPath("/resources/upfiles/gallery/");
		
		saveAt.put("changeName", sb.toString());
		saveAt.put("savePath", savePath);
		
		return saveAt;
	}

	private List<MultipartFile> sortUpfiles(MultipartFile thumnail, List<MultipartFile> upfiles) {

		List<MultipartFile> fl = upfiles;
		fl.add(0, thumnail);
		
		return fl;
	}

}
