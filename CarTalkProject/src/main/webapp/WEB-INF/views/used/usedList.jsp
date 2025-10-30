<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>중고 판매 목록 | CarTalk</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/used/usedList.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<main class="main-wrap">
		<h2>중고 판매 목록</h2>

		<!-- 차량 목록 -->
		<div class="car-list">

			<div class="car-card">
				<div class="car-info">
					<div>판매중 | SUV</div>
					<h3>현대 팰리세이드 2.2 디젤 4WD 캘리그래피</h3>
					<p>20.03년식 / 6.3만KM / 오토 / 디젤</p>
					<div class="meta">가격: 4,290만원 | 댓글 5 | 1일 전</div>
				</div>
				<img src="https://via.placeholder.com/150x100?text=Palisade"
					alt="팰리세이드">
			</div>

			<div class="car-card">
				<div class="car-info">
					<div>예약중 | 세단</div>
					<h3>제네시스 G80 3.3 GDI AWD 럭셔리</h3>
					<p>18.09년식 / 8.5만KM / 오토 / 가솔린</p>
					<div class="meta">가격: 3,150만원 | 댓글 2 | 2일 전</div>
				</div>
				<img src="https://via.placeholder.com/150x100?text=G80"
					alt="제네시스 G80">
			</div>

			<div class="car-card">
				<div class="car-info">
					<div>판매완료 | 소형 SUV</div>
					<h3>기아 셀토스 1.6 디젤 트렌디</h3>
					<p>21.05년식 / 2.9만KM / 오토 / 디젤</p>
					<div class="meta">가격: 2,380만원 | 댓글 1 | 4일 전</div>
				</div>
				<img src="https://via.placeholder.com/150x100?text=Seltos" alt="셀토스">
			</div>

		</div>

		<!-- 페이징 -->
		<div class="pagination">
			<button>▶</button>
			<button class="active">1</button>
			<button>2</button>
			<button>3</button>
			<button>4</button>
			<button>5</button>
			<button>▶</button>
		</div>

		<!-- 검색 -->
		<div class="search-box">
			<input type="text" placeholder="검색어를 입력하세요.">
			<button>검색</button>
		</div>

	</main>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
