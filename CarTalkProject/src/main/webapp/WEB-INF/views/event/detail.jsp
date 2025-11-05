<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/views/include/meta.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/event/detail.css">
<title>이벤트 게시판 상세조회</title>
</head>
<body>

<div id="wrap">
  <jsp:include page="../include/header.jsp"/>

  <div class="contentWrap">
    <div class="contArea">

      <!-- 상단 배너 -->
      <header class="eventBanner text-center py-5">
        <div class="container px-lg-5">
          <div class="p-4 p-lg-5 rounded-3">
            <h1 class="display-5 fw-bold mb-3">${event.eventTitle}</h1>
            <p class="fs-5 mb-0">
              <span class="category me-2">${event.category.categoryName}</span>
              <span>${event.startDate} ~ ${event.endDate}</span>
            </p>
            <p class=" mt-2">
              조회수: ${event.viewCount}
            </p>
          </div>
        </div>
      </header>

      <!-- 상세 내용 -->
      <section class="pt-5 pb-5">
        <div class="container">
       	 <!-- 관리자 전용 버튼 -->
         <div class="d-flex justify-content-end py-3">
			  <c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.manager eq 'Y'}">
			      <a href="${pageContext.request.contextPath}/event/updateForm?eventNo=${event.eventNo}" 
			         class="btn btn-primary px-5 py-2 ms-2">수정하기</a>
			  </c:if>
		  </div>
          <div class="card border-0 shadow-sm">
            <div class="card-body text-center p-4 mb-4">
              <!-- 상세 이미지 -->
              <c:choose>
                <c:when test="${not empty event.detailPath and not empty event.detailName}">
                  <img class="detail-img mb-5" 
                       src="${pageContext.request.contextPath}${event.detailPath}${event.detailName}" 
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