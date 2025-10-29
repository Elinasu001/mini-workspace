<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.main-title{
		position:absolute;
		z-index:2; 
		left:100px;
		top:120px;
	}
	.main-title h3{
		font-size:var(--font36);
		font-weight: var(--font-w-b);
	}
    .MainSwiper {
        /* background-color: white; */
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
</style>
<body>
	<div id="wrap" class="main">
		<jsp:include page="include/header.jsp"/>
		
	 	<div class="contentWrap">
            <div class="contArea">
            	<div class="main-title">
            		<h3>
            			차 이야기, <br/>
            			함께 나누다
            		</h3>
            	</div>
                <!-- Slider main container -->
                <div class="swiper MainSwiper">
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
                
                    <!-- If we need scrollbar -->
                    <div class="swiper-scrollbar"></div>
                </div>
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