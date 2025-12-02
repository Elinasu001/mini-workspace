<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>중고 판매 목록 | CarTalk</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/used/usedList.css">


</head>
<body>
<jsp:include page="/WEB-INF/views/include/meta.jsp" />
<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<main class="main-wrap">
		
		<div class="top-area">
		<h2>중고 판매 목록</h2>
		
		<c:if test="${ not empty sessionScope.loginMember }">
		<a href="${pageContext.request.contextPath}/used/myList" class="btn-write">내 판매목록</a>
		</c:if>
		</div>
		<!-- 차량 목록 -->
		<div class="car-list">

			<c:choose>
				<c:when test="${ not empty usedList }">
					<c:forEach var="car" items="${ usedList }">
						<a href="${pageContext.request.contextPath}/used/detail?no=${car.usedNo}&page=${pi.currentPage}&keyword=${keyword}" class="car-link">
							<div class="car-card">
								<div class="car-info">
									<div>${ car.status }| ${ car.categoryName }</div>
									<h3>${ car.usedTitle }</h3>
									<p>${ car.carYear }/ ${ car.distance }KM / ${ car.transmission }
										/ ${ car.fuelType }</p>
									<div class="meta">가격: ${ car.usedPrice }만원 | 조회수 ${ car.viewCount }
										| 등록일 ${ car.enrollDate }</div>
								</div>
								<c:choose>
  									<c:when test="${empty car.thumbnail}">
    									<img src="${pageContext.request.contextPath}/resources/upfiles/used/default.png"
							        	 alt="기본 이미지" width="120" height="80">
							  		</c:when>
							  		<c:otherwise>
							    		<div class="thumbnail-wrap ${car.status eq '판매완료' ? 'blurred' : ''}" style="position: relative;">
									    	<img src="${pageContext.request.contextPath}${car.thumbnail}" alt="썸네일 이미지" width="120" height="80">
									  	<c:if test="${car.status eq '판매완료'}">
									    	<div class="sold-overlay">판매완료</div>
									  	</c:if>
										</div>
							  		</c:otherwise>
								</c:choose>
							</div>
						</a>
					</c:forEach>
				</c:when>
				<c:otherwise>
    				<div class="no-result text-center" style="margin: 80px 0; color: #666;">
       					 <i class="bi bi-exclamation-circle" style="font-size: 2rem; color: #999;"></i><br>
        					<p style="font-size: 1.1rem; margin-top: 10px;">
            					등록된 매물이 존재하지 않습니다.
        					</p>
    				</div>
				</c:otherwise>
				</c:choose>
		</div>

		<!-- 페이징 -->
			<div class="pagination">
    			<c:if test="${pi.currentPage > 1}">
        			<a href="list?page=${pi.currentPage - 1}&keyword=${keyword}">◀</a>
   				</c:if>

    			<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
        			<a href="list?page=${p}&keyword=${keyword}" class="${p == pi.currentPage ? 'active' : ''}">${p}</a>
    			</c:forEach>

    			<c:if test="${pi.currentPage < pi.maxPage}">
        			<a href="list?page=${pi.currentPage + 1}&keyword=${keyword}">▶</a>
    			</c:if>
		</div>

		<!-- 검색 -->
		<div class="search-wrap">
		<div class="left-box">
		<c:if test="${ not empty sessionScope.loginMember }">
			<a href="${pageContext.request.contextPath}/used/insert" class="btn-write">글쓰기</a>
		</c:if>
		</div>
			<form action="${pageContext.request.contextPath}/used/list" method="get" class="search-box">
				<input type="text" name="keyword" placeholder="검색할 차량이름을 입력하세요." value="${keyword}">
				<button type="submit">검색</button>
			</form>
		</div>

	</main>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
