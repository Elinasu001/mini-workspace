<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                    <th width="50">댓글수</th>
                </tr>
            </thead>
            <tbody id="boardList">
                <tr>
                    <td>1</td>
                    <td>게시판 이용 수칙</td>
                    <td>관리자</td>
                    <td>1</td>
                    <td>2025-10-27</td>
                    <td>0</td>
                </tr>

            </tbody>
        </table>
        <div id="boardSearchArea">
            <div class="boardPageButtons">
            <button>이전</button>
            <button>1</button>
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