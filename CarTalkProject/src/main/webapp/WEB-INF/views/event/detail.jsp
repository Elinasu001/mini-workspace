<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/views/include/meta.jsp"/>
<title>이벤트 게시판 상세조회</title>
</head>
<body>

<style>
.detailBanner {
  background: rgba(223, 228, 216, 1);
}

.detailBanner p {
  line-height: 1.5;
}

.detail-img {
  width: 100%;
  height: auto;
  border-radius: 12px;
  object-fit: cover;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
}

.category {
  color: var(--color-1);
  font-size: var(--font14);
  background-color: rgb(13 110 253 / 18%);
  padding: 6px 10px;
  border-radius: 20px;
}

.event-content {
  font-size: 1.1rem;
  color: #333;
  line-height: 1.8;
  margin-top: 1.5rem;
  text-align: left;
}

.meta-info {
  font-size: 0.95rem;
  color: #666;
  margin-top: 1rem;
}

.btn-wrap {
  margin-top: 3rem;
}
</style>

<div id="wrap">
  <jsp:include page="../include/header.jsp"/>

  <div class="contentWrap">
    <div class="contArea">

      <!-- 상단 배너 -->
      <header class="detailBanner text-center py-5">
        <div class="container px-lg-5">
          <div class="p-4 p-lg-5 rounded-3">
            <h1 class="display-5 fw-bold mb-3">${event.eventTitle}</h1>
            <p class="fs-5 mb-0">
              <span class="category me-2">${event.categoryName}</span>
              <span>${event.startDate} ~ ${event.endDate}</span>
            </p>
            <p class="meta-info mt-2">
              조회수: ${event.viewCount}
            </p>
          </div>
        </div>
      </header>

      <!-- 상세 내용 -->
      <section class="pt-5 pb-5">
        <div class="container">
          <div class="card border-0 shadow-sm">
            <div class="card-body text-center p-4">

              <!-- 대표 이미지 -->
              <c:choose>
                <c:when test="${not empty event.filePath and not empty event.changeName}">
                  <img class="detail-img mb-5" 
                       src="<c:url value='/${event.filePath}/${event.changeName}'/>" 
                       alt="${event.eventTitle}">
                </c:when>
                <c:otherwise>
                  <img class="detail-img mb-5" 
                       src="<c:url value='/resources/upfiles/event/default.png'/>" 
                       alt="기본이미지">
                </c:otherwise>
              </c:choose>

              <!-- 내용 -->
              <div class="event-content text-start">
                <pre style="white-space: pre-wrap; font-family: inherit; background: none; border: none;">
${event.eventContent}
                </pre>
              </div>

              <!-- 버튼 -->
              <div class="btn-wrap text-center">
                <a href="${pageContext.request.contextPath}/event/list" 
                   class="btn btn-secondary px-5 py-2">목록으로</a>
              </div>
            </div>
          </div>
        </div>
      </section>

    </div>
  </div>

  <jsp:include page="../include/footer.jsp"/>
</div>
	
</body>
</html>