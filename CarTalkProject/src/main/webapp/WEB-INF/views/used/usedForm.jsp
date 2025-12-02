<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>중고 판매 등록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/used/usedForm.css">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
	crossorigin="anonymous"></script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/meta.jsp" />
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<div class="container">
		<h2>중고 판매 등록</h2>

		<form action="${pageContext.request.contextPath}/used/insert"
			method="post" enctype="multipart/form-data">

			<div class="section">
				<h3>대표 이미지 (썸네일)</h3>
				<input type="file" name="upfile1" accept="image/*" id="upfile1">
				<div id="preview1" class="preview-box"></div>
			</div>

			<div class="section">
				<h3>추가 이미지</h3>
				<input type="file" name="upfile2" accept="image/*" id="upfile2">
				<input type="file" name="upfile3" accept="image/*" id="upfile3">
				<input type="file" name="upfile4" accept="image/*" id="upfile4">
				<input type="file" name="upfile5" accept="image/*" id="upfile5">
				<div id="previewExtra" class="preview-box"></div>
			</div>

			<script>
			      function previewImage(inputId, previewContainer) {
			        const input = document.getElementById(inputId);
			        const container = document.getElementById(previewContainer);
			        input.addEventListener("change", e => {
			          container.innerHTML = "";
			          const file = e.target.files[0];
			          if (file) {
			            const reader = new FileReader();
			            reader.onload = function(ev) {
			              const img = document.createElement("img");
			              img.src = ev.target.result;
			              img.style.width = "150px";
			              img.style.height = "150px";
			              img.style.objectFit = "cover";
			              img.style.margin = "5px";
			              container.appendChild(img);
			            };
			            reader.readAsDataURL(file);
			          }
			        });
			      }
			
			      previewImage("upfile1", "preview1");
			
			      ["upfile2","upfile3","upfile4","upfile5"].forEach(id => {
			        document.getElementById(id).addEventListener("change", e => {
			          const container = document.getElementById("previewExtra");
			          const file = e.target.files[0];
			          if (!file) {
			        	  container.innerHTML = "";
			        	  return;
			          }
			          
			          	container.innerHTML ="";
			          	
			            const reader = new FileReader();
			            reader.onload = ev => {
			              const img = document.createElement("img");
			              img.src = ev.target.result;
			              img.style.width = "120px";
			              img.style.height = "120px";
			              img.style.objectFit = "cover";
			              img.style.margin = "5px";
			              container.appendChild(img);
			            };
			            reader.readAsDataURL(file);
			        });
			      });
	    </script>

			<div class="section">
				<h3>상품명</h3>
				<input type="text" name="usedTitle" placeholder="상품명을 입력해주세요.">
			</div>

			<div class="section">
				<h3>카테고리</h3>


				브랜드<input type="text" name="manufacturer" placeholder="브랜드 (예: 현대, 기아, BMW)"> 
				모델명<input type="text" name="model" placeholder="모델명 (예: 쏘나타, K5, 3시리즈)"> 
				판매 가격<input type="number" name="usedPrice" placeholder="판매 가격 만원(₩)"> 
				연식 <input type="text" name="carYear" placeholder="연식 (예: 2020.05(20년식))"> 
				연료 타입 <input type="text" name="fuelType" placeholder="연료 타입 (예: 휘발유, 경유, LPG)">
				주행 거리<input type="number" name="distance" placeholder="주행거리 (km)"> 
				변속기 <input type="text" name="transmission" placeholder="변속기 (오토 / 수동)"> 
				사고 여부<input type="text" name="accident" placeholder="사고 여부 (예: 무사고)">
				차량 색상<input type="text" name="carColor" placeholder="차량 색상 (예: 흰색)">
				판매자 연락처<input type="text" name="phone" placeholder="-제외하고 입력해주세요.">
			</div>


			<div class="section">
				<h3>상품 설명</h3>
				<textarea name="usedContent"
					placeholder="상품 상세 설명을 입력해주세요. (예: 옵션,상태,특징 등)"></textarea>
			</div>

			<div class="section">
				<h3>거래 지역 / 자동차 분류</h3>
				<div class="form-row">
					<div class="form-group">
						<label for="region">거래 지역</label> <select name="region"
							id="region">
							<option selected disabled>지역을 선택하세요</option>
							<option value="서울">서울</option>
							<option value="경기 북부">경기 북부</option>
							<option value="경기 남부">경기 남부</option>
							<option value="인천">인천</option>
							<option value="강원">강원</option>
							<option value="대전">대전</option>
							<option value="세종">세종</option>
							<option value="충북">충북</option>
							<option value="충남">충남</option>
							<option value="광주">광주</option>
							<option value="전북">전북</option>
							<option value="전남">전남</option>
							<option value="부산">부산</option>
							<option value="울산">울산</option>
							<option value="대구">대구</option>
							<option value="경북">경북</option>
							<option value="경남">경남</option>
							<option value="제주">제주</option>
						</select>
					</div>

					<div class="form-group">
						<label for="category">자동차 분류</label> <select name="category"
							id="category">
							<option selected disabled>분류</option>
							<option value="1">세단</option>
							<option value="2">수입차</option>
							<option value="3">SUV</option>
							<option value="4">승용차</option>
							<option value="5">트럭/상용</option>
							<option value="6">스포츠카</option>
							<option value="7">경차</option>
							<option value="8">전기차</option>
							<option value="9">오토바이</option>
							<option value="10">기타</option>
						</select>
					</div>
				</div>
			</div>
			<div class="button-group">
				<button type="submit" class="btn btn-outline-success" id="submitBtn">등록하기</button>
				<button type="button" class="btn btn-outline-info"
					onclick="location.href='${pageContext.request.contextPath}/used/list'">취소</button>
			</div>
		</form>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script>
		$(function() {
			$("#submitBtn")
					.click(
							function(e) {
								e.preventDefault();

								const title = $.trim($(
										"input[name='usedTitle']").val());
								const manufacturer = $.trim($(
										"input[name='manufacturer']").val());
								const model = $.trim($("input[name='model']")
										.val());
								const price = $.trim($(
										"input[name='usedPrice']").val());
								const year = $.trim($("input[name='carYear']")
										.val());
								const fuel = $.trim($("input[name='fuelType']")
										.val());
								const distance = $.trim($(
										"input[name='distance']").val());
								const transmission = $.trim($(
										"input[name='transmission']").val());
								const accident = $.trim($(
										"input[name='accident']").val());
								const color = $
										.trim($("input[name='carColor']").val());
								const phone = $.trim($("input[name='phone']")
										.val());
								const content = $.trim($(
										"textarea[name='usedContent']").val());
								const region = $("#region").val();
								const category = $("#category").val();
								;

								if (title === "") {
									alert("상품명을 입력해주세요.");
									return;
								}
								if (manufacturer === "") {
									alert("브랜드를 입력해주세요.");
									return;
								}
								if (model === "") {
									alert("모델명을 입력해주세요.");
									return;
								}
								if (price === "" || price == 0) {
									alert("판매 가격을 입력해주세요.");
									return;
								}
								if (year === "") {
									alert("연식을 입력해주세요.");
									return;
								}
								if (fuel === "") {
									alert("연료 타입을 입력해주세요.");
									return;
								}
								if (distance === "" || distance == 0) {
									alert("주행 거리를 입력해주세요.");
									return;
								}
								if (transmission === "") {
									alert("변속기를 입력해주세요.");
									return;
								}
								if (accident === "") {
									alert("사고 여부를 입력해주세요.");
									return;
								}
								if (color === "") {
									alert("차량 색상을 입력해주세요.");
									return;
								}
								if (phone === "") {
									alert("판매자 연락처를 입력해주세요.");
									return;
								}
								if (content === "") {
									alert("상품 설명을 입력해주세요.");
									return;
								}
								if (!region) {
									alert("거래 지역을 선택해주세요.");
									return;
								}
								if (!category) {
									alert("자동차 분류를 선택해주세요.");
									return;
								}

								$("form").submit();
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
