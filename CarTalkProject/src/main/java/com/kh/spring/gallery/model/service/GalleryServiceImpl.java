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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.exception.BadRequestException;
import com.kh.spring.exception.BoardSaveFailedException;
import com.kh.spring.exception.UserIdNotFoundException;
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
	
	private void isNegativeNum (Long number) {
		if( number < 1) {
			throw new BadRequestException("잘못된 페이지 요청입니다. (페이지 음수값)");
		}
	}
	
	@Override
	public Map<String, Object> selectGalleryList(Long page) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<GalleryDTO> gallerys = new ArrayList();
		
		// 유효성검증: 요청 페이지가 유효하지 않은 값- 음수
		isNegativeNum(page);
		
		int count = galleryMapper.selectTotalcount();
		
		
		PageInfo pi = pagination.getPageInfo(count, page.intValue(), 5, 4);
		
		// 유효성검증: 요청 페이지가 유효하지 않은 값- 존재하는 페이지보다 큰 숫자 요청
		if(page > pi.getMaxPage() ) {
			
			throw new BadRequestException("잘못된 페이지 요청입니다. (존재하지 않는 페이지)");
		}
		
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
		
		isNegativeNum(galleryNo);
			
		attachments = galleryMapper.selectAttachmentsByNo(galleryNo);
		
		replys = galleryMapper.selectReplysByNo(galleryNo);
		
		galleryMapper.increaseCount(galleryNo);
		
		int replyCount = galleryMapper.selectReplyCount(galleryNo);
		
		GalleryDTO gallery = galleryMapper.selectGalleryByNo(galleryNo);
		
		if(gallery == null) {
			throw new BadRequestException("존재하지 않는 게시물입니다.");
		}
		
		
		gallery.setAttachments(attachments);
		
		gallery.setReplies(replys);
		
		gallery.setReplyCount(replyCount);
		
		return gallery;
	}

	@Override
	public int insertGallery(GalleryDTO gallery, MultipartFile thumnail, 
							 List<MultipartFile> upfiles, HttpSession session) {
		
		int result = 0;
		
		/*
		int userNo = ((MemberDTO)session.getAttribute("loginMember")).getUserNo();
		
		gallery.setNickname(String.valueOf(userNo)); */
		gallery = getLoginName(gallery, session);
		
		int gallResult = galleryMapper.insertGallery(gallery);
		
		if(gallResult == 1) {
			
			result = insertAttachment(gallery, thumnail, upfiles, session);
		}
		
		return result;
	}

	private GalleryDTO getLoginName(GalleryDTO gallery, HttpSession session) {
		
		int userNo = getLoginNo(session);
		gallery.setNickname(String.valueOf(userNo));
		
		return gallery;
	}

	private int getLoginNo(HttpSession session) {
		
		if(session.getAttribute("loginMember") == null) {
			throw new UserIdNotFoundException("로그인이 유효하지 않습니다.");
		}
		
		return ((MemberDTO)session.getAttribute("loginMember")).getUserNo();
	}

	private int insertAttachment(GalleryDTO gallery, MultipartFile thumnail, List<MultipartFile> upfiles,
			HttpSession session) {
		
		int result = 0;
		
		// 1. 첨부파일 정렬
		List<MultipartFile> sortedUpfiles = sortUpfiles(thumnail, upfiles);
		
		// 2. 반복해서 올려잇
		/*
		for(MultipartFile upfile : sortedUpfiles) {
			
			if(upfile.isEmpty()) {
				return result;
			}
			
			AttachmentDTO at = new AttachmentDTO();
			
			Map<String, String> saveAt = setAttachmentNamePath(upfile, session);
			
			
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
		
		
			int atResult = galleryMapper.insertAttachment(at);
			
			// 실패하면 예외 ㄱㄱ
			if(atResult != 1) {
				log.info("중간에 먼가잘못된거임!!!!");
			}
			
			
			result++;
			
		}																			*/
		List<AttachmentDTO> ats = changeUpfilesName(gallery, sortedUpfiles, session);
		
		for(AttachmentDTO at : ats) {
			int atResult = galleryMapper.insertAttachment(at);
			
			if(atResult != 1) {
				log.info("중간에 먼가잘못된거임!!!!");
				throw new BoardSaveFailedException("첨부파일 업로드 중 오류가 발생했습니다. 다시 시도해주세요");
			}
			
			result++;
		}
		
		return result;
	}

	private List<AttachmentDTO> changeUpfilesName(GalleryDTO gallery, List<MultipartFile> sortedUpfiles, HttpSession session) {
		
		int orderNo = 1;
		
		List<AttachmentDTO> ats = new ArrayList();
		
		for(MultipartFile upfile : sortedUpfiles) {
					
			if(upfile.isEmpty()) {
				return ats;
			}
			
			AttachmentDTO at = new AttachmentDTO();
			
			Map<String, String> saveAt = setAttachmentNamePath(upfile, session);
			
			
			try {
				upfile.transferTo(new File(saveAt.get("savePath") + saveAt.get("changeName")));
			} catch (Exception e) {
				e.printStackTrace();
				throw new BoardSaveFailedException("첨부파일 업로드 중 오류가 발생했습니다. 다시 시도해주세요");
			}
			
			
			at.setOriginName(upfile.getOriginalFilename());
			at.setChangeName(saveAt.get("changeName"));
			at.setFilePath("/ct/resources/upfiles/gallery");
			at.setRefGno(gallery.getGalleryNo());
			at.setOrderNo(Long.valueOf(orderNo++));
			
			ats.add(at);
		
		}
		return ats;
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

		List<MultipartFile> fl = new ArrayList();
		
		if(!(upfiles.isEmpty())){
			fl = upfiles;
			fl.add(0, thumnail);
		} else {
			fl.add(thumnail);
		}
		
		
		return fl;
	}

	@Transactional
	@Override
	public void updateGallery(GalleryDTO gallery, MultipartFile thumnail, List<MultipartFile> upfiles,
			HttpSession session) {
		
		int result = 0;
		
		getLoginName(gallery, session);
		
		int gallResult = galleryMapper.updateGallery(gallery);
		
		if(gallResult == 1) {
			
			// 1. 기존 업로드 파일은 수정여부 상관없이 삭제처리
			Long galleryNo = gallery.getGalleryNo();
			galleryMapper.deleteAllAttachment(galleryNo);
			// 2. 새로운 업로드 파일을 새롭게 추가
			result = insertNewAttachment(gallery, thumnail, upfiles, session);
		}
	}

	private int insertNewAttachment(GalleryDTO gallery, MultipartFile thumnail, List<MultipartFile> upfiles,
			HttpSession session) {
		 int result = 0;
		    List<MultipartFile> sortedUpfiles = sortUpfiles(thumnail, upfiles);
		    List<AttachmentDTO> ats = changeUpfilesName(gallery, sortedUpfiles, session);
		    
		    for (AttachmentDTO at : ats) {
		        int atResult = galleryMapper.insertAttachment(at);
		        if (atResult != 1) {
		            log.info("첨부파일 삽입 중 오류 발생!");
		            throw new BoardSaveFailedException("첨부파일 업로드 중 오류가 발생했습니다. 다시 시도해주세요");
		        }
		        result++;
		    }
		    return result;
	}

	@Transactional
	@Override
	public void deleteGallery(Long galleryNo) {
		galleryMapper.deleteGallery(galleryNo);
		
	}

	@Override
	public void insertReply(Long galleryNo, ReplyDTO reply, HttpSession session) {

		isNegativeNum(galleryNo);
		
		int writerNo = getLoginNo(session);
		
		reply.setReplyWriter(String.valueOf(writerNo));
		
		reply.setRefGno(galleryNo);
		
		galleryMapper.insertReply(reply);
		
	}


}
