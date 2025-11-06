<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/views/include/meta.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/event/updateForm.css">
<title>이벤트 수정</title>
</head>
<body>
<c:if test="${empty sessionScope.loginMember or sessionScope.loginMember.role ne 'ADMIN'}">
    <script>
        alert("관리자만 접근 가능한 페이지입니다.");
        location.href = "${pageContext.request.contextPath}/main";
    </script>
</c:if>
<div id="wrap">
	<jsp:include page="../include/header.jsp"/>
	
	<div class="contentWrap">
		<div class="contArea admin">
			
			<!-- 상단 타이틀 -->
			<div class="text-center mb-5">
				<h2 class="fw-bold mb-3">이벤트 수정</h2>
				<p class="text-muted">등록된 이벤트 내용을 수정합니다.</p>
			</div>
			<div class="admin-event-form">
				<!-- 수정 폼 시작 -->
				<form id="updateForm" 
					  action="${pageContext.request.contextPath}/event/update" 
					  method="post" 
					  enctype="multipart/form-data" 
					  class="border rounded-3 p-5 shadow-sm bg-white">
	
					<input type="hidden" name="eventNo" value="${event.eventNo}" />
	
					<!-- 제목 -->
					<div class="mb-4">
						<label class="form-label fw-semibold">이벤트 제목</label>
						<input type="text" class="form-control" name="eventTitle" 
							   required value="${event.eventTitle}">
					</div>
	
					<!-- 카테고리 -->
					<div class="mb-4">
					   <label class="form-label fw-semibold">카테고리</label>
					   <select class="form-select" name="category.categoryNo"  required>
				    	<option value="">카테고리를 선택하세요</option>
					    <c:forEach var="cat" items="${categoryList}">
					      <option value="${cat.categoryNo}"
					        <c:if test="${cat.categoryNo == event.category.categoryNo}">selected</c:if>>
					        ${cat.categoryName}
					      </option>
					    </c:forEach>
					  </select>
					</div>
	
					<!-- 시작일 -->
			        <div class="mb-4">
			            <label for="startDate" class="form-label">이벤트 시작일</label>
			            <input type="text" id="startDate" name="startDate" value="${event.startDate}" class="form-control datepicker" required>
			        </div>
			
			        <!-- 7종료일 -->
			        <div class="mb-4">
			            <label for="endDate" class="form-label">이벤트 종료일</label>
			            <input type="text" id="endDate" name="endDate" value="${event.endDate}"  class="form-control datepicker" placeholder="YYYY-MM-DD" required>
			        </div>
	
					<!-- 썸네일 -->
					<div class="mb-4">
					  <label class="form-label fw-semibold">대표 이미지 (썸네일)</label>
					  <div class="fileInput">
					      <input type="file" id="thumbnailInput" class="form-control" name="thumbnail" accept="image/*">
					      
					      <!-- 파일 이름 표시용 -->
						  <label for="thumbnailInput" id="thumbnailName" class="form-label">
						    <c:choose>
						      <c:when test="${not empty event.thumbnailName}">${event.thumbnailName}</c:when>
						      <c:otherwise>선택된 파일이 없습니다.</c:otherwise>
						    </c:choose>
						  </label>
					  </div>
					  <small class="text-muted d-block py-3"">
						※ 새 이미지를 선택하지 않으면 기존 이미지가 유지됩니다.
					  </small>
					  <div id="thumb-preview" class="mt-2"> 
						  <c:if test="${not empty event.thumbnailName}">
							  <img src="${pageContext.request.contextPath}${event.thumbnailPath}${event.thumbnailName}" 
							       alt="기존 썸네일"
							       style="width:140px;height:140px;object-fit:cover"
							       class="border rounded">
						  </c:if>
						</div>
					</div>
	
					<!-- 상세 이미지 -->
					<div class="mb-4">
					  <label class="form-label fw-semibold">상세 이미지</label>
					  <div class="fileInput">
						  <input type="file" id="detailInput"  class="form-control" name="detailImage" accept="image/*">
						  <!-- 파일 이름 표시 -->
						  <label for="detailInput" id="detailName"  class="form-label">
						    <c:choose>
						      <c:when test="${not empty event.detailName}">${event.detailName}</c:when>
						      <c:otherwise>선택된 파일이 없습니다.</c:otherwise>
						    </c:choose>
						  </label>
				      	</div>
				      
					  <small class="text-muted d-block py-3">
						※ 새 이미지를 선택하지 않으면 기존 상세 이미지가 유지됩니다.
					  </small>
					    <div id="detail-preview" class="mt-2">
					      	<c:if test="${not empty event.detailName}">
							  <img src="${pageContext.request.contextPath}${event.detailPath}${event.detailName}" 
							       alt="기존 상세 이미지"
							       style="width:140px;height:140px;object-fit:cover"
							       class="border rounded">
							</c:if>
					    </div>
					</div>
	
					<!-- 내용 -->
					<div class="mb-4">
						<label class="form-label fw-semibold">이벤트 내용</label>
						<textarea class="form-control" name="eventContent" rows="8" required>
	${event.eventContent}
						</textarea>
					</div>
	
					<!-- 버튼 -->
					<div class="d-flex justify-content-between gap-2 mt-5">
						<a href="javascript:history.back();" 
						   class="btn btn-outline-secondary px-4">이전으로</a>
						<div class="flex">
							<a href="${pageContext.request.contextPath}/event/delete?eventNo=${event.eventNo}" 
					         class="btn btn-danger"
					         data-bs-toggle="modal" 
            				 data-bs-target="#deleteConfirmModal"
					         data-event-no="${event.eventNo}">삭제하기</a>
							<button type="submit" class="btn btn-primary">수정 완료</button>
						</div>
					</div>
	
				</form>
			</div>
			<!-- 수정 폼 끝 -->
		</div>
	</div>
	
	<jsp:include page="../include/footer.jsp"/>
