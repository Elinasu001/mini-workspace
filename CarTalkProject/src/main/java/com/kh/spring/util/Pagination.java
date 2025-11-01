package com.kh.spring.util;

import org.springframework.stereotype.Component;

/**
 * listCount : 총 게시글 수
 * currentPage : 현재 페이지
 * boardLimit : 한 페이지당 보여줄 글 수
 * pageLimit : 한 번에 보여줄 페이지 번호 개수
 */
@Component
public class Pagination {			

    public PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
        
        // 총 페이지 수 (올림)
        int maxPage = (int)Math.ceil((double)listCount / boardLimit);
        
        // 시작 페이지 번호
        int startPage = ((currentPage - 1) / pageLimit) * pageLimit + 1;
        
        // 끝 페이지 번호
        int endPage = startPage + pageLimit - 1;
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        
        // PageInfo 객체 리턴
        return new PageInfo(listCount, currentPage, boardLimit, pageLimit, maxPage, startPage, endPage);
    }
}
