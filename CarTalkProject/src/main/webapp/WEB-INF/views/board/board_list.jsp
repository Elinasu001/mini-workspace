<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <jsp:include page="../include/meta.jsp" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>게시판 | CarTalk</title>
</head>

<style>
    .boardListPage {
        width: 1000px;
        height: 800px;
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
    
    .boardOrderBy:hover, .searchBoardOrderBy:hover{
    	background-color: rgb(214,208,156);
    	cursor : pointer;
    }

    #boardSearchArea{
        margin-top: 20px;
        margin-left: 92px;
    }
    .category {
    	width: 100px;
    }
    
    .category:hover{
    	background-color: gray;
    }
    
    .boardNo{
    	width: 50px;
    }
    
    .boardTitle{
    	width: 400px;
    }
    
    .boardWriter{
    	width: 100px;
    }
    
    .viewCount{
    	width: 80px;
    }
    
    .enrollDate{
    	width : 120px;
    }
    
    .likes{
    	width: 50px;
    }
</style>

<body>
	<jsp:include page="../include/header.jsp" />

    <div class="boardListPage">

        <table class="table boardListTable" style="margin-bottom: 25px;">
            <thead id="boardCategory">
                <tr>
                	<th class="category"><a href="/ct/board">전체 게시판</a></th>
                    <th class="category"><a href="/ct/board?category=1">자유 게시판</a></th>
                    <th class="category"><a href="/ct/board?category=2">질문 게시판</a></th>
                    <th class="category"><a href="/ct/board?category=3">정보 게시판</a></th>
                </tr>
            </thead>
        </table>


        <table class="table table-warning table-hover boardListTable">
            <thead>
            <c:choose>
            	<c:when test="${ not empty condition }">
	                <tr>
	                    <th id="boardNo&category=${ category }&condition=${ condition }&keyword=${ keyword }" class="boardNo searchBoardOrderBy">번호</th>
	                    <th id="boardTitle&category=${ category }&condition=${ condition }&keyword=${ keyword }" class="boardTitle searchBoardOrderBy">제목</th>
	                    <th id="boardWriter&category=${ category }&condition=${ condition }&keyword=${ keyword }" class="boardWriter searchBoardOrderBy">작성자</th>
	                    <th id="viewCount&category=${ category }&condition=${ condition }&keyword=${ keyword }" class="viewCount searchBoardOrderBy">조회수</th>
	                    <th id="enrollDate&category=${ category }&condition=${ condition }&keyword=${ keyword }" class="enrollDate searchBoardOrderBy">작성일</th>
	                    <th id="likes&category=${ category }&condition=${ condition }&keyword=${ keyword }" class="likes searchBoardOrderBy">좋아요수</th>
	                </tr>
	            </c:when>
	            <c:otherwise>
		            <tr>
	                    <th id="boardNo&category=${ category }" class="boardNo boardOrderBy">번호</th>
	                    <th id="boardTitle&category=${ category }" class="boardTitle boardOrderBy">제목</th>
	                    <th id="boardWriter&category=${ category }" class="boardWriter boardOrderBy">작성자</th>
	                    <th id="viewCount&category=${ category }" class="viewCount boardOrderBy">조회수</th>
	                    <th id="enrollDate&category=${ category }" class="enrollDate boardOrderBy">작성일</th>
	                    <th id="likes&category=${ category }" class="likes boardOrderBy">좋아요수</th>
	                </tr>
	            </c:otherwise>
	        </c:choose>
	            
            </thead>
            <tbody id="boardList">
            <c:choose>
            <c:when test="${ not empty map.boards }">
	            <c:forEach var="board" items="${ map.boards }">
	                <tr class="table table-light board" id=${ board.boardNo }>
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
        
        <div>
        	<c:if test="${ sessionScope.loginMember ne null }">
        	<button class="btn btn-outline-info" onclick="location.href = '/ct/board/form'">글쓰기</button>
        	</c:if>
        </div>
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
       
       
       <c:url value="http://localhost/ct/board" var="boardList">
       
    		<c:if test="${ not empty category }">
    		<c:param name="category"  value="${ category }"/>
    		</c:if>
    		<c:if test="${ not empty orderBy }">
    		<c:param name="orderBy"  value="${ orderBy }"/>
    		</c:if>
    		
       </c:url>
       
              <c:url value="http://localhost/ct/board/search" var="boardSearchedList">
       
       		<c:if test="${ not empty condition }">
    		<c:param name="condition" value="${ condition }"/>
    		</c:if>
    		<c:if test="${ not empty keyword }">
    		<c:param name="keyword"  value="${ keyword }"/>
    		</c:if>
    		<c:if test="${ not empty category }">
    		<c:param name="category"  value="${ category }"/>
    		</c:if>
    		<c:if test="${ not empty orderBy }">
    		<c:param name="orderBy"  value="${ orderBy }"/>
    		</c:if>
    		
       </c:url>
        
        <div id="boardSearchArea">
       	<c:if test="${ not empty map.boards }">
	        <c:choose>
	        	<c:when test="${ empty condition }">
		            <div class="boardPageButtons">
			            <c:if test="${ map.pi.currentPage gt 1 }">
			            <button class="btn btn-primary" onclick="location.href = '${boardList}&page=${ map.pi.currentPage - 1 }">이전</button>
			            </c:if>
			            <c:forEach var="i" begin="${ map.pi.startPage }" end="${ map.pi.endPage }">
			            <button class="btn btn-outline-primary" onclick="location.href = '${boardList}&page=${i}'">${i}</button>
			            </c:forEach>
			            <c:if test="${ map.pi.currentPage ne map.pi.maxPage }">
			            <button class="btn btn-primary" onclick="location.href = '${boardList}&page=${map.pi.currentPage + 1}'">다음</button>
			            </c:if>
		            </div>
		        </c:when>
		        <c:otherwise>
		        	<div class="boardPageButtons">
			            <c:if test="${ map.pi.currentPage gt 1 }">
			            <button class="btn btn-primary" onclick="location.href = '${boardSearchedList}&page=${ map.pi.currentPage - 1 }'">이전</button>
			            </c:if>
			            <c:forEach var="i" begin="${ map.pi.startPage }" end="${ map.pi.endPage }">
			            <button class="btn btn-outline-primary" onclick="location.href = '${boardSearchedList}&page=${i}'">${i}</button>
			            </c:forEach>
			            <c:if test="${ map.pi.currentPage ne map.pi.maxPage }">
			            <button class="btn btn-primary" onclick="location.href = '${boardSearchedList}&page=${map.pi.currentPage + 1}'">다음</button>
			            </c:if>
		            </div>
		        </c:otherwise>
	    </c:choose>
	    </c:if>
            <form action="/ct/board/search" method="get">
                <select class="form-control" name="condition" id="boardCondition">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="writer">작성자</option>
                </select>
                <input class="form-control" name="keyword" value="${ keyword }"/>
                <input type="hidden" name="category" value="${ category }">
                <button class="form-control btn btn-outline-primary" type="submit">검색</button>
            </form>
            <script>
            	$(function(){
            		
            		$('#boardCondition option[value=${condition}]').attr('selected',true);
            		
            	})
            
            </script>
            
        </div>

    </div>
    <jsp:include page="../include/footer.jsp" />
</body>

</html>