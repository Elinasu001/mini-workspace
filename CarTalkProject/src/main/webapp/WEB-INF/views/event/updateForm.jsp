<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/views/include/meta.jsp"/>
<title>이벤트 수정</title>
</head>

<style>
    body {
        background-color: #f8f9fa;
    }
    
    .contentWrap .contArea.admin {
    	height:initial;
    	margin-top:60px;
    	margin-bottom:100px;
    }
    .admin-event-form {
        max-width: 900px;
        margin:0 auto;
        padding: 80px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
       
    }

    .admin-event-form h2 {
        font-weight: 700;
        color: #333;
        margin-bottom: 30px;
        border-bottom: 3px solid #0d6efd;
        padding-bottom: 10px;
    }

    /* 폼 라벨 */
    .form-label {
        font-size: var(--font18);
        line-height: 1.5;
        font-weight: 600;
        margin-bottom: 8px;
    }

    /* 인풋/셀렉트 높이 확장 */
	.form-control, 
	.form-select {
	    height: 64px !important;
	    font-size: 18px;
	    padding: 0 1rem;
	    border-radius: 10px;
	}
	
	/* 텍스트에어리어는 별도로 더 넓게 */
	textarea.form-control {
	    min-height: 260px;
	    line-height: 1.6;
	    padding: 15px 18px;
	    resize: vertical;
	}
	input[type="file"].form-control {
		padding: 0 1rem 0 0;
	
	}
	input[type="file"]::file-selector-button {
	    height: 68px !important;
	    border: none;
	    padding: 0 20px;
	    margin-right: 15px;
	    border-radius: 8px 0 0 8px;
	    color:var(--ipt-txt);
	    font-weight:var(--font-w-b);
	    cursor: pointer;
	}
	
    /* 버튼 */
    .btn-submit {
        width: 100%;
        font-weight: 600;
        padding: 14px;
        font-size: 18px;
        border-radius: 8px;
    }

    @media (max-width: 767px) {
        .admin-event-form {
            padding: 25px 20px;
        }
        .form-control, .form-select {
            height: 48px;
            font-size: 16px;
        }
        textarea.form-control {
            height: 180px;
        }
    }
    
    /* 입력창 스타일 통일 */
	.form-control.datepicker {
	    position: relative;
	    border: 1px solid #ced4da;
	    border-radius: 10px;
	    font-size: 18px;
	    padding: 12px 18px;
	    height: 64px;
	    transition: all 0.2s ease-in-out;
	}
	
	/* hover / focus 시 효과 */
	.form-control.datepicker:hover {
	    background-color: #f1f3f5;
	    cursor: pointer;
	}
	
	.form-control.datepicker:focus {
	    border-color: #0d6efd;
	    box-shadow: 0 0 0 0.25rem rgba(13,110,253,.25);
	    background-color: #fff;
	}
	
	/* 달력 팝업 컨테이너 */
	.datepicker-dropdown {
	    border-radius: 10px !important;
	    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
	    border: 1px solid #dee2e6 !important;
	    background-color: #fff !important;
	    font-size: 16px;
	    padding: 10px !important;
	}
	
	/* 헤더(월·년도 표시 줄) */
	.datepicker .datepicker-switch {
	    font-weight: 600;
	    color: #0d6efd;
	    text-align: center;
	}
	
	.datepicker .datepicker-switch:hover {
	    background-color: #e9ecef !important;
	    border-radius: 6px;
	}
	
	/* 요일 텍스트 */
	.datepicker thead th {
	    color: #6c757d;
	    font-weight: 600;
	}
	
	/* 날짜 셀 기본 */
	.datepicker table tr td, 
	.datepicker table tr th {
	    width: 42px;
	    height: 42px;
	    text-align: center;
	    border-radius: 6px;
	    transition: all 0.15s ease-in-out;
	}
	
	/* hover */
	.datepicker table tr td:hover {
	    background-color: #f1f3f5;
	    cursor: pointer;
	}
	
	/* 오늘 날짜 강조 */
	.datepicker table tr td.today {
	    background-color: #e7f1ff !important;
	    color: #0d6efd !important;
	    font-weight: 700;
	    border: 1px solid #0d6efd !important;
	}
	
	/* 선택된 날짜 */
	.datepicker table tr td.active,
	.datepicker table tr td.active:hover {
	    background-color: #0d6efd !important;
	    color: #fff !important;
	    font-weight: 600;
	}
	
	/* 이전/다음 달 날짜 (연한색 처리) */
	.datepicker table tr td.old,
	.datepicker table tr td.new {
	    color: #adb5bd !important;
	}
	
	/* 달력 상단 화살표 버튼 */
	.datepicker .prev, .datepicker .next {
	    color: #0d6efd !important;
	    font-size: 18px;
	}
	
	.datepicker .prev:hover, .datepicker .next:hover {
	    background-color: #e9ecef !important;
	    border-radius: 50%;
	}
	
	/* 달력 아래쪽 오늘/닫기 버튼 */
	.datepicker .datepicker-days tfoot th {
	    text-align: center;
	    font-size: 15px;
	    font-weight: 500;
	    color: #0d6efd;
	    cursor: pointer;
	}
	
	.datepicker .datepicker-days tfoot th:hover {
	    background-color: #e9ecef !important;
	    border-radius: 6px;
	}
	    	
