<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>사진게시판-상세페이지 | CarTalk</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/used/usedList.css">
  <style>
    :root{
      --bg:#f5f7fa; --card:#fff; --accent:#3b82f6; --muted:#6b7280; --radius:12px;
      --maxw:880px;
      font-family: Inter, "Noto Sans KR", system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
    }
    *{box-sizing:border-box}
    body{margin:0;background:var(--bg);color:#111;line-height:1.6;padding:36px 20px;}

    .post-card{
      width:100%;max-width:var(--maxw);background:var(--card);border-radius:var(--radius);box-shadow:0 6px 20px rgba(16,24,40,0.08);overflow:hidden;
    }
    .wrapper { display: flex; justify-content: center;}

    /* 상단 제목 영역 */
    .post-header{padding:28px 32px;border-bottom:1px solid #eef2f7}
    .title-row{display:flex;flex-direction:column;gap:10px}
    .post-title{font-size:1.6rem;font-weight:700;color:#0f172a;margin:0}

    .meta-row{display:flex;flex-wrap:wrap;gap:12px;align-items:center;font-size:0.95rem;color:var(--muted)}
    .meta-item{display:inline-flex;align-items:center;gap:8px;background:rgba(15,23,42,0.02);padding:6px 10px;border-radius:999px}
    .meta-item .label{font-weight:600;color:#111}

    /* 본문 영역 */
    .post-body{padding:26px 32px;display:flex;flex-direction:column;gap:18px}
    .post-body p{margin:0;font-size:1rem;color:#111}

    /* 이미지 스타일 — 본문 흐름에 따라 배치 */
    .content-image{
      width:100%;max-width:100%;height:auto;border-radius:10px;display:block;object-fit:cover;border:1px solid rgba(15,23,42,0.04)
    }

    figure{margin:0}
    figcaption{font-size:0.9rem;color:var(--muted);margin-top:6px}

    /* 작은 화면에서 여백 조정 */
    @media (max-width:640px){
      body{padding:18px 12px}
      .post-header{padding:20px}
      .post-body{padding:18px}
      .post-title{font-size:1.25rem}
    }

    /* 보조: 태그 / 동작 영역 하단 (선택) */
    .post-footer{padding:18px 32px;border-top:1px solid #eef2f7;display:flex;justify-content:space-between;gap:12px;align-items:center}
    .actions{display:flex;gap:10px}
    .btn{border:0;padding:8px 12px;border-radius:8px;background:#f1f5f9;color:#0f172a;font-weight:600;cursor:pointer}
    .btn.primary{background:var(--accent);color:white}
  </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/meta.jsp" />
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div class="wrapper">
  <article class="post-card" aria-labelledby="post-title">
    <div class="post-header">
      <div class="title-row">
        <h1 id="post-title" class="post-title">${gallery.galleryTitle}</h1>
        <div class="meta-row" aria-hidden="false">
          <div class="meta-item"><span class="label">작성자</span><span>${gallery.nickname}</span></div>
          <div class="meta-item"><span class="label">조회수</span><span>${gallery.viewCount}</span></div>
          <div class="meta-item"><span class="label">등록일</span><span>${gallery.enrollDate}</span></div>
          <div class="meta-item"><span class="label">분류</span><span>${gallery.categoryName}</span></div>
        </div>
      </div>
    </div>

		<section class="post-body">
			<c:choose>
				<c:when test="${not empty gallery}">
					<c:forEach var="attachment" items="${gallery.attachments}">
						<figure>
							<!-- changeName을 사용하여 이미지 파일 경로를 출력합니다 -->
							<img src="${attachment.filePath}/${attachment.changeName}"
								alt="attachment image"
								>
						</figure>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p>사진이 존재하지 않습니다</p>
				</c:otherwise>
			</c:choose>

			<p>${gallery.galleryContent}</p>
		</section>
		
		<c:if test="${ sessionScope.loginMember.nickName eq gallery.nickname }">
			<div class="meta-row">
				<div class="meta-item">
					<a href="${pageContext.request.contextPath}/gallery/${gallery.galleryNo}/form" class="btn-update">수정하기</a>
				</div>
				<div class="meta-item">
					<button onclick="deleteGallery(${gallery.galleryNo})" class="btn-delete">삭제하기</button>
				</div>
			</div>
		</c:if>
		<script>
           	function deleteGallery(galleryNo){
           		const value = confirm('정말로 삭제하시겠습니까?');
           		
           		if(value){
               		location.href=`/ct/gallery/\${galleryNo}/delete`;
           		}
           	}
                    
        </script>
		
		<div class="post-footer">
      <div class="actions">
      <form action="/ct/gallery/${gallery.galleryNo}/reply" method="post">
        <table id="replyArea" class="table" align="center">
                <thead>
                     <tr>
				        <th colspan="2">
				          <textarea class="form-control" name="replyContent" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
				        </th>
				        <th style="vertical-align:middle">
				          <button type="submit" class="btn btn-secondary">등록하기</button>
				        </th>
				      </tr>
                    
                    <tr>
                        <td colspan="3">댓글(<span id="rcount">${ gallery.replyCount }</span>)</td>
                    </tr>
                </thead>
                <tbody>
                  
                  	<c:choose>
                  	<c:when test="${ not empty gallery.replies }">
                  	<c:forEach items="${ gallery.replies }" var="reply">
                    <tr>
                        <th>${ reply.replyWriter } :</th>
                        <td>${ reply.replyContent }</td>
                        <td>${ reply.enrollDate }</td>
                    </tr>
                    </c:forEach>
                    </c:when>
                    <c:otherwise>
						<tr>
							<th colspan="3">댓글이 없습니다.</th>
						</tr>                    
                    </c:otherwise>
                    </c:choose>
                    
                </tbody>
            </table>
      </div>
    </div>
  </article>
  </div>
  	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
