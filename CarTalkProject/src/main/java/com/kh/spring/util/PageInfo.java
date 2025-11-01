package com.kh.spring.util;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter 
@Setter 
@NoArgsConstructor 
@AllArgsConstructor 
@ToString
public class PageInfo {
    
    private int listCount;    // 총 게시글 수
    private int currentPage;  // 현재 페이지
    private int boardLimit;   // 한 페이지당 글 수
    private int pageLimit;    // 페이지 번호 개수

    private int maxPage;      // 총 페이지 수
    private int startPage;    // 시작 페이지 번호
    private int endPage;      // 끝 페이지 번호
}
