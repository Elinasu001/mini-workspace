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
<jsp:include page="/WEB-INF/views/include/meta.jsp" />
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<main class="main-wrap">
		<h2>사진 게시판</h2>

		<!-- 게시판 목록 -->
		<div class="car-list">
		
			<script>
			    function toDetail(galleryNo){
			        location.href = `/ct/gallery/\${galleryNo}`;
			    }
			</script>
			
			<c:choose>
			    <c:when test="${not empty map.gallerys}">
			        <c:forEach var="gallery" items="${map.gallerys}">
			            <div class="car-card" onclick="toDetail(${gallery.galleryNo})">
			                <div class="car-info">
			                    <div>${gallery.categoryName}</div>
			                    <h3>${gallery.galleryTitle}</h3>
			                    <div class="meta">${gallery.nickname} | 조회수 ${gallery.viewCount} | ${gallery.enrollDate}</div>
			                </div>
			                <img src="/ct/resources/upfiles/gallery/${gallery.thumnailPath}">
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
				<button class="active" 
						onclick="location.href='gallery?page=${num}'">
					${num}
				</button>
			</c:forEach>
			<button>▶</button>
		</div>
		<!-- 글쓰기 버튼 -->
		<div class="left-box">
		<c:if test="${ not empty sessionScope.loginMember }">
			<a href="${pageContext.request.contextPath}/gallery/form" class="btn-write">글쓰기</a>
		</c:if>
		</div>
	</main>
	
	<jsp:include page="../include/footer.jsp" />
</body>
</html>