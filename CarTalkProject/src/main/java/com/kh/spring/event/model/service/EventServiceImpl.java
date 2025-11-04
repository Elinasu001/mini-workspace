package com.kh.spring.event.model.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.event.model.dto.EventDTO;
import com.kh.spring.event.model.mapper.EventMapper;
import com.kh.spring.event.model.vo.EventAttachment;
import com.kh.spring.event.model.vo.EventCategory;
import com.kh.spring.exception.*;
import com.kh.spring.member.model.dto.MemberDTO;
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
    
    // ===================== 메인 페이지 =====================
    
    
    /** 진행 중 이벤트 Top3 조회 **/
    @Override
    public List<EventDTO> selectEventOngoingTop() {
    	 List<EventDTO> list = eventMapper.selectEventOngoingTop();
         //log.info("진행중 이벤트 3개: {}", list);
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
    	 
        validateEventNo(eventNo);// 이벤트 번호 유효성 검사 (PK 범위인지)
        increaseViewCount(eventNo);// 조회수 증가 처리
        
        // DB 조회
        EventDTO event = eventMapper.selectByEventNo(eventNo);
        if (event == null) {
            throw new BadRequestException("존재하지 않는 이벤트입니다.");
        }
        
        // DB 조회 결과 후처리 : 파일 정보 DTO에 매핑
        setEventFileData(event);

        return event;
    }
    
    // ===================== 등록 =====================
    
    
    /** 이벤트 등록 **/
    @Override
    public int insertEvent(EventDTO event, MultipartFile thumbnail, MultipartFile detailImage, HttpSession session) {
       
    	validateUser(event, session);// 관리자 권한 검증
        validateEvent(event);// 제목/내용 기본 검증
        validateInsertFiles(thumbnail, detailImage);// 첨부파일 필수 검증

        int result = eventMapper.insertEvent(event);
        if (result != 1) throw new BadRequestException("이벤트 등록 실패");

        Long eventNo = event.getEventNo();
        
        // 썸네일 저장 / 상세 이미지 저장
        saveAttachment(thumbnail, eventNo, session, 0);
        saveAttachment(detailImage, eventNo, session, 1);

        return result;
    }
    
    // ===================== 수정 =====================
    
    
    /** 이벤트 수정 **/
    @Override
    public int updateEvent(EventDTO event, MultipartFile thumbnail, MultipartFile detailImage, HttpSession session) {
        
    	validateUser(event, session);// 관리자 권한 검증
        validateEvent(event);// 제목/내용 기본 검증

        Long eventNo = event.getEventNo();
        List<EventAttachment> attachments = eventMapper.selectAttachmentsByEventNo(eventNo);// 기존 파일 조회
        
        
        validateUpdateFiles(attachments, thumbnail, detailImage);// 첨부파일 필수 검증
        
        int result = eventMapper.updateEvent(event);
        if (result != 1) throw new BadRequestException("이벤트 수정 실패");// 트랜잭션 안정성 : DB 실행 직후 처리

        //log.info("번호 : {}", eventNo);
        
        
        // 파일 교체 공통 처리
        replaceAttachment(attachments, thumbnail, eventNo, session, 0); // 썸네일
        replaceAttachment(attachments, detailImage, eventNo, session, 1); // 상세 이미지
        
        return result;
    }
    
    
    /** 이벤트 삭제 (상태값 변경) **/
    @Override
    public Long deleteEvent(Long eventNo) {
        Long result = eventMapper.deleteEvent(eventNo);
        
        if (result > 0) {
            log.info("이벤트 삭제 완료: {}", eventNo);
        } else {
            log.warn("이벤트 삭제 실패: {}", eventNo);
        }
        return result;
    }
    
    
    // ===================== 카테고리 =====================
    
    /** 카테고리 목록 조회 **/
    @Override
    public List<EventCategory> selectCategoryList() {
        return eventMapper.selectCategoryList();
    }

    
    
    //=========== 유효성 검증 =========== 
    
    /** 페이지 번호 유효성 검사 (1 이상인지 확인) */
    private void validatePage(Long page) {
        if (page == null || page < 1) {
            throw new InvalidArgumentsException("잘못된 접근입니다.");
        }
    }

    /** 이벤트 번호 유효성 검사 (유효한 PK 범위인지 확인) **/
    private void validateEventNo(Long eventNo) {
        if (eventNo == null || eventNo < 1) {
            throw new InvalidArgumentsException("유효하지 않은 요청입니다.");
        }
    }
    
    /** 관리자 권한 검증 **/
    private void validateUser(EventDTO event, HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null || !"Y".equals(loginMember.getManager())) {
            throw new AuthenticationException("관리자만 접근 가능합니다.");
        }

        event.setEventTitle(event.getEventTitle().replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
        event.setEventContent(event.getEventContent().replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
        event.setUserNo(loginMember.getUserNo());
    }
    
    /** 제목/내용 기본 검증 **/
    private void validateEvent(EventDTO event) {
        if (event.getEventTitle() == null || event.getEventTitle().trim().isEmpty()
         || event.getEventContent() == null || event.getEventContent().trim().isEmpty()) {
            throw new InvalidArgumentsException("제목 또는 내용이 비어 있습니다.");
        }
    }
    
    /** 이벤트 등록 시 파일 필수 검증 **/
    private void validateInsertFiles(MultipartFile thumbnail, MultipartFile detailImage) {
        if (thumbnail == null || thumbnail.isEmpty()) {
            throw new BadRequestException("썸네일 이미지는 필수입니다.");
        }
        if (detailImage == null || detailImage.isEmpty()) {
            throw new BadRequestException("상세 이미지는 필수입니다.");
        }
    }

    /** 이벤트 수정 시 파일 검증 **/
    private void validateUpdateFiles(List<EventAttachment> existingFiles, MultipartFile thumbnail, MultipartFile detailImage) {

        boolean hasThumb = existingFiles.stream().anyMatch(f -> f.getFileLevel() == 0);
        boolean hasDetail = existingFiles.stream().anyMatch(f -> f.getFileLevel() == 1);

        boolean newThumb = (thumbnail != null && !thumbnail.isEmpty());
        boolean newDetail = (detailImage != null && !detailImage.isEmpty());

        if ((!hasThumb && !newThumb) || (!hasDetail && !newDetail)) {
            throw new BadRequestException("썸네일과 상세 이미지는 최소 1개 이상 필요합니다.");
        }
    }
    
    //=========== 파일 처리 관련 내부 유틸 메서드 =========== 
    
    /** 
     * DB 파일 목록 : DTO 썸네일/상세 이미지 필드 매핑
     * (fileLevel 0=썸네일, 1=상세)
     */
    private void setEventFileData(EventDTO event) {
        if (event.getFiles() == null || event.getFiles().isEmpty()) {
            return;
        }

        for (EventAttachment file : event.getFiles()) {
            if (file.getFileLevel() == 0) {
                event.setThumbnailPath(file.getFilePath());
                event.setThumbnailName(file.getChangeName());
            } else if (file.getFileLevel() == 1) {
                event.setDetailPath(file.getFilePath());
                event.setDetailName(file.getChangeName());
            }
        }
    }
    
    /** 파일 교체 처리 (기존 삭제 + 신규 저장) **/
    private void replaceAttachment(List<EventAttachment> attachments,
                                   MultipartFile newFile, Long eventNo,
                                   HttpSession session, int fileLevel) {
        
        if (newFile != null && !newFile.isEmpty()) {

            EventAttachment oldFile = attachments.stream()
                    .filter(f -> f.getFileLevel() == fileLevel)
                    .findFirst()
                    .orElse(null);

            if (oldFile != null) {
                deleteOldAttachment(oldFile.getFileNo(), session);
            }

            saveAttachment(newFile, eventNo, session, fileLevel);
        }
    }

    
    
    
    /** 파일 저장 (물리 저장 및 DB저장) **/
    private void saveAttachment(MultipartFile file, Long eventNo, HttpSession session, int fileLevel) {

        //  파일 비어있을 경우 업로드 스킵
        if (file == null || file.isEmpty()) {
            log.warn("첨부파일이 비어있음 (fileLevel={}): 업로드 스킵", fileLevel);
            return;
        }

        String originName = file.getOriginalFilename();

        //  확장자 유효성 검증 (확장자 없는 파일 방지)
        if (originName == null || !originName.contains(".")) {
            log.error("확장자를 찾을 수 없는 파일명: {}", originName);
            return;
        }

        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        int rand = (int) (Math.random() * 900) + 100;
        String ext = originName.substring(originName.lastIndexOf("."));
        String prefix = (fileLevel == 0) ? "EVT_TH_" : "EVT_DE_";
        String changeName = prefix + currentTime + "_" + rand + ext;

        // 경로 수정 (실제 사용하는 구조로 변경)
        ServletContext app = session.getServletContext();
        String saveDir = (fileLevel == 0)
                ? app.getRealPath("/resources/upfiles/event/thumb/")
                : app.getRealPath("/resources/upfiles/event/detail/");
        String relativePath = (fileLevel == 0)
                ? "/resources/upfiles/event/thumb/"
                : "/resources/upfiles/event/detail/";

        File dir = new File(saveDir);

        // 폴더 자동 생성 + 성공 여부 로그
        if (!dir.exists()) {
            boolean created = dir.mkdirs();
            log.info("업로드 폴더 생성: {} (성공여부: {})", saveDir, created);
        }

        try {
            File target = new File(saveDir, changeName);
            file.transferTo(target);

            // 저장 성공 로그
            log.info("파일 저장 완료: {}", target.getAbsolutePath());

        } catch (Exception e) {
            // 에러 로그 보강
            log.error("파일 저장 실패: {}", e.getMessage(), e);
            throw new RuntimeException("파일 저장 실패", e);
        }

        EventAttachment attach = new EventAttachment();
        attach.setRefBno(eventNo);
        attach.setOriginName(originName);
        attach.setChangeName(changeName);
        attach.setFilePath(relativePath);
        attach.setFileLevel(fileLevel);

        eventMapper.insertAttachment(attach);
        log.info("DB 저장 완료: {}", attach);
    }


    /** 기존 파일 삭제 (물리 저장 및 DB 상태 변경)**/
    private void deleteOldAttachment(Long fileNo, HttpSession session) {
        EventAttachment oldFile = eventMapper.selectAttachmentByFileNo(fileNo);
        
        if (oldFile != null) {
            ServletContext app = session.getServletContext();
            String fullPath = app.getRealPath(oldFile.getFilePath() + oldFile.getChangeName());
            File delFile = new File(fullPath);
            
            if (delFile.exists() && delFile.delete()) {
                log.info("파일 삭제 완료: {}", delFile.getAbsolutePath());
            } else {
                log.warn("파일 물리 삭제 실패: {}", fullPath);
            }
            
            eventMapper.deleteAttachment(fileNo); // DB STATUS = 'N' 처리
        }
    }
    
    // ================= 조회 관련 내부 비즈니스 로직 ========================
    /** 조회수 증가 **/
    private void increaseViewCount(Long eventNo) {
        int result = eventMapper.increaseCount(eventNo);
        if (result != 1) {// 트랜잭션 안정성: DB 결과 즉시 검증
            throw new BadRequestException("조회수 증가 중 오류 발생");
        }
    }
    
    
    
    /**
     * 공통 페이징 조회 처리
     * @param page 요청 페이지 번호
     */
    private Map<String, Object> getEventList(Long page, String type) {

        validatePage(page);

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
