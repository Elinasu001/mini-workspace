<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사진게시판 | CarTalk</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/used/usedList.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<main class="main-wrap">
		<h2>사진 게시판</h2>

		<!-- 게시판 목록 -->
		<div class="car-list">
			
			<!-- 양식 예시 
			<div class="car-card">
				<div class="car-info">
					<div>리뷰/사진</div>
					<h3>팰리세이드 리뷰</h3>
					<p>이차 진짜 좋음</p>
					<div class="meta">리뷰쟁이 | 댓글 5 | 25.10.11</div>
				</div>
				<img src="resources/upfiles/gallery/car01.png">
			</div>
			<div class="car-card">
				<div class="car-info">
					<div>(category)</div>
					<h3>(title)</h3>
					<p>(content)</p>
					<div class="meta">(nickname) | 댓글 (replyCount) | (enrollDate)</div>
				</div>
				<img src="">
			</div>-->
			<!-- 실제 데이터 -->
			
			<script>
				function toDetail(GalleryNo){
					location.href`gallery/\${galleryNo}`;
				}
			</script>
			<c:choose>
			<c:when test="${ not empty map.gallerys }">
				<c:forEach var="gallery" items="${ map.gallerys }">
					<div class="car-card" onclick="toDetail(${ gallery.galleryNo })">
						<div class="car-info">
							<div>${ gallery.categoryName }</div>
							<h3>${ gallery.galleryTitle }</h3>
							<p>${ gallery.thumnailPath }</p>
							<div class="meta">${ gallery.nickname } | 댓글 (replyCount) | ${ gallery.enrollDate }</div>
						</div>
						<img src="${ gallery.thumnailPath }">
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<h2>게시글이 존재하지 않습니다.</h2>
			</c:otherwise>
			</c:choose>

		</div>

		<!-- 페이징 -->
		<div class="pagination">
			<button>◀</button>
			<c:forEach  begin="${ map.pi.startPage }"
						end="${ map.pi.endPage }"
						var="num">
				<button class="active">
					<a href="gallery?page=${ num }">${ num }</a>
				</button>
			</c:forEach>
			<button>▶</button>
			<!--  
			<button class="active">1</button>
			<button>2</button>
			<button>3</button>
			<button>4</button>
			<button>5</button>
			<button>▶</button>
			-->
		</div>

	</main>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>