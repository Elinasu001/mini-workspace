<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>중고 판매 등록</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/used/usedForm.css">
</head>
<body>
  <jsp:include page="/WEB-INF/views/include/meta.jsp" />
  <jsp:include page="/WEB-INF/views/include/header.jsp" />

  <div class="container">
    <h2>중고 판매 등록</h2>

    <form action="${pageContext.request.contextPath}/used/list" method="post" enctype="multipart/form-data">

      <div class="section">
        <h3>상품 이미지</h3>
        <div class="upload-box">
          <img src="" alt="이미지 업로드 아이콘">
          <span>0 / 5</span>
        </div>
      </div>

      <div class="section">
        <h3>상품명</h3>
        <input type="text" name="usedTitle" value="" placeholder="상품명을 입력해주세요.">
      </div>

      <div class="section">
        <h3>카테고리</h3>

        차급<input type="text" name="category" value="" placeholder="차급 (예: 소형, 중형, 대형)">
        브랜드<input type="text" name="manufacturer" value="" placeholder="브랜드 (예: 현대, 기아, BMW)">
        모델명<input type="text" name="model" value="" placeholder="모델명 (예: 쏘나타, K5, 3시리즈)">
        판매 가격<input type="text" name="usedPrice" value="" placeholder="판매 가격 만원(₩)">
        연식 <input type="text" name="carYear" value="" placeholder="연식 (예: 2020.05(20년식))">
        주행 거리<input type="text" name="distance" value="" placeholder="주행거리 (km)">
        변속기 <input type="text" name="transmission" value="" placeholder="변속기 (오토 / 수동)">
        사고 여부<input type="text" name="accident" value="" placeholder="사고 여부 (예: 무사고)">
        차량 색상<input type="text" name="carColor" value="" placeholder="차량 색상 (예: 흰색)">
        판매자 연락처<input type="text" name="phone" value="" placeholder="-제외하고 입력해주세요.">
      </div>

      <div class="section">
        <h3>상품 설명</h3>
        <textarea name="usedContent" placeholder="상품 상세 설명을 입력해주세요. (예: 옵션, 사고 여부, 특징 등)"></textarea>
      </div>

      <div class="section">
        <h3>거래 지역</h3>
        <select name="region">
          <option selected disabled>지역을 선택하세요</option>
          <option>서울</option>
          <option>경기 북부</option>
          <option>경기 남부</option>
          <option>인천</option>
          <option>강원</option>
          <option>대전</option>
          <option>세종</option>
          <option>충북</option>
          <option>충남</option>
          <option>광주</option>
          <option>전북</option>
          <option>전남</option>
          <option>부산</option>
          <option>울산</option>
          <option>대구</option>
          <option>경북</option>
          <option>경남</option>
          <option>제주</option>
        </select>
      </div>

      <button type="submit">등록하기</button>
    </form>
  </div>

  <jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
