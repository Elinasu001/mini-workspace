<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>중고 판매글 수정 | CarTalk</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/used/usedUpdateForm.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/include/meta.jsp" />
<jsp:include page="/WEB-INF/views/include/header.jsp" />

<main class="main-wrap">
	<h2>중고 판매글 수정</h2>

	<form action="${pageContext.request.contextPath}/used/update" method="post" enctype="multipart/form-data">

		<input type="hidden" name="usedNo" value="${used.usedNo}" />

		<!-- 제목 -->
		<div class="form-group">
			<label>제목</label>
			<input type="text" name="usedTitle" value="${used.usedTitle}" required>
		</div>

		<!-- 상태 -->
		<div class="form-group">
			<label>판매 상태</label>
			<select name="status" required>
				<option value="판매중" ${used.status eq '판매중' ? 'selected' : ''}>판매중</option>
				<option value="예약중" ${used.status eq '예약중' ? 'selected' : ''}>예약중</option>
				<option value="판매완료" ${used.status eq '판매완료' ? 'selected' : ''}>판매완료</option>
			</select>
		</div>

		<!-- 내용 -->
		<div class="form-group">
			<label>내용</label>
			<textarea name="usedContent" rows="6" required>${used.usedContent}</textarea>
		</div>

		<!-- 가격 -->
		<div class="form-group">
			<label>가격</label>
			<input type="number" name="usedPrice" value="${used.usedPrice}" required>
		</div>

		<!-- [추후 구현 예정] 이미지 수정 섹션 -->
		<%-- 
		<div class="form-group">
			<label>이미지 수정</label>
			
			<!-- 기존 이미지 미리보기 -->
			<c:if test="${not empty used.attachments}">
				<div class="current-images">
					<c:forEach var="img" items="${used.attachments}">
						<div class="image-item">
							<img src="${pageContext.request.contextPath}${img.filePath}/${img.changeName}" alt="등록된 이미지" width="120" height="80">
							<label>
								<input type="checkbox" name="deleteFiles" value="${img.fileNo}"> 삭제
							</label>
						</div>
					</c:forEach>
				</div>
			</c:if>

			<!-- 새 이미지 업로드 -->
			<input type="file" name="newFiles" multiple>
			<small class="text-muted">※ 이미지를 새로 업로드하면 기존 이미지와 함께 등록됩니다.</small>
		</div>
		--%>

		<!-- 등록 버튼 -->
		<div class="btn-group">
			<button type="submit" class="btn btn-primary">수정 완료</button>
			<a href="${pageContext.request.contextPath}/used/detail?no=${used.usedNo}" class="btn btn-secondary">취소</a>
		</div>

	</form>
</main>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />

</body>
</html>
