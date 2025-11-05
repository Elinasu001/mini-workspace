<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>중고 상세 페이지 | CarTalk</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/used/usedDetail.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
	crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/meta.jsp" />
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<main class="main-wrap">
		<h2>중고차 상세 보기</h2>

		<div class="detail-top">

			<!-- 왼쪽: 대표 + 보조 이미지 -->
			<!-- 이미지 영역을 Bootstrap Carousel로 변환 -->
			<div id="usedCarousel" class="carousel slide" data-bs-ride="carousel">

				<!-- 인디케이터 (이미지 개수만큼 생성) -->
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#usedCarousel"
						data-bs-slide-to="0" class="active" aria-current="true"
						aria-label="Slide 1"></button>
					<c:forEach var="img" items="${attachments}" varStatus="status">
						<button type="button" data-bs-target="#usedCarousel"
							data-bs-slide-to="${status.index + 1}"
							aria-label="Slide ${status.index + 2}"></button>
					</c:forEach>
				</div>

				<!-- 실제 이미지 슬라이드 -->
				<div class="carousel-inner">
					<!-- 대표 이미지 -->
					<div class="carousel-item active">
						<img src="${pageContext.request.contextPath}${used.thumbnail}" 
     											class="d-block w-100" alt="대표 이미지">

							
					</div>

					<!-- 첨부 이미지들 -->
					<c:forEach var="img" items="${attachments}">
						<div class="carousel-item">
							<img src="${pageContext.request.contextPath}${img.filePath}"
								class="d-block w-100" alt="${img.originName}">
						</div>
					</c:forEach>
				</div>

				<!-- 이전/다음 버튼 -->
				<button class="carousel-control-prev" type="button"
					data-bs-target="#usedCarousel" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#usedCarousel" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>

			<!-- 오른쪽: 차량 정보 -->
			<div class="car-info">
				<h2>${used.usedTitle}</h2>
				<!-- 차량명 -->
				<div class="basic">
					<p>
						등록일: <span>${used.enrollDate}</span>
					</p>
					<p>
						조회수: <span>${used.viewCount}</span>
					</p>
				</div>
				<p>
					카테고리: <span>${used.categoryName}</span>
				</p>
				<p>
					연식: <span>${car.carYear}</span>
				</p>
				<p>
					주행거리: <span>${car.distance} km</span>
				</p>
				<p>
					변속기: <span>${car.transmission}</span>
				</p>
				<p>
					연료: <span>${car.fuelType}</span>
				</p>
				<p>
					색상: <span>${car.carColor}</span>
				</p>
				<p>
					가격: <span>${used.usedPrice}</span>원
				</p>
				<p>
					연락처: <span>${car.phone}</span>
				</p>
				<p>
					지역: <span>${car.region}</span>
				</p>
			</div>
		</div>

		<div class="desc-box">
			<label>차량 설명</label><br>
			<textarea readonly>${used.usedContent}</textarea>
		</div>
		<!-- <p>로그인 유저: ${sessionScope.loginMember.userNo}</p>
		<p>글 작성자: ${used.userNo}</p> -->
		<div class="btns">
		<!--and sessionScope.loginMember.userNo eq used.userNo-->	
      <c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.userNo == used.userNo}">
      <button type="button" class="btn btn-outline-success" onclick="location.href='${pageContext.request.contextPath}/used/updateForm/${used.usedNo}'">수정</button>
      <button type="button" class="btn btn-outline-danger" data-no="${used.usedNo}">삭제</button>
      </c:if>
      
			<a class="btn btn-primary" href="${pageContext.request.contextPath}/used/list?page=${param.page}&keyword=${param.keyword}" role="button">목록으로</a>
		</div>
	</main>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script>
		$(document).ready(function() {
			const contextPath = "${pageContext.request.contextPath}";

			$(".btn.btn-outline-danger").on("click", function() {
				const usedNo = $(this).data("no") || "/ct";
				
				//console.log("삭제 버튼 클릭됨, usedNo =", usedNo);
				//console.log("요청 URL =", `${contextPath}/used/delete/${usedNo}`);
				

				if (confirm("정말 삭제하시겠습니까?")) {
					$.ajax({
						url : "/ct/used/delete/" + usedNo, 
						type : "POST",
						success : function(result) {
							if (result === "success") {
								alert("삭제가 완료되었습니다.");
								location.href = `${contextPath}/ct/used/list`;
							} else {
								alert("삭제 실패");
							}
						},
						error : function() {
							alert("삭제에 실패 하였습니다.");
						}
					});
				}
			});
		});
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js"
		integrity="sha384-G/EV+4j2dNv+tEPo3++6LCgdCROaejBqfUeNjuKAiuXbjrxilcCdDz6ZAVfHWe1Y"
		crossorigin="anonymous"></script>
</body>
</html>
