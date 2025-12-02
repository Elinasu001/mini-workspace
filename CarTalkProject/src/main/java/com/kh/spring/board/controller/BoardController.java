package com.kh.spring.board.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.board.model.dto.BoardDTO;
import com.kh.spring.board.model.service.BoardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("board")
public class BoardController {
	
	private final BoardService boardService;
	
	@GetMapping
	public String selectBoardList(HttpSession session,@RequestParam(name="page", defaultValue = "1") Long pageNo,@RequestParam(name="category", defaultValue="0") Long category,@RequestParam(name="orderBy", defaultValue="ENROLL_DATE") String orderBy,Model model){
		
		Map<String, Object> searchBy = new HashMap();
		searchBy.put("orderBy", orderBy);
		searchBy.put("category", category);
		
		Map<String, Object> map = boardService.selectBoardList(pageNo,searchBy);
		model.addAttribute("map", map);
		model.addAttribute("category", category);
		model.addAttribute("orderBy", orderBy);
		
		return "board/board_list";
	}
	
	@GetMapping("/search")
	public String selectBoardListByKeyword(@RequestParam(name="page", defaultValue = "1") Long pageNo
										  ,@RequestParam(name="orderBy", defaultValue="ENROLL_DATE") String orderBy
										  ,@RequestParam(name="category", defaultValue="0") String category
										  ,@RequestParam(name="condition") String condition
										  ,@RequestParam(name="keyword") String keyword
										  ,Model model) {
		
		Map<String, Object> searchBy = new HashMap();
		
		searchBy.put("condition", condition);
		searchBy.put("keyword", keyword);
		searchBy.put("orderBy", orderBy);
		searchBy.put("category", category);
		
		Map<String, Object> map = boardService.selectBoardListByKeyword(pageNo, searchBy);
		
		model.addAttribute("map", map);
		model.addAttribute("category", category);
		model.addAttribute("keyword",keyword);
		model.addAttribute("condition",condition);
		model.addAttribute("orderBy", orderBy);
		model.addAttribute("pageNo", pageNo);
		
		return "board/board_list";
		
	}
	
	@GetMapping("/{boardNo}")
	public String selectByBoardNo(@PathVariable(name="boardNo") Long boardNo, Model model) {
		
		BoardDTO board = boardService.selectByBoardNo(boardNo);
		
		List<Long> boardNums = boardService.selectAllBoard();
		
		int boardIndex = boardNums.indexOf(boardNo);
		int boardNumSize = boardNums.size();
		
		model.addAttribute("board",board);
		model.addAttribute("boardNums", boardNums);
		model.addAttribute("boardIndex", boardIndex);
		model.addAttribute("boardNumSize", boardNumSize);
		
		return "board/board_detail";
	}
	
	@GetMapping("/form")
	public String toEnrollForm() {
		return "board/enroll_form";
	}
	
	@PostMapping
	public String insertBoard(BoardDTO board, MultipartFile boardUpfile, HttpSession session) {
		
		System.out.println(board);
		
		boardService.insertBoard(board, boardUpfile, session);
		
		return "redirect:board";
	}
	
	@GetMapping("/{boardNo}/edit")
	public String toUpdateForm(@PathVariable(name="boardNo")Long boardNo, Model model) {
		
		BoardDTO board = boardService.selectByBoardNo(boardNo);
		
		model.addAttribute("board",board);
		
		
		return "board/update_form";
	}
	
	@PostMapping("/{boardNo}/update")
	public String updateBoard(@PathVariable(name="boardNo")Long boardNo, BoardDTO board, MultipartFile boardUpfile, HttpSession session) {
		
		BoardDTO currBoard = boardService.selectByBoardNo(boardNo);
		
		board.setBoardNo(boardNo);
		
		board.setBoardWriter(currBoard.getBoardWriter());
		
		board.setAttachment(currBoard.getAttachment());
		
		System.out.println(board);
		
		boardService.updateBoard(board, boardUpfile, session);
		
		return "redirect:/board/"+boardNo;
		
	}
	
	@GetMapping("/{boardNo}/delete")
	public String deleteBoard(@PathVariable(name="boardNo")Long boardNo, HttpSession session) {
		
		BoardDTO board = boardService.selectByBoardNo(boardNo);
		
		boardService.deleteBoard(board , session);
		
		return "redirect:/board";
	}
	

	
}
