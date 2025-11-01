<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>게시판 | CarTalk</title>
</head>

<style>
    .boardListPage {
        width: 1000px;
        height: 600px;
        margin: auto;
        align-content: center;
    }

    .boardPageButtons{
        display: flex;
        justify-content: center;
    }

    .boardListTable,
    tr {
        margin: auto;
        text-align: center;
    }

    .boardListTable,
    .boardListTable>*>*>th,
    .boardListTable>*>*>td {
        border: 1px solid black;
    }
    
    .boardOrderBy:hover, .searchBoardOrderBy:hover{
    	background-color: gray;
    	cursor : pointer;
    }

    .boardListTable {
        border-collapse: collapse;
    }

    #boardList>*:hover{
        background-color: lightblue;
        cursor:pointer;
    }

    #boardSearchArea{
        margin-top: 20px;
        margin-left: 92px;
    }
</style>

<body>
    <div class="boardListPage">

        <table class="boardListTable" style="margin-bottom: 25px;">
            <thead id="boardCategory">
                <tr>
                	<th width="100"><a href="/ct/board">전체 게시판</a></th>
                    <th width="100"><a href="/ct/board?category=1">자유 게시판</a></th>
                    <th width="100"><a href="/ct/board?category=2">질문 게시판</a></th>
                    <th width="100"><a href="/ct/board?category=3">정보 게시판</a></th>
                </tr>
            </thead>
        </table>

        <table class="boardListTable">
            <thead>
            <c:choose>
            	<c:when test="${ not empty condition }">
	                <tr style="border: 1px solid gray;">
	                    <th width="50" id="boardNo&category=${ category }&condition=${ condition }&keyword=${ keyword }" class="searchBoardOrderBy">번호</th>
	                    <th width="400" id="boardTitle&category=${ category }&condition=${ condition }&keyword=${ keyword }" class="searchBoardOrderBy">제목</th>
	                    <th width="100" id="boardWriter&category=${ category }&condition=${ condition }&keyword=${ keyword }" class="searchBoardOrderBy">작성자</th>
	                    <th width="80" id="viewCount&category=${ category }&condition=${ condition }&keyword=${ keyword }" class="searchBoardOrderBy">조회수</th>
	                    <th width="120" id="enrollDate&category=${ category }&condition=${ condition }&keyword=${ keyword }" class="searchBoardOrderBy">작성일</th>
	                    <th width="50" id="likes&category=${ category }&condition=${ condition }&keyword=${ keyword }" class="searchBoardOrderBy">좋아요수</th>
	                </tr>
	            </c:when>
	            <c:otherwise>
		            <tr style="border: 1px solid gray;">
	                    <th width="50" id="boardNo&category=${ category }" class="boardOrderBy">번호</th>
	                    <th width="400" id="boardTitle&category=${ category }" class="boardOrderBy">제목</th>
	                    <th width="100" id="boardWriter&category=${ category }" class="boardOrderBy">작성자</th>
	                    <th width="80" id="viewCount&category=${ category }" class="boardOrderBy">조회수</th>
	                    <th width="120" id="enrollDate&category=${ category }" class="boardOrderBy">작성일</th>
	                    <th width="50" id="likes&category=${ category }" class="boardOrderBy">좋아요수</th>
	                </tr>
	            </c:otherwise>
	        </c:choose>
	            
            </thead>
            <tbody id="boardList">
            <c:choose>
            <c:when test="${ not empty map.boards }">
	            <c:forEach var="board" items="${ map.boards }">
	                <tr class="board" id="${ board.boardNo }">
	                    <td>${ board.boardNo }</td>
	                    <td>${ board.boardTitle }</td>
	                    <td>${ board.boardWriter }</td>
	                    <td>${ board.viewCount }</td> 
	                    <td>${ board.enrollDate }</td> 
	                    <td>${ board.likes }</td>
	                </tr>
	            </c:forEach>
	        </c:when>
	        <c:otherwise>
	        	<tr><td colspan="6">게시글이 없습니다.</td></tr>
	        </c:otherwise>
	        </c:choose>
            </tbody>
        </table>
        
        <script>
        	$('.boardOrderBy').click(e => {
        		
        		const orderBy = e.currentTarget.id;
        		console.log(e);
        		location.href = `/ct/board?page=1&orderBy=\${orderBy}`
        		
        	})
        	
        	$('.searchBoardOrderBy').click(e => {
        		
        		const orderBy = e.currentTarget.id;
        		console.log(e);
        		location.href = `/ct/board/search?page=1&orderBy=\${orderBy}`
        		
        	})
        
        	$('.board').click(e => {
        		
        		//console.log(e);
        		const boardNo = e.currentTarget.id;
        		location.href = `/ct/board/\${boardNo}`;
        		
        	})
        </script>
        
        
        <div id="boardSearchArea">
       	<c:if test="${ not empty map.boards }">
	        <c:choose>
	        	<c:when test="${ empty condition }">
		            <div class="boardPageButtons">
			            <c:if test="${ map.pi.currentPage gt 1 }">
			            <button onclick="location.href = 'board?page=${ map.pi.currentPage - 1 }&condition=${ condition }&keyword=${ keyword }&category=${category}&orderBy=${ orderBy }'">이전</button>
			            </c:if>
			            <c:forEach var="i" begin="${ map.pi.startPage }" end="${ map.pi.endPage }">
			            <button onclick="location.href = 'board?page=${i}&condition=${ condition }&keyword=${ keyword }&category=${category}&orderBy=${ orderBy }'">${i}</button>
			            </c:forEach>
			            <c:if test="${ map.pi.currentPage ne map.pi.maxPage }">
			            <button onclick="location.href = 'board?page=${map.pi.currentPage + 1}&condition=${ condition }&keyword=${ keyword }&category=${category}&orderBy=${ orderBy }'">다음</button>
			            </c:if>
		            </div>
		        </c:when>
		        <c:otherwise>
		        	<div class="boardPageButtons">
			            <c:if test="${ map.pi.currentPage gt 1 }">
			            <button onclick="location.href = '/ct/board/search?page=${ map.pi.currentPage - 1 }&category=${category}&condition=${ condition }&keyword=${ keyword }&orderBy=${ orderBy }'">이전</button>
			            </c:if>
			            <c:forEach var="i" begin="${ map.pi.startPage }" end="${ map.pi.endPage }">
			            <button onclick="location.href = '/ct/board/search?page=${i}&category=${category}&condition=${ condition }&keyword=${ keyword }&orderBy=${ orderBy }'">${i}</button>
			            </c:forEach>
			            <c:if test="${ map.pi.currentPage ne map.pi.maxPage }">
			            <button onclick="location.href = '/ct/board/search?page=${map.pi.currentPage + 1}&category=${category}&condition=${ condition }&keyword=${ keyword }&orderBy=${ orderBy }'">다음</button>
			            </c:if>
		            </div>
		        </c:otherwise>
	    </c:choose>
	    </c:if>
            <form action="/ct/board/search" method="get">
                <select name="condition" id="boardCondition">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="writer">작성자</option>
                </select>
                <input name="keyword" value="${ keyword }"/>
                <input type="hidden" name="category" value="${ category }">
                <button type="submit">검색</button>
            </form>
            <script>
            	$(function(){
            		
            		$('#boardCondition option[value=${condition}]').attr('selected',true);
            		
            	})
            
            </script>
            
        </div>

    </div>
</body>

</html>