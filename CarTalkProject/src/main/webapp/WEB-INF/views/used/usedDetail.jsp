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
</head>
<body>
  <jsp:include page="/WEB-INF/views/include/meta.jsp" />
  <jsp:include page="/WEB-INF/views/include/header.jsp" />

  <main class="main-wrap">
    <h2>중고차 상세 보기</h2>

    <div class="detail-top">

      <!-- 왼쪽: 대표 + 보조 이미지 -->
      <div class="image-area">
        <img class="main-img" src="" alt="대표 이미지">
        <div class="sub-imgs">
          <img src="" alt="보조 이미지 1">
          <img src="" alt="보조 이미지 2">
          <img src="" alt="보조 이미지 3">
          <img src="" alt="보조 이미지 4">
        </div>
      </div>

      <!-- 오른쪽: 차량 정보 -->
      <div class="car-info">
        <h2></h2> <!-- 차량명 -->
        <div class="basic">
          <p>등록일: </p>
          <p>조회수: </p>
        </div>
        <p>카테고리: </p>
        <p>연식: </p>
        <p>주행거리: </p>
        <p>변속기: </p>
        <p>연료: </p>
        <p>색상: </p>
        <p>가격: </p>
      </div>
    </div>

    <div class="desc-box">
      <label>차량 설명</label><br>
      <textarea readonly></textarea>
    </div>

    <div class="btns">
      <button>수정</button>
      <button>삭제</button>
    </div>
  </main>

  <jsp:include page="/WEB-INF/views/include/footer.jsp" />

</body>
</html>
