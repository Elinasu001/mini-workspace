package com.kh.spring.event.model.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.event.model.dto.EventDTO;
import com.kh.spring.event.model.mapper.EventMapper;
import com.kh.spring.event.model.vo.EventAttachment;
import com.kh.spring.util.Pagination;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class EventFileHandler {
	
	public final EventMapper eventMapper;
	
	/** 
     * DB 파일 목록 : DTO 썸네일/상세 이미지 필드 매핑
     * (fileLevel 0=썸네일, 1=상세)
     */
    public void setEventFileData(EventDTO event) {
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
    public void replaceAttachment(List<EventAttachment> attachments,
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
    public void saveAttachment(MultipartFile file, Long eventNo, HttpSession session, int fileLevel) {

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


    /** 기존 파일 삭제 (물리 저장 및 DB 상태 변경)_ (UPDATE용 단일삭제)**/
    public void deleteOldAttachment(Long fileNo, HttpSession session) {
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
    
    
    /** 다중 파일 삭제 (단일 삭제 재사용)_  (DELETE 용) **/
    public void deleteAttachments(List<EventAttachment> files, HttpSession session) {
        if (files == null || files.isEmpty()) {
            log.info("삭제할 파일 없음");
            return;
        }

        for (EventAttachment file : files) {
            ServletContext app = session.getServletContext();
            String fullPath = app.getRealPath(file.getFilePath() + file.getChangeName());

            File f = new File(fullPath);
            if (f.exists() && f.delete()) {
                log.info("파일 삭제: {}", fullPath);
            } else {
                log.warn("삭제 실패/없음: {}", fullPath);
            }

            eventMapper.deleteAttachment(file.getFileNo());
        }
    }
	
}
