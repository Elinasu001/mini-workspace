<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:choose>
	<c:when test="${ not empty map.events }">
	 	<!-- //디버깅용
        <pre>이벤트 개수: ${fn:length(map.events)}</pre>
		<pre>${map.events}</pre>
		-->
		
		<c:forEach items="${ map.events }" var="event">
		         
		             <div class="col-lg-6 col-xxl-4 mb-5" onclick="toDetail(${event.eventNo});">
		                 <div class="card bg-light border-0 h-100">
		                     <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
		                         <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4">
									    <!-- 첨부파일이 있을 때 -->
									    <!-- 첨부파일이 없을 때 (기본 이미지) -->
		                         	<c:choose>
		                         	
									    <c:when test="${not empty event.filePath and not empty event.changeName}">
									        <img src="<c:url value='/${event.filePath}/${event.changeName}' />" alt="대표이미지">
									    </c:when>
									
									    <c:otherwise>
									        <img src="<c:url value='/resources/upfiles/event/default.png' />" alt="기본이미지">
									    </c:otherwise>
									    
									</c:choose>
		                         	
		                         </div>
		                         <h2 class="fs-4 fw-bold">${ event.eventTitle }</h2>
		                     	<p class="mb-0 pt-1">이벤트 기간 : <span>"${ event.startDate }</span> ~ <span>${ event.endDate }</span></p>
		                     </div>
		                 </div>
		             </div>
		             
		  </c:forEach>
	</c:when>
	<c:otherwise>
		등록된 게시글이 존재하지 않습니다.<br/>
 	</c:otherwise>
</c:choose>

<!-- <img src="<c:url value='/${ event.filePath }/${ event.changeName }'/>" alt="대표이미지"> -->