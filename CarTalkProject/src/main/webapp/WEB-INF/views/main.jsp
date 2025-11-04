<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/views/include/meta.jsp"/>
<title>Insert title here</title>
</head>
<style>
	.main-title{
	  position: absolute;
	  z-index: 2;
	  top: 30%;
	  left: 25%;
	  transform: translateY(-50%);
	  color: #222;
      animation: fadeInDown 1.5s ease forwards;
	}
	.main-title h3{
		font-weight: var(--font-w-b);
		margin: 0;
		font-size: clamp(1.6rem, 2vw, 3.5rem); 
	}
	
	/* 반응형 위치 조정 */
	@media (max-width: 1200px) {
	  .main-title {
	    top: 100px;
	    left: 60px;
	  }
	}
	@media (max-width: 992px) {
	  .main-title {
	    top: 100px;
	    left: 60px;
	  }
	  .main-title h3 {
	    font-size: clamp(1.4rem, 4vw, 2.5rem);
	  }
	}
	@media (max-width: 768px) {
	  .main-title {
	    top: 100px;
	    left: 50px;
	  }
	  .main-title h3 {
	    font-size: clamp(1.2rem, 4vw, 2rem);
	  }
	}
	@media (max-width: 576px) {
	  .main-title {
	    top: 80px;
	    left: 30px;
	  }
	  .main-title h3 {
	    font-size: clamp(1rem, 3vw, 1.8rem);
	  }
	}
	/*
    .MainSwiper {
   	 	position: relative;
        background-color: white;
        background: linear-gradient(135deg, #f7f7f7, #d1d1d1);
       background: radial-gradient(
	    ellipse at 50% 60%,       
	    rgba(120, 120, 120, 0.03) 0%,  
	    rgba(120, 120, 120, 0.03) 00%,  
	    rgba(215, 215, 215, 1.3) 30% 
	   );
	 	 background-repeat: no-repeat;
      
    }
    */
    
    .MainSwiper{
    	background: linear-gradient(135deg, #f7f7f7, #d1d1d1);
    }
    
    .MainSwiper .swiper-wrapper{
        align-items: center;
    }
    .MainSwiper .swiper-slide{
        display:flex;
        justify-content: center;
        overflow: hidden;
    }
    .MainSwiper .swiper-slide img{
        max-width:600px;
        object-fit: cover;
		transform: translateX(50px);
		opacity: 0;
		transition: transform 1.2s ease, opacity 1.2s ease;
    }
    
    .MainSwiper .swiper-slide-active img {
	  transform: translateX(0);
	  opacity: 1;
	}
    
    .MainSwiper .swiper-button-next:after, .swiper-button-prev:after {
        font-size:30px;
        color:black;
    }

    .swiper-pagination-bullet-active {
        width:20px;
        border-radius: 3px;
        background-color:black;
    }
    
    /* 카드 리스트 */
    .mainSec01{
    	padding:80px 0;
    }
	.innerSec {
		display:flex;
		flex-direction:row;
		align-items: center;
		max-width:1200px;
		padding: 0 1rem;
		margin:0 auto;
		gap:20px;
	}
	
	.cardItem{
		max-width:18rem;
		border-radius: 3px;
		background-color: #39393682;
		padding:10px;
	}
	
	.cardItem a h2 {
		font-size: var(--font16);
	}
	
	.cardItem a .feature {
		position: relative;
		display:inline-flex;
		align-items:center;
		justify-content:center;
		height:270px;
		overflow:hidden;
		font-size:2rem;
		border-radius: 3px;
	    transition: transform 0.35s ease, box-shadow 0.35s ease;
	}
	
	.cardItem:hover .feature {
	  transform: translateY(-6px);
	}
	
	.cardItem a{
		overflow:hidden;
	}
		
	.cardItem a .feature img {
		width:100%;
		height:100%;
		object-fit:cover;
	  	transition: transform 0.6s ease, filter 0.6s ease;
		transform: scale(1);
		filter: brightness(1);
	}
	
	
	.cardItem:hover .feature img {
	  transform: scale(1.02);
  filter: brightness(1.03)
	}

	.cardItem a h2{
		width: 250px;
		white-space: nowrap; 
	    text-overflow: ellipsis;
		overflow: hidden;
		font-size: var(--font20);
	}
	
	.category {
	  color: var(--color-1);
	  font-size: var(--font14);
	  background-color:var(--primary);
	  padding:6px 10px;
	  border-radius:20px;
	  color:white;
	  
	}
	
	
	.cardItem .info {
		display:flex;
		flex-direction:column;
		padding:10px;
		gap:1rem;
		color:white;
	}
	
	.cardItem .info .txt p{
	   padding-top:1rem;
	}
    
</style>
<body>
	<div id="wrap" class="main">
		<jsp:include page="include/header.jsp"/>
		
	 	<div class="contentWrap">
            <div class="contArea">
                <!-- Slider main container -->
                <div class="swiper MainSwiper">
                
                	<div class="main-title">
	            		<h3>
	            			차 이야기, <br/>
	            			함께 나누다
	            		</h3>
	            	</div>
                    <!-- Additional required wrapper -->
                    <div class="swiper-wrapper">
                    	
                        <!-- Slides -->
                        <div class="swiper-slide"><img src="./resources/images/main_banner/car01.png"></div>
                        <div class="swiper-slide"><img src="./resources/images/main_banner/car02.png"></div>
                        <div class="swiper-slide"><img src="./resources/images/main_banner/car03.png"></div>
                        <div class="swiper-slide"><img src="./resources/images/main_banner/car04.png"></div>
                        <div class="swiper-slide"><img src="./resources/images/main_banner/car05.png"></div>
                    </div>
                
                    <!-- If we need pagination -->
                    <div class="swiper-pagination"></div>
                
                    <!-- If we need navigation buttons -->
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                
                </div>
                
                <!-- 진행 중인 이벤트 -->
                <section class="mainSec01 cardArea">
                	<div class="innerSec">
						<c:choose>
						  <c:when test="${not empty ongoingEvents}">
						    <c:forEach items="${ongoingEvents}" var="event">
						      <div class="cardItem" data-eventno="${event.eventNo}">
					            <a href="${pageContext.request.contextPath}/event/detail/${event.eventNo}">
					              <p class="feature">
					                <c:choose>
					                  <c:when test="${not empty event.thumbnailPath and not empty event.thumbnailName}">
					                    <img src="${pageContext.request.contextPath}${event.thumbnailPath}${event.thumbnailName}" alt="대표이미지">
					                  </c:when>
					                  <c:otherwise>
					                    <img src="<c:url value='/resources/upfiles/event/default.png' />" alt="기본이미지">
					                  </c:otherwise>
					                </c:choose>
					              </p>
					              <div class="info">
						              <h2>${event.eventTitle}</h2>
						              <div class="txt">
						                <span class="category">${event.category.categoryName}</span>
						                <p>${event.startDate} ~ ${event.endDate}</p>
						              </div>
					              </div>
					            </a>
						      </div>
						    </c:forEach>
						  </c:when>
						  <c:otherwise>
						    <div class="col-12 text-center py-5">현재 진행 중인 이벤트가 없습니다.</div>
						  </c:otherwise>
						</c:choose>
					</div>
				</section>

            </div>
        </div>
		
		<jsp:include page="include/footer.jsp"/>
	</div>
</body>
<script>
    // 슬라이더 동작 정의
    const swiper = new Swiper('.swiper', {
        autoplay : {
            delay : 5000 // 3초마다 이미지 변경
        },
        loop : true, //반복 재생 여부
        slidesPerView : 1, // 이전, 이후 사진 미리보기 갯수
        pagination: { // 페이징 버튼 클릭 시 이미지 이동 가능
            el: '.swiper-pagination',
            clickable: true 
        },
        navigation: { // 화살표 버튼 클릭 시 이미지 이동 가능
            prevEl: '.swiper-button-prev',
            nextEl: '.swiper-button-next'
        }
    }); 
</script>
</html>