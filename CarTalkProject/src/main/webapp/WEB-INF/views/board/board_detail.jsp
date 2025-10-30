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
            width:200px;
            height:200px;
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
                    <td width="200">관리자</td>
                    <td width="100">자유</td>
                </tr>
            </thead>
            <tbody class="mainBoard">
                <tr>
                    <td><input name="" value="게시글 제목" readonly></td>
                </tr>
                <tr>
                    <td><pre id="boardContent">게시글 내용</pre></td>
                </tr>
                    <td><button>수정</button><button>삭제</button></td>

                <tr>
                    <td>첨부파일 <a href="" download="">원본파일명.txt</a></td>
                </tr>
            </tbody>

            <thead>
                <tr>
                    <th>댓글 작성</th>
                </tr>
                <tr>
                    <td><textarea cols="50" rows="4" style="resize: none;"></textarea></td>
                    <td><button onclick="insertReply()">댓글 등록</button></td>
                </tr>
            </thead>
            <tbody>


                <tr>
                    <td><a href="">이전 글</a></td>
                    <td><a href="">다음 글</a></td>
                </tr>
            </tbody>

        </table>

    </div>




</body>

</html>