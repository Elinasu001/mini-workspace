<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/views/include/meta.jsp"/>
<title>이벤트 등록 | 관리자 전용</title>
<style>
    body {
        background-color: #f8f9fa;
    }
    
    .contentWrap .contArea.admin {
    	height:initial;
    	margin-top:80px;
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
</head>
<body>
<c:if test="${not empty alertMsg}">
    <script>alert("${alertMsg}");</script>
</c:if>
<div id="wrap">
	
	<jsp:include page="../include/header.jsp"/>
		
	 	<div class="contentWrap">
            <div class="contArea admin">
				<div class="admin-event-form">
				    <h2><i class="bi bi-calendar-plus"></i> 이벤트 등록</h2>
				
				    <form action="insert" method="post" enctype="multipart/form-data">
				        <!--  카테고리 -->
				        <div class="mb-4 ">
				            <label for="categoryNo" class="form-label">카테고리</label>
				            <select class="form-select" id="categoryNo" name="categoryNo" required>
				                <option value="">카테고리를 선택하세요</option>
				                <option value="1">시즌 이벤트</option>
				                <option value="2">회원 이벤트</option>
				                <option value="3">리뷰 이벤트</option>
				                <option value="4">출석 이벤트</option>
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
