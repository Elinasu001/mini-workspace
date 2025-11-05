<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/views/include/meta.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/event/insertForm.css">
<title>이벤트 등록 | 관리자 전용</title>
</head>
<body>

<div id="wrap">
	<jsp:include page="../include/header.jsp"/>
		
	 	<div class="contentWrap">
            <div class="contArea admin">
            	<!-- 상단 타이틀 -->
				<div class="text-center mb-5">
					<h2 class="fw-bold mb-3">이벤트 등록</h2>
					<p class="text-muted">이벤트 등록 페이지입니다.</p>
				</div>
            	
				<div class="admin-event-form">
				
				    <form action="insert" method="post" enctype="multipart/form-data">
				        <!--  카테고리 -->
				        <div class="mb-4 ">
				            <label for="categoryNo" class="form-label">카테고리</label>
				            <select id="categoryNo" class="form-select" name="category.categoryNo" required>
							  <option value="">카테고리를 선택하세요</option>
							  <c:forEach var="cat" items="${categoryList}">
							    <option value="${cat.categoryNo}">${cat.categoryName}</option>
							  </c:forEach>
							</select>


				        </div>
				
				        <!-- 제목 -->
				        <div class="mb-4">
				            <label for="title" class="form-label">제목</label>
				            <input type="text" id="title" name="eventTitle" class="form-control" placeholder="이벤트 제목을 입력하세요" required>
				        </div>
				
				        <!-- 내용 -->
				        <div class="mb-4">
				            <label for="content" class="form-label">내용</label>
				            <textarea id="content" name="eventContent" class="form-control" rows="6" placeholder="이벤트 내용을 입력하세요" required></textarea>
				        </div>
				
				        <!-- 썸네일 이미지 -->
				        <div class="mb-4">
				            <label class="form-label">썸네일 이미지 (FILE_LEVEL 0)</label>
				            <input type="file" name="thumbnail" class="form-control" accept="image/*" required>
				            <div class="form-text">※ 권장 크기: 600x400px / JPG, PNG 형식</div>
				        </div>
				
				        <!-- 상세 이미지 -->
				        <div class="mb-4">
				            <label class="form-label">상세 이미지 (FILE_LEVEL 1)</label>
				            <input type="file" name="detailImage" class="form-control" accept="image/*" required>
				            <div class="form-text">※ 상세 페이지용 이미지</div>
				        </div>
				
				        <!-- 시작일 -->
				        <div class="mb-4">
				            <label for="startDate" class="form-label">이벤트 시작일</label>
				            <input type="text" id="startDate" name="startDate" class="form-control datepicker" placeholder="YYYY-MM-DD" required>
				        </div>
				
				        <!-- 7종료일 -->
				        <div class="mb-4">
				            <label for="endDate" class="form-label">이벤트 종료일</label>
				            <input type="text" id="endDate" name="endDate" class="form-control datepicker" placeholder="YYYY-MM-DD" required>
				        </div>
				
				        <!-- 관리자만 등록 가능 -->
				        <div class="mb-4 text-muted small">
				            ※ 본 페이지는 <strong>관리자 전용</strong>으로, 일반 사용자는 접근할 수 없습니다.
				        </div>
				        
						<div class="d-flex justify-content-between gap-3 mt-5">
						    <button type="button" class="btn btn-secondary btn-cancel" onclick="history.back();">
						        뒤로가기
						    </button>
						    <button type="submit" class="btn btn-primary btn-submit">
						        등록하기
						    </button>
						</div>
				    </form>
				</div>
 			</div>
        </div>
        
		<jsp:include page="../include/footer.jsp"/>
	</div>

</body>
<script>
    // 날짜 선택기 초기화
    $(function(){
        $('.datepicker').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayHighlight: true,
            language: 'ko'
        });
    });
</script>
</html>
