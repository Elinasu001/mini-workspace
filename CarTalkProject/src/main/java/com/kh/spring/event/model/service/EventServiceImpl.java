package com.kh.spring.event.model.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.event.model.dto.EventAttachmentDTO;
import com.kh.spring.event.model.dto.EventDTO;
import com.kh.spring.event.model.mapper.EventMapper;
import com.kh.spring.exception.AuthenticationException;
import com.kh.spring.exception.BadRequestException;
import com.kh.spring.exception.InvalidArgumentsException;
import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.util.PageInfo;
import com.kh.spring.util.Pagination;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
class EventServiceImpl implements EventService {
	
	private final EventMapper eventMapper;
	private final Pagination pagination;
	/*
	@Override
	public Map<String, Object> selectEventList(Long page){
		
		Map<String, Object> map = new HashMap();
		List<EventDTO> events = new ArrayList();
		
		// 유효성검증
		if(page < 1) {
			throw new InvalidArgumentsException("잘못된 접근입니다.");
		}
		
		// 조회수
		int viewCount = eventMapper.selectEventCount();
		
		// 확인
		log.info("총 게시글 개수 : {}", viewCount);
		
		// 보여줄 게시글 수"와 "페이지 묶음 수"
		PageInfo pi = pagination.getPageInfo(viewCount, page.intValue(), 6, 6);
		
		// 게시글 있을 경우
		if(viewCount > 0) {
			RowBounds rb = new RowBounds((page.intValue() - 1) * 6, 6);
			events = eventMapper.selectEventList(rb);
		}
		
		map.put("pi", pi);
		map.put("events", events);
		
		return map;
		
	}
	*/
	
	// 진행중인 이벤트 _ AJAX
	@Override
	public Map<String, Object> selectOngoing(Long page) {
	    Map<String, Object> map = new HashMap<>();
	    List<EventDTO> events = new ArrayList<>();

	    if (page < 1) {
	        throw new InvalidArgumentsException("잘못된 접근입니다.");
	    }

	    int viewCount = eventMapper.selectOngoingCount(); // 진행중인 이벤트 개수
	    PageInfo pi = pagination.getPageInfo(viewCount, page.intValue(), 6, 6);

	    if (viewCount > 0) {
	        RowBounds rb = new RowBounds((page.intValue() - 1) * 6, 6);
	        events = eventMapper.selectOngoing(rb);
	    }
	   
	    map.put("pi", pi);
	    map.put("events", events);

	    return map;
	}
	
	// 종료된 이벤트 _ AJAX
	@Override
	public Map<String, Object> selectEnded(Long page) {
	    Map<String, Object> map = new HashMap<>();
	    List<EventDTO> events = new ArrayList<>();

	    if (page < 1) {
	        throw new InvalidArgumentsException("잘못된 접근입니다.");
	    }

	    int viewCount = eventMapper.selectEndedCount(); // 종료된 이벤트 개수
	    PageInfo pi = pagination.getPageInfo(viewCount, page.intValue(), 6, 6);

	    if (viewCount > 0) {
	        RowBounds rb = new RowBounds((page.intValue() - 1) * 6, 6);
	        events = eventMapper.selectEnded(rb);
	    }
	    log.info("종료된 게시글 개수: {}", viewCount);
	    map.put("pi", pi);
	    map.put("events", events);

	    return map;
	}
	

	// 이벤트 게시글 상세조회 (+ 조회수 증가)
	@Override 
	public EventDTO selectByEventNo(Long eventNo) {
		
		// 예외처리
		if(eventNo == null || eventNo < 1 ) {
			throw new InvalidArgumentsException("유효하지 않은 요청입니다.");
		}
		
		// 최신 갱신된 데이터 조회
		int result = eventMapper.increaseCount(eventNo);
		// 예외처리
		if(result != 1) {
			throw new BadRequestException("조회수 증가 중 오류가 발생했습니다.");
		}
		
		// 상세조회
		EventDTO event = eventMapper.selectByEventNo(eventNo);
		if (event == null) {
            throw new BadRequestException("존재하지 않는 이벤트입니다.");
        }
		
		return event;
	}
	
	
	// 1. 권한 검증
	private void validateUser(EventDTO event, HttpSession session) {

		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

	    // 로그인 안 되어 있거나, 작성자와 로그인 사용자가 다르면 예외
	    if (loginMember == null || !"Y".equals(loginMember.getManager())) {
	        throw new AuthenticationException("관리자만 접근 가능합니다.");
	    }

	    // HTML 태그 필터링
	    String eventTitle = event.getEventTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	    String eventContent = event.getEventContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;");

	    // 욕설 필터링
	    if (event.getEventTitle().contains("이승철바보")) {
	        eventTitle = event.getEventTitle().replaceAll("이승철바보", "글쓴사람바보");
	    }

	    event.setEventTitle(eventTitle);
	    event.setEventContent(eventContent);
	    event.setUserNo(loginMember.getUserNo());
	}

	
	
	
	// 이벤트 게시글 등록하기
	@Override
	public int insertEvent(EventDTO event, MultipartFile thumbnail, MultipartFile detailImage, HttpSession session) {

	    // 1️⃣ 권한검증
	    validateUser(event, session);

	    // 2️⃣ 유효성검증
	    if (event.getEventTitle() == null || event.getEventTitle().trim().isEmpty()
	            || event.getEventContent() == null || event.getEventContent().trim().isEmpty()) {
	        throw new InvalidArgumentsException("제목 또는 내용이 비어 있습니다.");
	    }

	    // 3️⃣ 이벤트 등록 (selectKey로 eventNo 자동 주입)
	    int result = eventMapper.insertEvent(event);
	    if (result != 1) throw new BadRequestException("이벤트 등록 실패");

	    int eventNo = event.getEventNo().intValue(); // 자동 세팅된 시퀀스 값 사용

	    // 4️⃣ 파일 업로드
	    if (thumbnail != null && !thumbnail.isEmpty()) {
	        saveAttachment(thumbnail, eventNo, session, 0);
	    }
	    if (detailImage != null && !detailImage.isEmpty()) {
	        saveAttachment(detailImage, eventNo, session, 1);
	    }

	    return result;
	}


   

    /** 파일 저장 + DB 등록 */
    private void saveAttachment(MultipartFile file, int eventNo, HttpSession session, int fileLevel) {

        String originName = file.getOriginalFilename();
        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        int rand = (int) (Math.random() * 900) + 100;
        String ext = originName.substring(originName.lastIndexOf("."));
        String changeName = "EVT_" + currentTime + "_" + rand + ext;

        ServletContext application = session.getServletContext();
        String saveDir = (fileLevel == 0)
                ? application.getRealPath("/resources/upfiles/thumb/event/")
                : application.getRealPath("/resources/upfiles/detail/event/");

        File dir = new File(saveDir);
        if (!dir.exists()) dir.mkdirs();

        try {
            file.transferTo(new File(saveDir + changeName));
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("파일 저장 실패");
        }

        EventAttachmentDTO attach = new EventAttachmentDTO();
        attach.setRefBno(eventNo);
        attach.setOriginName(originName);
        attach.setChangeName(changeName);
        attach.setFilePath(saveDir);
        attach.setFileLevel(fileLevel);

        eventMapper.insertEventAttachment(attach);
    }
	
	
	
}
