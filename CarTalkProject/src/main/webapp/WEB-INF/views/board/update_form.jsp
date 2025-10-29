<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <table class="boardDetailTable">
            <thead>
                <tr>
                    <th width="500">작성자</th>
                </tr>
                <tr>
                    <td width="50">관리자</td>
                </tr>
                <tr>
                    <td width="10">
                        카테고리
                        <select name="condition">
                            <option>자유</option>
                            <option>질문</option>
                            <option>정보</option>
                        </select>
                    </td>
                </tr>
            </thead>
            <tbody class="mainBoard">
                <tr>
                    <td><input name="" value="게시글 제목"></td>
                </tr>
                <tr>
                    <td><textarea id="boardContent" style="resize: none;">게시글 내용</textarea></td>
                </tr>
                <tr>
                    <td>첨부파일 <input type="file"></td>
                </tr>
                    <td><button>수정</button><button>취소</button></td>

            </tbody>

        </table>

    </div>




</body>

</html>