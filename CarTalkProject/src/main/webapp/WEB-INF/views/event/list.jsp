<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/views/include/meta.jsp"/>
<title>이벤트 게시판</title>
</head>
<style>
.eventBanner{
	 background: rgba(223, 228, 216, 1);
}

.eventBanner p {
	line-height:1.5;
}
.feature {
	position: relative;
	display:inline-flex;
	align-items:center;
	justify-content:center;
	height:18rem;
	width:18rem;
	overflow:hidden;
	font-size:2rem;
	background-color:var(--bs-gray-200);
}
.feature img {
	width:100%;
	height:100%;
	object-fit:cover;
}


/* 딤 오버레이 */
.feature.ended::after {
  content: "종료된 이벤트";
  position: absolute;
  left:50%;
  inset: 0;
  background: rgba(0, 0, 0, 0.55);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 1.2rem;
  letter-spacing: 0.05em;
  width:18rem;
  height:18rem;
}

.category {
  color: var(--color-1);
  font-size: var(--font14);
  background-color:rgb(13 110 253 / 18%);
  padding:6px 10px;
  border-radius:20px;
}

.row {
  --bs-gutter-x: 1.5rem;
  --bs-gutter-y: 0;
  display: flex;
  flex-wrap: wrap;
  margin-top: calc(-1 * var(--bs-gutter-y));
  margin-right: calc(-0.5 * var(--bs-gutter-x));
  margin-left: calc(-0.5 * var(--bs-gutter-x));
}


/* 탭 아래쪽 실선 더 두껍고 진하게 */
.nav-tabs {
  border-bottom: 3px solid rgba(33, 37, 41, 0.3) !important; /* 기존보다 진하게 */
}

/* 비활성 탭 텍스트 */
.nav-tabs .nav-link {
  color: #444;
  border: none;
  border-bottom: 3px solid transparent; /* hover 시 살짝 밑줄 효과 */
  transition: all 0.3s ease;
}

/* hover 시 효과 */
.nav-tabs .nav-link:hover {
  border-bottom-color: rgba(33, 37, 41, 0.3);
  color: #212529;
}

/* 활성 탭은 진한 실선으로 강조 */
.nav-tabs .nav-link.active {
  color: #fff !important;
  background-color: rgba(33,37,41,1) !important;
  border: none;
  border-bottom: 3px solid rgba(33,37,41,1) !important;
}

.pagination{
	--bs-pagination-padding-x: 1rem;
	--bs-pagination-padding-y: 1rem;
	--bs-pagination-color:#333;
}


</style>
<body>
	<div id="wrap">
	
		<jsp:include page="../include/header.jsp"/>
		
	 	<div class="contentWrap">
            <div class="contArea">
            
            	<!-- Header-->
		        <header class="eventBanner">
		            <div class="container px-lg-5">
		                <div class="p-4 p-lg-5 rounded-3 text-center">
		                    <div class="m-4 m-lg-6">
		                        <h1 class="display-5 fw-bold pb-3">이벤트 게시판</h1>
		                        <p class="fs-4">
		                        다양한 이벤트와 혜택을 한눈에!<br/>
		                        참여하고, 즐기고, 특별한 선물을 만나보세요.
		                        </p>
		                        <!-- <a class="btn btn-primary btn-lg" href="#">Call to action</a> -->
		                    </div>
		                </div>
		            </div>
		            
		        </header>
		        
	        	<!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
		        <!--c:if test="${ not empty sessionScope.loginMember }">-->
		        <!-- <div class="mx-3 my-4">
		        	<a class="btn btn-secondary" href="event/form">등록하기</a>
	        	</div>-->
		        <!--/c:if>-->
		        
		        <!-- 탭 영역 추가 -->
			    <div class="container py-5">
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

		        
		        <section class="pt-4" > 
		        	<div class="container ">
		        		<div id="eventArea" class="row gx-lg-5" >
				       	<!-- Page Content-->
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
<!--
function toDetail(eventNo){
	location.href = "event/" + eventNo;
}
-->

$(function() {
	 loadEvents("ongoing", 1); // 기본 탭: 진행중 이벤트
	
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
	 
	 
	 
	 function loadEvents(type, page) {
	   $.ajax({
	     url: "${pageContext.request.contextPath}/event/" + type + "?page=" + page,
	     type: "GET",
	     dataType: "html",
	     success: function(data) {
	       $("#eventArea").html(data);
	       
	       // 페이징 클릭 이벤트 재바인딩
	       $("#eventArea .pagination a").on("click", function(e) {
	           e.preventDefault();
	           const pageNum = $(this).data("page");
	           loadEvents(type, pageNum);
	        });
	       
	       // 종료된 이벤트 전용 처리
	       if (type === "ended") {
	    	 // 1) 딤 클래스 추가
	         $("#eventArea .feature").addClass("ended");
	         // 2) 링크 클릭 막기
	         $("#eventArea .card-body a").css({
	           "pointer-events": "none",
	           "cursor": "not-allowed"
	         });
	        
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