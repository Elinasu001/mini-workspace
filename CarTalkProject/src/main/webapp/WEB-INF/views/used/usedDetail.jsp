<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>중고 상세 페이지 | CarTalk</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/used/usedDetail.css">
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
  <jsp:include page="/WEB-INF/views/include/meta.jsp" />
  <jsp:include page="/WEB-INF/views/include/header.jsp" />

  <main class="main-wrap">
    <h2>중고차 상세 보기</h2>

    <div class="detail-top">

      <!-- 왼쪽: 대표 + 보조 이미지 -->
      <div class="image-area">
        <img class="main-img" src="${pageContext.request.contextPath}${used.thumbnail}" alt="대표 이미지">
        <div class="sub-imgs">
          <c:forEach var="img" items="${attachments}">
          <img src="${pageContext.request.contextPath}${img.filePath}" alt="${img.originName}">
          </c:forEach>
        </div>
      </div>

      <!-- 오른쪽: 차량 정보 -->
      <div class="car-info">
        <h2>${used.usedTitle}</h2> <!-- 차량명 -->
        <div class="basic">
          <p>등록일: <span>${used.enrollDate}</span> </p>
          <p>조회수: <span>${used.viewCount}</span> </p>
        </div>
        <p>카테고리: <span>${used.categoryName}</span> </p>
        <p>연식: <span>${car.carYear}</span></p>
        <p>주행거리: <span>${car.distance} km</span></p>
        <p>변속기: <span>${car.transmission}</span></p>
        <p>연료: <span>${car.fuelType}</span></p>
        <p>색상: <span>${car.carColor}</span></p>
        <p>가격: <span>${used.usedPrice}</span>원</p>
        <p>연락처: <span>${car.phone}</span></p>
        <p>지역: <span>${car.region}</span></p>
      </div>
    </div>

    <div class="desc-box">
      <label>차량 설명</label><br>
      <textarea readonly>${used.usedContent}</textarea>
    </div>

    <div class="btns">
      <c:if test="${not empty loginMember and loginMember.userNo == used.userNo }">
      <button type="button" onclick="location.href='${pageContext.request.contextPath}/used/updateForm/${used.usedNo}'">수정</button>
      <button type="button" class="btn-delete" data-no="${used.usedNo}">삭제</button>
      </c:if>
      
      <button type="button" onclick="location.href='${pageContext.request.contextPath}/used/list'">목록으로</button>
    </div>
  </main>

  <jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script>
		$(document).ready(function(){
			const contextPath = "${pageContext.request.contextPath}";
			
			$(".btn-delete").on("click", function(){
				const usedNo = $(this).data("no");
				
				if(confirm("정말 삭제하시겠습니까?")){
					$.ajax({
						url: `${contextPath}/used/delete/${usedNo}`,
						type: "POST",
						success: function(result){
							alert("삭제가 완료되었습니다.");
							location.href = `${contextPath}/used/list`;
						},
						error: function(){
							alert("삭제에 실패 하였습니다.");
						}
					});
				}
			});
		});
	</script>
</body>
</html>
