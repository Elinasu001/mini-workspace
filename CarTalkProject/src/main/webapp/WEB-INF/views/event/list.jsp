<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/views/include/meta.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/event/list.css">
<title>이벤트 게시판</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/include/toast.jsp"/>
	
	<div id="wrap">
		<jsp:include page="../include/header.jsp"/>
		
	 	<div class="contentWrap">
            <div class="contArea">
            
            	<!-- 이벤트 배너 -->
		        <header class="eventBanner">
		            <div class="container px-lg-5">
		                <div class="p-4 p-lg-5 rounded-3 text-center">
		                    <div class="m-4 m-lg-6">
		                        <h1 class="display-5 fw-bold pb-3">이벤트 게시판</h1>
		                        <p class="fs-4">
		                        다양한 이벤트와 혜택을 한눈에!<br/>
		                        참여하고, 즐기고, 특별한 선물을 만나보세요.
		                        </p>
		                    </div>
		                </div>
		            </div>
		            
		        </header>
		        
		        <!-- 탭 및 등록하기 버튼 -->
			    <div class="container py-5">
			    
			    	<!-- [D] : 관리자로그인 상태일 경우만 보여지는 등록하기 버튼 -->
			      	<c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.manager eq 'Y'}">
						<div class="d-flex justify-content-end">
							<a class="btn btn-primary btn btn-primary px-5 py-2 ms-2" href="${pageContext.request.contextPath}/event/insertForm">등록하기</a>
						</div>
					</c:if>
					
				    <ul id="eventTabs" class="nav nav-tabs nav-fill pt-4" >
				        <li class="nav-item">
				            <button  id="ongoing-tab" class="nav-link active fs-4 fs-md-3 px-4 px-md-5 py-3 py-md-4 fw-semibold" type="button">
				                진행중 이벤트
				            </button>
				        </li>
				        <li class="nav-item">
				            <button id="ended-tab" class="nav-link fs-4 fs-md-3 px-4 px-md-5 py-3 py-md-4 fw-semibold" type="button" >
				                종료된 이벤트
				            </button>
				        </li>
				    </ul>
				</div>

		        <!-- Ajax 데이터 영역 -->
		        <section class="pt-4" > 
		        	<div class="container ">
		        		<div id="eventArea" class="row gx-lg-5" >
				       	<!-- [D] : 데이터 들어가는 자리 -->
				     		
			           </div>
		           </div>   
           	    </section>
	          	
	            
            </div>
        </div>
		<jsp:include page="../include/footer.jsp"/>
	</div>
</body>
<script>

$(function() {
	
	 // 기본 탭 : 진행중 이벤트
	 loadEvents("ongoing", 1); 
	
	 // 진행중인 게시글
	 $("#ongoing-tab").on("click", function() {
	   $(".nav-link").removeClass("active");
	   $(this).addClass("active");
	   loadEvents("ongoing", 1);
	 });
	
	 // 종료된 게시글
	 $("#ended-tab").on("click", function() {
	   $(".nav-link").removeClass("active");
	   $(this).addClass("active");
	   loadEvents("ended", 1);
	 });
	 
	 
	 // Ajax 목록 호출 함수
	 function loadEvents(type, page) {
	   $.ajax({
	     url: "${pageContext.request.contextPath}/event/" + type + "?page=" + page,
	     type: "GET",
	     dataType: "html",
	     success: function(data) {
	       $("#eventArea").html(data);
	       
	       // 페이징 클릭 이벤트 
	       $("#eventArea .pagination a").on("click", function(e) {
	           e.preventDefault();
	           const pageNum = $(this).data("page");
	           loadEvents(type, pageNum);
	        });
	       
	       // 종료된 이벤트 전용 처리
	       if (type === "ended") {
	         $("#eventArea .card").addClass("ended");
	       }
	     },
	     error: function() {
	       $("#eventArea").html("<p class='text-center text-danger py-5'>이벤트를 불러오는 중 오류가 발생했습니다.</p>");
	     }
	   });
  }
});
</script>
</html>