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
            width: 1200px;
            height: 800px;
            margin: auto;
            align-content: center;
            text-align: center;
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
            width:80%;
            height:200px;
        }
    </style>
</head>

<body>
    <div class="boardDetail">
    <form action="/ct/board/${ board.boardNo }/update" method="post" enctype="multipart/form-data">
        <table class="boardDetailTable">
            <thead>
                <tr>
                    <th width="500">작성자</th>
                </tr>
                <tr>
                    <td width="50">${ board.boardWriter }</td>
                </tr>
                <tr>
                    <td width="10">
                        카테고리
                        <select id="boardCategory" name="category">
                            <option value="1" id="자유">자유</option>
                            <option value="2" id="질문">질문</option>
                            <option value="3" id="정보">정보</option>
                        </select>
                    </td>
                </tr>
            </thead>
            <script>
            	$(function(){
                	$('#boardCategory option[id="${ board.category }"]').attr('selected', true);
            	});
            </script>
            
            <tbody class="mainBoard">
                <tr>
                    <td><input name="boardTitle" value="${ board.boardTitle }"></td>
                </tr>
                <tr>
                    <td><textarea name="boardContent" id="boardContent" style="resize: none;">${ board.boardContent }</textarea></td>
                </tr>
                <tr>
                <c:choose>
                <c:when test="${ board.attachment eq null and board.attachment.status ne 'N' }">
                    <td>첨부파일 <input type="file" name="boardUpfile"></td>
                </c:when>
                <c:otherwise>
                	<td>기존파일 : ${ board.attachment.originName } <input type="file" name="boardUpfile"></td>
                </c:otherwise>
                </c:choose>
                </tr>
                    <td><button type="submit">수정</button><button type="reset" onclick="history.back()">취소</button></td>

            </tbody>

        </table>
       </form>
    </div>




</body>

</html>