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
						<a href="${pageContext.request.contextPath}/used/detail?no=${car.usedNo}" class="car-link">
							<div class="car-card">
								<div class="car-info">
									<div>${ car.status }| ${ car.categoryName }</div>
									<h3>${ car.usedTitle }</h3>
									<p>${ car.carYear }/ ${ car.distance }KM / ${ car.transmission }
										/ ${ car.fuelType }</p>
									<div class="meta">가격: ${ car.usedPrice }만원 | 조회수 ${ car.viewCount }
										| 등록일 ${ car.enrollDate }</div>
								</div>
								<img src="${pageContext.request.contextPath}${car.thumbnail}" alt="썸네일 이미지" width="120" height="80">
							</div>
						</a>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<th>등록된 매물이 존재하지 않습니다.</th>
					</tr>
				</c:otherwise>
			</c:choose>
		</div>

		<!-- 페이징 -->
		<div class="pagination">
			<c:if test="${ pi.currentPage > 1}">
				<a href="list?page=${ pi.currentPage -1 }">◀</a>
			</c:if>

			<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<a href="list?page=${p}" class=${pi.currentPage}>${p}</a>
			</c:forEach>

			<c:if test="${ pi.currentPage < pi.maxPage }">
				<a href="list?page=${ pi.currentPage + 1 }">▶</a>
			</c:if>
		</div>

		<!-- 검색 -->
		<div class="search-wrap">
	<!-- 로그인이 안됐을 경우 글쓰기 기능 막음 (로그인 구현되면 활성화) 
		<c:if test="${ not empty sessionScope.loginMember }">
			<a href="${pageContext.request.contextPath}/used/insert" class="btn-write">글쓰기</a>
		</c:if>  -->
		<!-- 로그인 구현시 밑에 항목 삭제 -->
			<a href="${pageContext.request.contextPath}/used/insert" class="btn-write">글쓰기</a>

			<form action="${pageContext.request.contextPath}/used/list" method="get" class="search-box">
				<input type="text" name="keyword" placeholder="검색할 차량이름을 입력하세요." value="${keyword}">
				<button type="submit">검색</button>
			</form>
		</div>

	</main>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
