<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 판매 목록 | CarTalk</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/used/myUsedList.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
	crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/meta.jsp" />
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<main class="main-wrap">
		<h2>내 판매 목록</h2>

		<div class="filter">
			<a href="?status=전체" class="${param.status eq '전체' or empty param.status ? 'active' : ''}">전체</a>
			<a href="?status=판매중" class="${param.status eq '판매중' ? 'active' : ''}">판매중</a>
			<a href="?status=예약중" class="${param.status eq '예약중' ? 'active' : ''}">예약중</a>
			<a href="?status=판매완료" class="${param.status eq '판매완료' ? 'active' : ''}">판매완료</a>
		</div>

		<div class="car-list">
			<c:choose>
				<c:when test="${not empty usedList }">
					<c:forEach var="car" items="${usedList}">
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
								<c:choose>
							  	<c:when test="${empty car.thumbnail}">
							    	<img src="${pageContext.request.contextPath}/resources/upfiles/used/default.png"
							         alt="기본 이미지" width="120" height="80">
							  	</c:when>
							  	<c:otherwise>
							    	<img src="${pageContext.request.contextPath}${car.thumbnail}"
							         alt="썸네일 이미지" width="120" height="80">
							  	</c:otherwise>
								</c:choose>
							</div>
						</a>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p>등록된 판매글이 없습니다.</p>
				</c:otherwise>
			</c:choose>
		</div>
		
		<!-- 페이징 -->
		<div class="pagination">
			<c:if test="${ pi.currentPage > 1}">
				<a href="myList?page=${ pi.currentPage -1 }">◀</a>
			</c:if>

			<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<a href="myList?page=${p}" class=${pi.currentPage}>${p}</a>
			</c:forEach>

			<c:if test="${ pi.currentPage < pi.maxPage }">
				<a href="myList?page=${ pi.currentPage + 1 }">▶</a>
			</c:if>
		</div>
		
		<div class="btn-group">
   		 	<button type="button" class="btn btn-outline-info" onclick="location.href='${pageContext.request.contextPath}/used/list'">목록으로</button>
		</div>
	</main>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js"
		integrity="sha384-G/EV+4j2dNv+tEPo3++6LCgdCROaejBqfUeNjuKAiuXbjrxilcCdDz6ZAVfHWe1Y"
		crossorigin="anonymous"></script>

</body>
</html>
