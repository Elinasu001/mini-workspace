package com.kh.spring.event.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.event.model.dto.EventDTO;
import com.kh.spring.event.model.mapper.EventMapper;
import com.kh.spring.event.model.vo.EventAttachment;
import com.kh.spring.event.model.vo.EventCategory;
import com.kh.spring.exception.BadRequestException;
import com.kh.spring.util.PageInfo;
import com.kh.spring.util.Pagination;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {

    private final EventMapper eventMapper;
    private final Pagination pagination;
    private final EventValidator eventValidator;
    private final EventFileHandler eventFileHandler;
    
    
    // ===================== 메인 페이지 =====================
    /** 진행 중 이벤트 Top3 조회 **/
    @Override
    public List<EventDTO> selectEventOngoingTop() {
    	 List<EventDTO> list = eventMapper.selectEventOngoingTop();
         return list;
    }
    
    
    // ===================== 목록 조회 =====================
    /** 진행 중 이벤트 목록 조회**/
    @Override
    public Map<String, Object> selectOngoing(Long page) {
        return getEventList(page, "ongoing");
    }
    
    /** 종료된 이벤트 목록 조회 **/
    @Override
    public Map<String, Object> selectEnded(Long page) {
        return getEventList(page, "ended");
    }
    
    
    // ===================== 상세 조회 =====================
    /** 이벤트 상세 조회 + 조회수 증가 **/
    @Override
    public EventDTO selectByEventNo(Long eventNo) {
    	 
    	eventValidator.validateEventNo(eventNo);// 이벤트 번호 유효성 검사 (PK 범위인지)
        increaseViewCount(eventNo);// 조회수 증가 처리
        
        // DB 조회
        EventDTO event = eventMapper.selectByEventNo(eventNo);
        if (event == null) {
            throw new BadRequestException("존재하지 않는 이벤트입니다.");
        }
        
        // 첨부 파일 조회 및 DTO에 세팅
        List<EventAttachment> files = eventMapper.selectAttachmentsByEventNo(eventNo);
        event.setFiles(files);
        
        // DB 조회 결과 후처리 : 파일 정보 DTO에 매핑
        eventFileHandler.setEventFileData(event);

        return event;
    }
    
    
    // ===================== 등록 =====================
    /** 이벤트 등록 **/
    @Override
    public int insertEvent(EventDTO event, MultipartFile thumbnail, MultipartFile detailImage, HttpSession session) {
       
    	eventValidator.validateAdmin(event, session);// 관리자 권한 검증
    	eventValidator.validateEvent(event);// 제목/내용 기본 검증
    	eventValidator.validateInsertFiles(thumbnail, detailImage);// 첨부파일 필수 검증

    	int result = eventMapper.insertEvent(event);
        eventValidator.validateDmlResult(result, "이벤트 등록 실패"); // DB 수정 수행 및 결과 검증

        Long eventNo = event.getEventNo();
        
        // 썸네일 저장 / 상세 이미지 저장
        eventFileHandler.saveAttachment(thumbnail, eventNo, session, 0); 
        eventFileHandler.saveAttachment(detailImage, eventNo, session, 1);

        return result;
    }
    
    
    // ===================== 카테고리 =====================
    /** 카테고리 목록 조회 **/
    @Override
    public List<EventCategory> selectCategoryList() {
    	List<EventCategory> list = eventMapper.selectCategoryList();
        eventValidator.validateCategoryList(list);
        return list;
    }
    
    
    // ===================== 수정 =====================
    /** 이벤트 수정 **/
    @Override
    public int updateEvent(EventDTO event, MultipartFile thumbnail, MultipartFile detailImage, HttpSession session) {
        
    	eventValidator.validateAdmin(event, session);// 관리자 권한 검증
    	eventValidator.validateEvent(event);// 제목/내용 기본 검증

        Long eventNo = event.getEventNo();
        List<EventAttachment> attachments = eventMapper.selectAttachmentsByEventNo(eventNo);// 기존 파일 조회
        
        eventValidator.validateUpdateFiles(attachments, thumbnail, detailImage);// 첨부파일 필수 검증
        
        int result = eventMapper.updateEvent(event);
        eventValidator.validateDmlResult(result, "이벤트 수정 실패");// DB 수정 수행 및 결과 검증
        
        // 파일 교체 공통 처리
        eventFileHandler.replaceAttachment(attachments, thumbnail, eventNo, session, 0); // 썸네일
        eventFileHandler.replaceAttachment(attachments, detailImage, eventNo, session, 1); // 상세 이미지
        
        return result;
    }
    
    /** 이벤트 삭제 (상태값 변경) **/
    @Override
    public int deleteEvent(Long eventNo, HttpSession session) {
    	
    	eventValidator.validateAdminSession(session);// 관리자 권한 검증
	    eventValidator.validateEventNo(eventNo); // 번호 검증
	    
	    int result = eventMapper.deleteEvent(eventNo);
        eventValidator.validateDmlResult(result, "이벤트 삭제 실패"); // DB 수정 수행 및 결과 검증
	    
	    // 종료 이벤트는  이미지 유지 — 물리 삭제하지 않음
	    //List<EventAttachment> files = eventMapper.selectAttachmentsByEventNo(eventNo);
	    //eventFileHandler.deleteAttachments(files, session);
	    
        return result;
    }
    
    
    
   
    // ================= 조회 관련 내부 비즈니스 로직 ========================
    
    
    /** 조회수 증가 **/
    private void increaseViewCount(Long eventNo) {
    	int result = eventMapper.increaseCount(eventNo);
        eventValidator.validateDmlResult(result, "조회수 증가 중 오류 발생");// DB 수정 수행 및 결과 검증
    }
    
    
    /**
     * 공통 페이징 조회 처리
     * @param page 요청 페이지 번호
     */
    private Map<String, Object> getEventList(Long page, String type) {

    	eventValidator.validatePage(page);

        int listCount = 0;
        List<EventDTO> events = new ArrayList<>();

        switch (type) {
	        case "ongoing":
	            listCount = eventMapper.selectOngoingCount();
	            break;
	        case "ended":
	            listCount = eventMapper.selectEndedCount();
	            break;
	        default:
	            throw new IllegalArgumentException("지원하지 않는 이벤트 타입입니다.");
	    }

        PageInfo pi = pagination.getPageInfo(listCount, page.intValue(), 6, 6);

        if (listCount > 0) {
            RowBounds rb = new RowBounds((page.intValue() - 1) * 6, 6);

            if ("ongoing".equals(type)) {
                events = eventMapper.selectOngoing(rb);
            } else if ("ended".equals(type)) {
                events = eventMapper.selectEnded(rb);
            }
        }

        return Map.of("pi", pi, "events", events);
    }


   
}
