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
    /**
     * 진행중 이벤트 조회
     **/
    @Override
    public Map<String, Object> selectOngoing(Long page) {
        if (page == null || page < 1) {
            throw new InvalidArgumentsException("잘못된 접근입니다.");
        }

        int listCount = eventMapper.selectOngoingCount();
        PageInfo pi = pagination.getPageInfo(listCount, page.intValue(), 6, 6);

        List<EventDTO> events = new ArrayList<>();
        if (listCount > 0) {
            RowBounds rb = new RowBounds((page.intValue() - 1) * 6, 6);
            events = eventMapper.selectOngoing(rb);
        }

        Map<String, Object> map = new HashMap<>();
        map.put("pi", pi);
        map.put("events", events);
        return map;
    }
    
    /**
     * 종료된 이벤트 조회
     **/
    @Override
    public Map<String, Object> selectEnded(Long page) {
        if (page == null || page < 1) {
            throw new InvalidArgumentsException("잘못된 접근입니다.");
        }

        int listCount = eventMapper.selectEndedCount();
        PageInfo pi = pagination.getPageInfo(listCount, page.intValue(), 6, 6);

        List<EventDTO> events = new ArrayList<>();
        if (listCount > 0) {
            RowBounds rb = new RowBounds((page.intValue() - 1) * 6, 6);
            events = eventMapper.selectEnded(rb);
        }

        Map<String, Object> map = new HashMap<>();
        map.put("pi", pi);
        map.put("events", events);
        return map;
    }
    
    
    /**
     * 이벤트 상세조회 (조회수 증가 포함)
     **/
    @Override
    public EventDTO selectByEventNo(Long eventNo) {
    	
        if (eventNo == null || eventNo < 1) {
            throw new InvalidArgumentsException("유효하지 않은 요청입니다.");
        }

        int result = eventMapper.increaseCount(eventNo);
        
        if (result != 1) {
            throw new BadRequestException("조회수 증가 중 오류 발생");
        }

        EventDTO event = eventMapper.selectByEventNo(eventNo);
        if (event == null) {
            throw new BadRequestException("존재하지 않는 이벤트입니다.");
        }
        
        // 파일 목록 중 썸네일 / 상세 이미지 세팅
        if (event.getFiles() != null && !event.getFiles().isEmpty()) {
            for (EventAttachment file : event.getFiles()) {
                if (file.getFileLevel() == 0) { // 썸네일
                    event.setThumbnailPath(file.getFilePath());
                    event.setThumbnailName(file.getChangeName());
                } else if (file.getFileLevel() == 1) { // 상세 이미지
                    event.setDetailPath(file.getFilePath());
                    event.setDetailName(file.getChangeName());
                }
            }
        }

        return event;
    }
    
    
    /**
     * 이벤트 등록
     **/
    @Override
    public int insertEvent(EventDTO event, MultipartFile thumbnail, MultipartFile detailImage, HttpSession session) {
        
    	validateUser(event, session);
        validateEvent(event);

        int result = eventMapper.insertEvent(event);
        if (result != 1) throw new BadRequestException("이벤트 등록 실패");

        Long eventNo = event.getEventNo();

        if (thumbnail != null && !thumbnail.isEmpty()) saveAttachment(thumbnail, eventNo, session, 0);
        if (detailImage != null && !detailImage.isEmpty()) saveAttachment(detailImage, eventNo, session, 1);

        return result;
    }
    
    
    /**
     * 이벤트 수정
     **/
    @Override
    public int updateEvent(EventDTO event, MultipartFile thumbnail, MultipartFile detailImage, HttpSession session) {
        
    	validateUser(event, session);
        validateEvent(event);

        int result = eventMapper.updateEvent(event);
        if (result != 1) throw new BadRequestException("이벤트 수정 실패");

        Long eventNo = event.getEventNo();

        // 파일 교체
        if (thumbnail != null && !thumbnail.isEmpty()) {
            deleteOldAttachment(eventNo, session, 0);
            saveAttachment(thumbnail, eventNo, session, 0);
        }

        if (detailImage != null && !detailImage.isEmpty()) {
            deleteOldAttachment(eventNo, session, 1);
            saveAttachment(detailImage, eventNo, session, 1);
        }

        return result;
    }
    
    
    /**
     * 이벤트 삭제 (상태 변경)
     **/
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

    /**
     * 카테고리 조회
     **/
    @Override
    public List<EventCategory> selectCategoryList() {
        return eventMapper.selectCategoryList();
    }

    /**
     * 내부 공통 유효성 검증
     **/
    private void validateEvent(EventDTO event) {
        if (event.getEventTitle() == null || event.getEventTitle().trim().isEmpty()
         || event.getEventContent() == null || event.getEventContent().trim().isEmpty()) {
            throw new InvalidArgumentsException("제목 또는 내용이 비어 있습니다.");
        }
    }

    private void validateUser(EventDTO event, HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null || !"Y".equals(loginMember.getManager())) {
            throw new AuthenticationException("관리자만 접근 가능합니다.");
        }

        // HTML 필터링
        event.setEventTitle(event.getEventTitle().replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
        event.setEventContent(event.getEventContent().replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
        event.setUserNo(loginMember.getUserNo());
    }
    
    
    
    //파일 업로드 / 삭제 로직
    /** 파일 저장 **/
    private void saveAttachment(MultipartFile file, Long eventNo, HttpSession session, int fileLevel) {
        String originName = file.getOriginalFilename();
        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        int rand = (int) (Math.random() * 900) + 100;
        String ext = originName.substring(originName.lastIndexOf("."));
        String prefix = (fileLevel == 0) ? "EVT_TH_" : "EVT_DE_";
        String changeName = prefix + currentTime + "_" + rand + ext;

        // 물리 경로 + 상대 경로
        ServletContext app = session.getServletContext();
        String saveDir = (fileLevel == 0)
                ? app.getRealPath("/resources/upfiles/thumb/event/")
                : app.getRealPath("/resources/upfiles/detail/event/");
        String relativePath = (fileLevel == 0)
                ? "/resources/upfiles/thumb/event/"
                : "/resources/upfiles/detail/event/";

        File dir = new File(saveDir);
        if (!dir.exists()) dir.mkdirs();

        try {
            file.transferTo(new File(saveDir, changeName));
        } catch (Exception e) {
            log.error("파일 저장 실패", e);
            throw new RuntimeException("파일 저장 실패");
        }

        EventAttachment attach = new EventAttachment();
        attach.setRefBno(eventNo);
        attach.setOriginName(originName);
        attach.setChangeName(changeName);
        attach.setFilePath(relativePath);
        attach.setFileLevel(fileLevel);

        eventMapper.insertAttachment(attach);
        log.info("파일 저장 완료: {}", attach);
    }

    /** 기존 파일 삭제 **/
    private void deleteOldAttachment(Long eventNo, HttpSession session, int fileLevel) {
        EventAttachment oldFile = eventMapper.selectAttachmentByLevel(eventNo, fileLevel);
        if (oldFile != null && oldFile.getChangeName() != null) {
            ServletContext app = session.getServletContext();
            String fullPath = app.getRealPath(oldFile.getFilePath() + oldFile.getChangeName());
            File delFile = new File(fullPath);
            if (delFile.exists() && delFile.delete()) {
                log.info("기존 파일 삭제 완료: {}", delFile.getAbsolutePath());
            }
            eventMapper.deleteAttachment(oldFile.getFileNo());
        }
    }
}
