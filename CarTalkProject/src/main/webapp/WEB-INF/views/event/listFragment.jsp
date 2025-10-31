<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:choose>
  <c:when test="${not empty map.events}">
    <c:forEach items="${map.events}" var="event">
      <div class="col-lg-6 col-xxl-4 mb-5" onclick="toDetail(${event.eventNo});">
        <div class="card border-0 h-100">
          <div class="card-body text-center p-4 pt-0 pt-lg-0">
            <a href="${pageContext.request.contextPath}/event/detail/${event.eventNo}">
              <p class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4">
                <c:choose>
                  <c:when test="${not empty event.filePath and not empty event.changeName}">
                    <img src="<c:url value='/${event.filePath}/${event.changeName}' />" alt="대표이미지">
                  </c:when>
                  <c:otherwise>
                    <img src="<c:url value='/resources/upfiles/event/default.png' />" alt="기본이미지">
                  </c:otherwise>
                </c:choose>
              </p>
              <h2 class="fs-4 fw-bold">${event.eventTitle}</h2>
              <span class="mb-0 pt-1">이벤트 기간 : ${event.startDate} ~ ${event.endDate}</span>
            </a>
          </div>
        </div>
      </div>
    </c:forEach>

    <!-- 페이지네이션 추가 -->
    <div class="pagingArea py-3 col-12">
      <ul class="pagination justify-content-center my-5">
        <c:if test="${map.pi.currentPage gt 1}">
          <li class="page-item">
            <a class="page-link" href="#" data-page="${map.pi.currentPage - 1}">이전</a>
          </li>
        </c:if>

        <c:forEach begin="${map.pi.startPage}" end="${map.pi.endPage}" var="num">
          <li class="page-item ${map.pi.currentPage eq num ? 'active' : ''}">
            <a class="page-link" href="#" data-page="${num}">${num}</a>
          </li>
        </c:forEach>

        <c:if test="${map.pi.currentPage lt map.pi.maxPage}">
          <li class="page-item">
            <a class="page-link" href="#" data-page="${map.pi.currentPage + 1}">다음</a>
          </li>
        </c:if>
      </ul>
    </div>
  </c:when>
  <c:otherwise>
    <div class="col-12 text-center py-5">등록된 게시글이 존재하지 않습니다.</div>
  </c:otherwise>
</c:choose>


<!-- <img src="<c:url value='/${ event.filePath }/${ event.changeName }'/>" alt="대표이미지"> -->