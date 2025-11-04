<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
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

        .boardDetailTable {
            border: 1px solid black;
            border-collapse: collapse;
        }

        #boardContent {
            background-color: aquamarine;
            width: 80%;
            height: 200px;
        }
    </style>
</head>

<body>
    <div class="boardDetail">
    <form action="/ct/board" method="post" enctype="multipart/form-data">
        <table class="boardDetailTable">
            <thead>
                <tr>
                    <th width="500">작성자</th>
                </tr>
                <tr>
                    <td width="50">${ sessionScope.loginMember.nickName }
                    <input type="hidden" name="boardWriter" value="${ sessionScope.loginMember.nickName }"/>
                    </td>
                </tr>
                <tr>
                    <td width="10">
                        카테고리
                        <select name="category">
                            <option value="1">자유</option>
                            <option value="2">질문</option>
                            <option value="3">정보</option>
                        </select>
                    </td>
                </tr>
            </thead>
            <tbody class="mainBoard">
                <tr>
                    <td><input name="boardTitle" value="게시글 제목"></td>
                </tr>
                <tr>
                    <td><textarea id="boardContent" name="boardContent" style="resize: none;">게시글 내용</textarea></td>
                </tr>
                <tr>
                    <td>첨부파일<input type="file" name="boardUpfile"></td>
                </tr>
                <td>
                <button type="submit">등록</button>
                <button type="reset" onclick="history.back()">취소</button>
                </td>

            </tbody>

        </table>
    </form>
    </div>




</body>

</html>