package com.kh.spring.event.model.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.event.model.dto.EventDTO;
import com.kh.spring.event.model.vo.EventAttachment;
import com.kh.spring.event.model.vo.EventCategory;
import com.kh.spring.exception.AuthenticationException;
import com.kh.spring.exception.BadRequestException;
import com.kh.spring.exception.InvalidArgumentsException;
import com.kh.spring.member.model.dto.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class EventValidator {
	
	 /** 페이지 번호 유효성 검사 (1 이상인지 확인) */
    public void validatePage(Long page) {
        if (page == null || page < 1) {
            throw new InvalidArgumentsException("잘못된 접근입니다.");
        }
    }
    
    /** 카테고리 리스트 검증 */
    public void validateCategoryList(List<EventCategory> list) {
        if (list == null || list.isEmpty()) {
            log.warn("카테고리 목록이 비어 있습니다.");
        }
    }

    /** 이벤트 번호 유효성 검사 (유효한 PK 범위인지 확인) **/
    public void validateEventNo(Long eventNo) {
        if (eventNo == null || eventNo < 1) {
            throw new InvalidArgumentsException("유효하지 않은 요청입니다.");
        }
    }
    
    /** 관리자 권한 검증 **/
    public void validateAdmin(EventDTO event, HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null || !"Y".equals(loginMember.getManager())) {
            throw new AuthenticationException("관리자만 접근 가능합니다.");
        }

        event.setEventTitle(event.getEventTitle().replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
        event.setEventContent(event.getEventContent().replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
        event.setUserNo(loginMember.getUserNo());
    }
    
    /** 관리자 권한 검증  (삭제용) */
    public void validateAdminSession(HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        
        if (loginMember == null || !"Y".equals(loginMember.getManager())) {
            throw new AuthenticationException("관리자만 접근 가능합니다.");
        }
    }

    
    
    
    /** 제목/내용 기본 검증 **/
    public void validateEvent(EventDTO event) {
        if (event.getEventTitle() == null || event.getEventTitle().trim().isEmpty()
         || event.getEventContent() == null || event.getEventContent().trim().isEmpty()) {
            throw new InvalidArgumentsException("제목 또는 내용이 비어 있습니다.");
        }
    }
    
    /** 이벤트 등록 시 파일 필수 검증 **/
    public void validateInsertFiles(MultipartFile thumbnail, MultipartFile detailImage) {
        if (thumbnail == null || thumbnail.isEmpty()) {
            throw new BadRequestException("썸네일 이미지는 필수입니다.");
        }
        if (detailImage == null || detailImage.isEmpty()) {
            throw new BadRequestException("상세 이미지는 필수입니다.");
        }
    }

    /** 이벤트 수정 시 파일 검증 **/
    public void validateUpdateFiles(List<EventAttachment> existingFiles, MultipartFile thumbnail, MultipartFile detailImage) {

        boolean hasThumb = existingFiles.stream().anyMatch(f -> f.getFileLevel() == 0);
        boolean hasDetail = existingFiles.stream().anyMatch(f -> f.getFileLevel() == 1);

        boolean newThumb = (thumbnail != null && !thumbnail.isEmpty());
        boolean newDetail = (detailImage != null && !detailImage.isEmpty());

        if ((!hasThumb && !newThumb) || (!hasDetail && !newDetail)) {
            throw new BadRequestException("썸네일과 상세 이미지는 최소 1개 이상 필요합니다.");
        }
    }
	
}