</div>

<!-- //삭제하기 모달 -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content ">
      <div class="modal-header">
        <h5 class="modal-title" id="deleteModalLabel">이벤트 삭제 확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        정말로 이 이벤트를 "삭제"하시겠습니까? <br>
        삭제된 이벤트는 되돌릴 수 없습니다.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">취소</button>
        <a id="modalDeleteLink" href="#" class="btn btn-danger">삭제 진행</a>
      </div>
    </div>
  </div>
</div>
<!-- //삭제하기 모달 -->
</body>

<script>
$(function() {
	
	  // 날짜 선택기 초기화
	  $('.datepicker').datepicker({
	    format: 'yyyy-mm-dd',
	    autoclose: true,
	    todayHighlight: true,
	    language: 'ko'
	  });

	  // 썸네일 미리보기
	  $('#thumbnailInput').on('change', function() {
	    showPreview(this, '#thumb-preview', '#thumbnailName');
	  });

	  // 상세 이미지 미리보기
	  $('#detailInput').on('change', function() {
	    showPreview(this, '#detail-preview', '#detailName');
	  });

	  //파일 선택 시 즉시 이미지 미리보기
	  function showPreview(input, previewSelector, nameSelector) {
		  const file = input.files[0];
		  const $preview = $(previewSelector);
		  const $name = $(nameSelector);
		
		  if (!file) {
		    $name.text('선택된 파일이 없습니다.');
		    $preview.html('<div class="no-image">이미지 없음</div>');
		    return;
		  }
		  
		  // 파일명 표시
		  $name.text(file.name);
		
		  // 이미지 아닌 경우 방어
		  if (!file.type.startsWith('image/')) {
		    alert('이미지 파일만 선택 가능합니다.');
		    $(input).val('');
		    return;
		  }
		  
		  // blob URL 생성
		  const blobUrl = URL.createObjectURL(file);
		
		  // 미리보기 이미지 생성
		  const img = document.createElement("img");
		  img.src = blobUrl;
		  img.alt = "미리보기";
		  img.className = "preview-img border rounded";
		
		  // 기존 내용 지우고 교체
		  $preview.empty().append(img);
		}


	  // 삭제하기 (모달)
	  const contextPath = "${pageContext.request.contextPath}";
	  $('#deleteConfirmModal').on('show.bs.modal', function (event) {
	    const button = $(event.relatedTarget);
	    const eventNo = button.data('event-no');
	    const deleteLink = contextPath + "/event/delete?eventNo=" + eventNo;
	    $('#modalDeleteLink').attr('href', deleteLink);
	  });

	});

</script>

</html>
