package com.kh.spring.board.model.service;

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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.board.model.dto.AttachmentDTO;
import com.kh.spring.board.model.dto.BoardDTO;
import com.kh.spring.board.model.dto.LikeDTO;
import com.kh.spring.board.model.dto.ReplyDTO;
import com.kh.spring.board.model.mapper.BoardMapper;
import com.kh.spring.exception.BadRequestException;
import com.kh.spring.exception.BoardSaveFailedException;
import com.kh.spring.exception.InvalidAttachmentException;
import com.kh.spring.exception.PageNotFoundException;
import com.kh.spring.member.model.dto.MemberDTO;
import com.kh.spring.util.PageInfo;
import com.kh.spring.util.Pagination;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

	private final BoardMapper boardMapper;
	private final Pagination pagination;
	private final BoardValidator boardValidator;

	/**
	 * 페이지 번호를 인자값으로 전달받아서 
	 * 화면에 표시할 List<Board>와 
	 * 페이지 정보가 담긴 PageInfo를 Map에 담아서 반환하는 메서드
	 */
	@Override
	public Map<String, Object> selectBoardList(Long pageNo, Map<String, Object> searchBy) {
		Map<String, Object> map = new HashMap();
		List<BoardDTO> boards = new ArrayList();
		
		// 페이지 번호가 1보다 낮은 경우 예외 발생
		boardValidator.validateSelectBoard(pageNo);
		
		int count = boardMapper.selectBoardCount(searchBy);
		// 게시글이 존재하지 않을 경우 수행하지 않음
		if(count > 0) {
			//페이징 처리용 RowBounds
			RowBounds rb = new RowBounds((pageNo.intValue() -1)*10, 10);
			boards = boardMapper.selectBoardList(rb, searchBy);
		}
		
		PageInfo pi = pagination.getPageInfo(count, pageNo.intValue(), 10, 10);
		
		map.put("boards", boards);
		map.put("pi", pi);
		
		return map;
	}
	
	public Map<String, Object> selectBoardListByKeyword(Long pageNo, Map<String, Object> searchBy) {
		Map<String, Object> map = new HashMap();
		List<BoardDTO> boards = new ArrayList();
		
		// 페이지 번호가 1보다 낮은 경우 예외 발생
		boardValidator.validateSelectBoard(pageNo);
		
		int count = boardMapper.selectBoardCountByKeyword(searchBy);
		// 게시글이 존재하지 않을 경우 수행하지 않음
		if(count > 0) {
			//페이징 처리용 클래스
			RowBounds rb = new RowBounds((pageNo.intValue() -1)*10, 10);
			boards = boardMapper.selectBoardListByKeyword(rb, searchBy);
		}
		
		PageInfo pi = pagination.getPageInfo(count, pageNo.intValue(), 10, 10);
		
		map.put("boards", boards);
		map.put("pi", pi);
		
		return map;
	}
	
	

	@Override
	public BoardDTO selectByBoardNo(Long boardNo) {
		
		// 보드 번호가 1보다 낮은 경우 예외 발생
		boardValidator.validateSelectBoard(boardNo);
		
		int count = boardMapper.increaseBoardCount(boardNo);
		
		BoardDTO board = boardMapper.selectByBoardNo(boardNo);
		
		// 조회된 값이 없는 경우 예외 발생
		boardValidator.validateBoard(board);
		
		return board;
		
	}
	
	private Map<String, String> setAttachmentNamePath(MultipartFile boardUpfile, HttpSession session){
		
		Map<String, String> saveAt = new HashMap();
		
		StringBuilder sb = new StringBuilder();
		sb.append("CarTalk_");
		String CurrentDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
		sb.append(CurrentDay);
		sb.append("_");
		int randNum = (int)(Math.random() * 9000)+1000;
		sb.append(randNum);
		String ext = boardUpfile.getOriginalFilename().substring(boardUpfile.getOriginalFilename().lastIndexOf(".")); 
		sb.append(ext);
		
		ServletContext application = session.getServletContext();
		String savePath = application.getRealPath("/resources/upfiles/board/");
		
		saveAt.put("changeName", sb.toString());
		saveAt.put("savePath", savePath);
		
		return saveAt;
	}
	
	private void insertAttachment(BoardDTO board,MultipartFile boardUpfile,HttpSession session) {

		AttachmentDTO at = new AttachmentDTO();
		
		Map<String, String> saveAt = setAttachmentNamePath(boardUpfile, session);
		
		
		try {
			boardUpfile.transferTo(new File(saveAt.get("savePath") + saveAt.get("changeName")));
		} catch (Exception e) {
			throw new InvalidAttachmentException("서버에 첨부파일 추가 실패.");
		}

		at.setOriginName(boardUpfile.getOriginalFilename());
		at.setChangeName(saveAt.get("changeName"));
		at.setFilePath("/ct/resources/upfiles/board");
		
		at.setRefBno(board.getBoardNo());
		
		int atResult = boardMapper.insertAttachment(at);
		
		// 첨부파일 첨부 실패 시 예외 발생
		if(atResult != 1) {
			throw new InvalidAttachmentException("첨부파일 추가에 실패했습니다.");
		}
		
	}
	
	// 게시판 작성
	@Transactional
	@Override
	public void insertBoard(BoardDTO board, MultipartFile boardUpfile, HttpSession session) {
		
		MemberDTO member = boardValidator.validateLogin(session);
		
		int userNo = ((MemberDTO)session.getAttribute("loginMember")).getUserNo();
		
		board.setBoardWriter(String.valueOf(userNo));
		
		int boardResult = boardMapper.insertBoard(board);
		
		// 게시글 작성 실패 시 예외 발생
		if(boardResult != 1) {
			throw new BoardSaveFailedException("게시글 작성에 실패했습니다.");
		}
		
		//첨부파일 존재 시 첨부파일 업로드
		if(!boardUpfile.getOriginalFilename().isEmpty()) {
			insertAttachment(board, boardUpfile, session);
		}
		
	}

	
	// 게시판 수정
	@Transactional
	@Override
	public void updateBoard(BoardDTO board, MultipartFile boardUpfile, HttpSession session) {

		AttachmentDTO at = null;
		String boardWriter = board.getBoardWriter();
		MemberDTO loginMember = ((MemberDTO)session.getAttribute("loginMember"));
		
		// 로그인하지 않았거나 && 로그인한 회원과 수정중인 회원이 같지 않은 경우
		boardValidator.validateAuthorization(boardWriter, loginMember);
		
		int boardResult = boardMapper.updateBoard(board);
		
		// 게시판 수정 실패 시 예외처리
		if(boardResult != 1) {
			throw new BoardSaveFailedException("게시글 변경에 실패했습니다.");
		}
		
		if(!boardUpfile.getOriginalFilename().isEmpty()) { //새 첨부파일 있을 시
			
			at = new AttachmentDTO();
			if(board.getAttachment() != null) { // 기존 첨부파일 존재 시 변경
				
				Map<String, String> saveAt = setAttachmentNamePath(boardUpfile, session);
				
				at.setFileNo(board.getAttachment().getFileNo()); // SQL문 식별용 PK
				at.setOriginName(boardUpfile.getOriginalFilename());
			    at.setChangeName(saveAt.get("changeName"));
				// 경로는 변경 X
			    
			    // 새 파일 추가
				try {
					boardUpfile.transferTo(new File(saveAt.get("savePath") + saveAt.get("changeName")));
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			    // 기존 파일 삭제
			    new File(saveAt.get("savePath")+"/"+board.getAttachment().getChangeName()).delete();
				
				boardMapper.updateAttachment(at);
				
			} else { //기존 첨부파일 없을 시 추가
				insertAttachment(board,boardUpfile, session);
			}
		}
	}

	@Transactional
	@Override
	public void deleteBoard(BoardDTO board, HttpSession session) {

		//System.out.println(board);
		
		//유효성 검증(예외 처리)
		String boardWriter = board.getBoardWriter();
		MemberDTO loginMember = ((MemberDTO)session.getAttribute("loginMember"));

		// 로그인한 사용자와 같은 지 검증
		boardValidator.validateAuthorization(boardWriter, loginMember);

		int userNo = loginMember.getUserNo();
		
		board.setBoardWriter(String.valueOf(userNo));
		
		boardMapper.deleteBoard(board);
		
		// 게시글 삭제 시 첨부파일이 존재하면 같이 삭제
		if(board.getAttachment() != null) {
			boardMapper.deleteAttachment(board.getAttachment());
		}
		
		// 게시글 삭제 시 댓글이 존재하면 같이 삭제
		if(!board.getReplies().isEmpty()) {
			// 댓글이 여러 개일 수 있으니 반복문으로 순회하면서 삭제
			for(ReplyDTO reply : board.getReplies()) {
				reply.setRefBno(board.getBoardNo());
				boardMapper.deleteReply(reply);
			}
		}
		
	}

	@Override
	public String insertLikes(Long boardNo, HttpSession session) {
		
		// 로그인 한 상태인지 검증
		MemberDTO member = boardValidator.validateLogin(session);
		
		int userNo = ((MemberDTO)session.getAttribute("loginMember")).getUserNo();
		
		LikeDTO likeNums = new LikeDTO(userNo, boardNo);
		
		// 좋아요 테이블을 먼저 조회해서 값이 존재하는 지 확인
		LikeDTO likes = boardMapper.selectLikes(likeNums);
		
		if(likes == null) {
			// 존재하지 않을 경우 - 좋아요를 처음 누른 상태
			int pushResult = boardMapper.insertLikes(likeNums);
			
			if(pushResult != 1) { // 좋아요 추가 (INSERT) 실패 시 예외처리
				throw new BadRequestException("기능 수행중 문제가 발생했습니다.");
			}
			
			
			return "success";
		} 
		
		//존재할 경우 - 이미 좋아요를 누른 상태 - 좋아요 취소(테이블 삭제)
		int popResult = boardMapper.deleteLikes(likeNums);
		
		if(popResult != 1) { // 좋아요 삭제 (DELETE) 실패 시 예외처리
			throw new BadRequestException("취소에 실패했습니다.");
		}
		
		return "cancle";
	}

	@Override
	public String insertReply(ReplyDTO reply, HttpSession session) {
		
		
		MemberDTO member = boardValidator.validateLogin(session);

		// 유효 값 검증 (댓글이 null이거나 공백문자밖에 없을 경우)
		boardValidator.validateReply(reply);
		
		reply.setReplyWriter(String.valueOf(member.getUserNo()));
		
		int result = boardMapper.insertReply(reply);
		
		if(result != 1) { // 댓글 작성 실패 시
			throw new BadRequestException("댓글 작성에 실패했습니다.");
		}
		
		
		return "success";
	}

	@Override
	public String updateReply(ReplyDTO reply, HttpSession session) {
		
		// 로그인 검증
		MemberDTO member = boardValidator.validateLogin(session);

		// 유효 값 검증 (댓글이 null이거나 공백문자밖에 없을 경우)
		boardValidator.validateReply(reply);
		
		int result = boardMapper.updateReply(reply);
		
		if(result != 1) {
			throw new BadRequestException("댓글 변경에 실패했습니다.");
		}
		
		
		return "success";
	}


	
	@Override
	public String deleteReply(ReplyDTO reply, HttpSession session) {
		
		boardValidator.validateLogin(session);
		
		int result = boardMapper.deleteReply(reply);
		
		if(result != 1) {
			throw new BadRequestException("댓글 삭제에 실패했습니다.");
		}
		
		
		return "success";
	}

	// 이전 / 다음 글 기능 구현용 전체 조회
	@Override
	public List<Long> selectAllBoard() {
		
		return boardMapper.selectAllBoard();
		
	}
	
}
