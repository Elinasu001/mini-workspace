<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>1번 게시판 | CarTalk</title>

    <style>
        .boardDetail {
            width: 1200px;
            height: 800px;
            margin: auto;
            align-content: center;
        }

        .boardDetailTable {
            margin: auto;
        }

        .boardDetailTable{
            border: 1px solid black;
            border-collapse: collapse;
        }

        #boardContent {
            background-color: aquamarine;
            width:100%;
            height:200px;
        }
        
        .trTopBorder{
        	border-top: 1px solid black;
        }
    </style>
</head>

<body>
    <div class="boardDetail">
        <table class="boardDetailTable">
            <thead>
                <tr>
                    <th>작성자</th>
                    <th>카테고리</th>
                </tr>
                <tr>
                    <td width="200">${ board.boardWriter }</td>
                    <td width="100">${ board.category }</td>
                </tr>
            </thead>
            <tbody class="mainBoard">
                <tr>
                    <td><input name="" value="${ board.boardTitle }" readonly style="margin-left: 100px;"></td>
                </tr>
                <tr>
                    <td><pre id="boardContent">${ board.boardContent }</pre></td>
                <tr>
                    <td><button style="margin-left: 50px;"><span>좋아요!</span><br />
                    									   <span>${ board.likes }</span></button></td>
                </tr>
                </tr>
                    <td><button>수정</button><button>삭제</button></td>

                <tr>
                	<c:choose>
                	<c:when test="${ board.attachment ne null }">
                    <td>첨부파일 <a href="${ board.attachment.filePath }/${board.attachment.changeName}" download="${board.attachment.changeName}">${ board.attachment.originName }</a></td>
                    </c:when>
                    <c:otherwise>
                    <td><span>첨부파일이 존재하지 않습니다.</span></td>
                    </c:otherwise>
                    </c:choose>
                </tr>
            </tbody>

            <thead>
                <tr>
                    <th>댓글 작성</th>
                </tr>
                <tr>
                    <td><textarea cols="50" rows="4" style="resize: none;" placeholder="댓글은 로그인 시에만 작성할 수 있습니다."></textarea></td>
                    <td><button onclick="insertReply()">댓글 등록</button></td>
                </tr>
            </thead>
            <tbody>
            	<c:choose>
            	<c:when test = "${ not empty board.replies }">
            	<c:forEach var="reply" items="${ board.replies }">
            	<tr class="trTopBorder">
            		<td>${ reply.replyContent }</td>
            		<td>${ reply.replyWriter }</td>
            		<td>${ reply.enrollDate }</td>
            	</tr>
            	
            	</c:forEach>
            	</c:when>
            	<c:otherwise>
            	<tr class="trTopBorder">
            	<td><span>댓글이 존재하지 않습니다.</span></td>
            	</tr>
            	</c:otherwise>
            	</c:choose>
                <tr class="trTopBorder">
                    <td><a href="">이전 글</a></td>
                    <td><a href="">다음 글</a></td>
                </tr>
            </tbody>

        </table>

    </div>




</body>

</html>