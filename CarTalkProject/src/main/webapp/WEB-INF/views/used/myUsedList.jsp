<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 판매 목록 | CarTalk</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/used/myUsedList.css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<main class="main-wrap">
		<h2>내 판매 목록</h2>

		<div class="filter">
			<button class="active">전체</button>
			<button>판매중</button>
			<button>예약중</button>
			<button>판매완료</button>
		</div>

		<div class="car-list">

			<div class="car-card">
				<div class="car-info">
					<div></div>
					<!-- 상태 / 차급 -->
					<h3></h3>
					<!-- 차량명 -->
					<p></p>
					<!-- 요약설명 -->
					<div class="meta"></div>
					<!-- 가격/댓글/기간 -->
				</div>
				<img src="" alt="차량 이미지">
			</div>

			<div class="car-card">
				<div class="car-info">
					<div></div>
					<h3></h3>
					<p></p>
					<div class="meta"></div>
				</div>
				<img src="" alt="차량 이미지">
			</div>

			<div class="car-card">
				<div class="car-info">
					<div></div>
					<h3></h3>
					<p></p>
					<div class="meta"></div>
				</div>
				<img src="" alt="차량 이미지">
			</div>

		</div>
	</main>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

</body>
</html>
