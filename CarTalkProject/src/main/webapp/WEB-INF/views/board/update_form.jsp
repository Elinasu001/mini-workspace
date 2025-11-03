<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <jsp:include page="../include/meta.jsp" />
    <title>게시글 작성 | CarTalk</title>
<style>
    
.boardDetail {
	width: 1000px;
	height: 1000px;
	margin: auto;
	align-content: center;
	text-align: center;
}


#boardContent {
	width: 800px; 
	height: 400px; 
	text-align: left; 
	padding: 25px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
	margin: 20px;
}

.labelFont {
	font-size: 20px;
	font-weight: 700;
}

#boardTitle:hover{
	cursor: text;
}
    </style>
</head>

<body>
<jsp:include page="../include/header.jsp" />
<div class="boardDetail">
		<div class="container border rounded">
		<form action="/ct/board/${ board.boardNo }/update" method="post" enctype="multipart/form-data">
			<div class="form-group my-2">
				<label class="labelFont">작성자</label> 
				<span>${ board.boardWriter }
                    <input type="hidden" name="boardWriter" value="${ sessionScope.loginMember.nickName }"/>
                </span>
			</div>

			<div class="form-group my-2">
				<label class="labelFont">카테고리</label> 
				    <select class="form-select w-auto mx-auto" name="category">
                            <option value="1" id="자유">자유</option>
                            <option value="2" id="질문">질문</option>
                            <option value="3" id="정보">정보</option>
                    </select>
            <script>
            	$(function(){
                	$('#boardCategory option[id="${ board.category }"]').attr('selected', true);
            	});
            </script>
			</div>

			<div class="form-group">
				<input name="boardTitle" id="boardTitle" class="form-control w-50 mx-auto" placeholder="게시글 제목을 입력하세요." value="${ board.boardTitle }"/>
			</div>

			<div class="form-group">
				<textarea class="mx-auto border rounded-3" id="boardContent" name="boardContent" style="resize: none;" placeholder="게시글 내용을 입력하세요.">${ board.boardContent }</textarea>
			</div>
			
			<div class="form-group my-2" style="text-align: left;">
			<label class="m-2 labelFont">첨부파일</label>
			<c:choose>
			<c:when test="${ board.attachment eq null and board.attachment.status ne 'N' }">
			 <input type="file" name="boardUpfile">
            </c:when>
			<c:otherwise>
            <label class="m-2">기존파일</label> : ${ board.attachment.originName } <input type="file" name="boardUpfile">
            </c:otherwise>
            </c:choose>

			</div>
			
			<div class="form-group my-2">
			    <button class="btn btn-primary" type="submit">수정</button>
                <button class="btn btn-primary" type="reset" onclick="history.back()">취소</button>
			</div>

    </form>
    </div>	
</div>
<jsp:include page="../include/footer.jsp" />
</body>

</html>