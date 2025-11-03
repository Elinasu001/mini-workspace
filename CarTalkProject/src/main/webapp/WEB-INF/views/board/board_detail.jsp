<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="../include/meta.jsp" />
<meta charset="UTF-8">
<title>1번 게시판 | CarTalk</title>

<style>
.boardDetail {
	width: 1000px;
	height: 1250px;
	margin: auto;
	align-content: center;
	text-align: center;
}


.boardReplyTable {
	border: 1px solid black;
	border-collapse: collapse;
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

.nav {
  display: flex;
  justify-content: space-between;
  align-items: center; 
  padding: 10px; 
}

#boardFile{
	color: blue;
	text-decoration : underline;
}

</style>
</head>

<body>
	<jsp:include page="../include/header.jsp" />
	<div class="boardDetail">
		<div class="container border rounded">
			<div class="form-group my-2">
				<label class="labelFont">작성자</label> 
				<span>${ board.boardWriter }</span>
			</div>

			<div class="form-group my-2">
				<label class="labelFont">카테고리</label> 
				<span>${ board.category }</span>
			</div>

			<div class="form-group">
				<input class="form-control w-50 mx-auto" value="${ board.boardTitle }" readonly>
			</div>

			<div class="form-group">
				<pre class="mx-auto border rounded-3" id="boardContent" style="">${ board.boardContent }</pre>
			</div>

			<div class="form-group">
				<c:choose>
					<c:when test="${ not empty sessionScope.loginMember }">
						<button class="btn btn-warning my-2" onclick="like()">
							<span>좋아요!</span><br /> <span class="likeNum">${ board.likes }</span>
						</button>
					</c:when>
					<c:otherwise>
						<button class="btn btn-warning my-2"
							onclick="return alert('로그인 후 시도해주세요.')">
							<span>좋아요!</span><br /> <span class="likeNum">${ board.likes }</span>
						</button>
					</c:otherwise>
				</c:choose>
			</div>
			<script>
                function like(){
                	const boardNo = ${board.boardNo};
                	$.ajax({
                		url : '/ct/board/like',
                		type : 'get',
                		data : {
                			boardNo : boardNo
                		},
                		success : function(response){
                			
                			if(response === 'success'){
                				alert('이 게시글에 좋아요를 누르셨습니다.');
                			} else {
                				alert('이 게시글에 누른 좋아요를 취소하셨습니다.');
                			}
                		}
                		
                	});
                	
                	selectInfo();
                }
                
                
                function selectInfo(){
                	
                	const boardNo = ${board.boardNo};
                	
                	$.ajax({
                		url : `/ct/board/\${boardNo}/refresh`,
                		type : 'get',
                		success : function(response){
                			console.log(response);
                			$('.likeNum').html(response.likes);
                			
                			if(response.replies !== null){
                			const str = response.replies.map(e => `
                													<tr>
																	<td>${ e.replyContent }</td>
																	<td>${ e.replyWriter }</td>
																	<td>${ e.enrollDate }</td>
																	</tr>
                												  `).join('');
                				
                				$('#reply-area').html(str);
                				
                				};
                			}
                	});
                	
                }
                
                </script>
			<div class="form-group boardButtons">
				<c:if
					test="${ sessionScope.loginMember.nickName eq board.boardWriter }">
					<button class="btn btn-outline-primary" onclick="location.href = '/ct/board/${board.boardNo}/edit'">수정</button>
					<button class="btn btn-outline-primary" onclick="deleteBoard()">삭제</button>
				</c:if>
				<script>
                    	function deleteBoard(){
                    		const value = confirm('정말로 삭제하시겠습니까?');;
                    		
                    		if(value){
                        		location.href='/ct/board/${board.boardNo}/delete';
                    		}
                    	}
                    
                    </script>
			</div>

			<div class="form-group my-2">
				<c:choose>
					<c:when
						test="${ board.attachment ne null and board.attachment.status ne 'N' }">
							첨부파일 
							<a id="boardFile"
							href="${ board.attachment.filePath }/${board.attachment.changeName}"
							download="${board.attachment.changeName}">${ board.attachment.originName }</a>
					</c:when>
					<c:otherwise>
						<span>첨부파일이 존재하지 않습니다.</span>
					</c:otherwise>
				</c:choose>
			</div>

			<div class="form-group">
				<c:choose>
					<c:when test="${ sessionScope.loginMember ne null }">
						<form>
							<div class="form-floating">
								<textarea cols="50" rows="4" style="resize: none;"
									id="replyContent" placeholder="댓글을 작성하세요." required="required"></textarea>
								<button class="btn btn-secondary" onclick="insertReply()">댓글
									등록</button>
							</div>
							<script>
                	// 미구현 AJAX로 댓글 비동기 등록
                	function insertReply(){
                		
                		const boardNo = ${ board.boardNo };
                		const replyContent = document.getElementById("replyContent").value;
                		
                		$.ajax({
                			url : 'replies',
                			type : 'post',
                			data : {
                				refBno : boardNo,
                				replyContent : replyContent
                			},
                			success : function(response){
                				
                				if(response === 'success'){
                					alert('댓글 작성 성공');
                				} else {
                					alert('댓글 작성 실패, 다시 시도해주세요');
                				}
                				
                			}
                			
                		});
                		selectInfo();
                	}
                </script>
						</form>
					</c:when>
					<c:otherwise>
							댓글 작성
							<textarea cols="50" rows="4" style="resize: none;"
							placeholder="댓글은 로그인 시에만 작성할 수 있습니다." readonly="readonly"></textarea>

					</c:otherwise>
				</c:choose>
			</div>
			
			<div class="form-group">
			<script>
				function updateReply(num){
					
					const boardNo = ${board.boardNo};
					const replyContent = document.getElementById("replyContent").value;
					const replyNo = num;
					
					console.log(replyNo);
					
					$.ajax({
						url : 'updateReply',
						type : 'post',
						data : {
							replyNo : replyNo,
               				refBno : boardNo,
               				replyContent : replyContent,
						},
						success : function(response){
               				if(response === 'success'){
               					alert('댓글 수정 성공');
               				} else {
               					alert('댓글 수정 실패, 다시 시도해주세요');
               				}
							
						}
						
					});
					
					selectInfo();
				}
		
			</script>
			<table class="boardReplyTable">
			<tbody id="reply-area">
				<c:choose>
					<c:when test="${ not empty board.replies }">
						<c:forEach var="reply" items="${ board.replies }">
						<tr class="border border-top">
							<td>${ reply.replyContent }</td>
							<td>${ reply.replyWriter }</td>
							<td>${ reply.enrollDate }</td>
								<c:if test="${ reply.replyWriter eq sessionScope.loginMember.nickName }">
								<td>
								<button class="btn btn-secondary" onclick="updateReply(${reply.replyNo})">수정하기</button>
								<button class="btn btn-danger" onclick="deleteReply()">삭제</button>
								</td>

								</c:if>
						</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
					<tr id="reply-area" class="border border-top">
							<td><span>댓글이 존재하지 않습니다.</span></td>
					</tr>
					</c:otherwise>
				</c:choose>

				
			</tbody>
			</table>
			</div>
			
			<div class="nav form-group">
					<button class="btn btn-primary">이전 글</button>
					<button class="btn btn-primary">다음 글</button>
			</div>

		</div>
	</div>




	<jsp:include page="../include/footer.jsp" />

</body>

</html>