<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>게시판 | CarTalk</title>
</head>
<style>
    .boardListPage {
        width: 1000px;
        height: 600px;
        margin: auto;
        align-content: center;
    }

    .boardPageButtons{
        display: flex;
        justify-content: center;
    }

    .boardListTable,
    tr {
        margin: auto;
        text-align: center;
    }

    .boardListTable,
    .boardListTable>*>*>th,
    .boardListTable>*>*>td {
        border: 1px solid black;
    }

    .boardListTable {
        border-collapse: collapse;
    }

    #boardList>*:hover{
        background-color: lightblue;
        cursor:pointer;
    }

    #boardSearchArea{
        margin-top: 20px;
        margin-left: 92px;
    }
</style>

<body>
    <div class="boardListPage">

        <table class="boardListTable" style="margin-bottom: 25px;">
            <thead id="boardCategory">
                <tr>
                    <th width="100"><a href="">자유 게시판</a></th>
                    <th width="100"><a href="">질문 게시판</a></th>
                    <th width="100"><a href="">정보 게시판</a></th>
                </tr>
            </thead>
        </table>

        <table class="boardListTable">
            <thead>
                <tr style="border: 1px solid gray;">
                    <th width="50">번호</th>
                    <th width="400">제목</th>
                    <th width="100">작성자</th>
                    <th width="80">조회수</th>
                    <th width="120">작성일</th>
                    <th width="50">좋아요수</th>
                </tr>
            </thead>
            <tbody id="boardList">
            <c:forEach var="board" items="${ map.boards }">
                <tr>
                    <td>${ board.boardNo }</td>
                    <td>${ board.boardTitle }</td>
                    <td>${ board.boardWriter }</td>
                    <td>${ board.viewCount }</td> 
                    <td>${ board.enrollDate }</td> 
                    <td>${ board.likes }</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div id="boardSearchArea">
            <div class="boardPageButtons">
            <button>이전</button>
            <c:forEach var="i" begin="${ map.pi.startPage }" end="${ map.pi.endPage }">
            <button onclick="location.href = 'board?page=${i}'">${i}</button>
            </c:forEach>
            <button>다음</button>
            </div>
            <form action="" method="get">
                <select name="condition">
                    <option>제목</option>
                    <option>내용</option>
                    <option>작성자</option>
                </select>
                <input name="query" value=""/>
            </form>
        </div>

    </div>
</body>

</html>