</style>
<body>

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
					  <input type="file" class="form-control" name="thumbnail" accept="image/*">
					  <small class="text-muted d-block py-3"">
						※ 새 이미지를 선택하지 않으면 기존 이미지가 유지됩니다.
					  </small>
					  <c:if test="${not empty event.thumbnailName}">
						  <img src="${pageContext.request.contextPath}${event.thumbnailPath}${event.thumbnailName}" 
						       alt="기존 썸네일"
						       style="width:140px;height:140px;object-fit:cover"
						       class="border rounded">
						</c:if>
					</div>
	
					<!-- 상세 이미지 -->
					<div class="mb-4">
					  <label class="form-label fw-semibold">상세 이미지</label>
					  <input type="file" class="form-control" name="detailImage" accept="image/*">
					  <small class="text-muted d-block py-3">
						※ 새 이미지를 선택하지 않으면 기존 상세 이미지가 유지됩니다.
					  </small>
					    <div class="mt-2">
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
					<div class="d-flex justify-content-end gap-2 mt-5">
						<a href="javascript:history.back();" 
						   class="btn btn-outline-secondary px-4">이전으로</a>
						<a href="${pageContext.request.contextPath}/event/delete?eventNo=${event.eventNo}" 
				         class="btn btn-danger px-5 py-2 ms-2"
				         onclick="return confirm('정말 이 이벤트를 삭제하시겠습니까?');">삭제하기</a>
						<button type="submit" class="btn btn-primary px-5">수정 완료</button>
					</div>
	
				</form>
			</div>
			<!-- 수정 폼 끝 -->
		</div>
	</div>

	<jsp:include page="../include/footer.jsp"/>
</div>
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
  $('input[name="thumbnail"]').on('change', function(e) {
    previewImage(this, '#thumb-preview');
  });

  // 상세 이미지 미리보기
  $('input[name="detailImage"]').on('change', function(e) {
    previewImage(this, '#detail-preview');
  });

  // 공용 함수: 미리보기 처리
  function previewImage(input, previewSelector) {
    const file = input.files[0];
    const $preview = $(previewSelector);
    $preview.empty(); // 기존 미리보기 초기화

    // 파일이 선택되지 않은 경우
    if (!file) {
      $preview.html(`
        <div class="border rounded mt-2 d-flex align-items-center justify-content-center"
             style="width:140px;height:140px;background:#f8f9fa;color:#aaa;font-size:13px;">
          이미지 없음
        </div>
      `);
      return;
    }

    // 이미지 파일인지 확인
    if (!file.type.startsWith("image/")) {
      alert("이미지 파일만 선택할 수 있습니다.");
      $(input).val(""); // 입력값 초기화
      return;
    }

    // FileReader로 이미지 읽기
    const reader = new FileReader();
    reader.onload = function(e) {
      const imgTag = `
        <img src="${e.target.result}"
             alt="미리보기"
             class="border rounded mt-2"
             style="width:140px;height:140px;object-fit:cover;">
      `;
      $preview.html(imgTag);
    };
    reader.readAsDataURL(file);
  }

});
</script>

</html>
