<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
<style type="">
	#hobby-wrap{
	    display: flex;
	    justify-content: center;
	    flex-direction: row;
	    flex-wrap: nowrap;
	    align-items: baseline;
	}
	input[type=checkbox]{
		margin-left : 50px;
	}
	.signBtn1 {
	    background-color: lightblue;
	    color: black;
	    padding: 10px 20px;
	    border: none; /* 테두리 없음 */
	    border-radius: 5px; /* 테두리 둥글게 */
	    font-size: 18px; /* 글자 크기 */
	    width: 200px;   /* 너비 고정 */
   		height: 40px;   /* 높이 고정 */
    	text-align: center; /* 텍스트 정렬 */
    }
    .signBtn2 {
	    background-color: red;
	    color: black;
	    padding: 10px 20px;
	    border: none; /* 테두리 없음 */
	    border-radius: 5px; /* 테두리 둥글게 */
	    font-size: 18px; /* 글자 크기 */
	    width: 200px;   /* 너비 고정 */
   		height: 40px;   /* 높이 고정 */
    	text-align: center; /* 텍스트 정렬 */
    }
</style>

<script >
$( document ).ready(function() {
	var joinBt = $("#joinBt");

	joinBt.click(saveBt);
	
	var today = currentDate();
	var todaytime = currentTime();
	$("#enrollDate").val(today + " " + todaytime);
});


saveBt = function() {
	// alert("회원가입");
	
	var userid = $("#user_id").val();
	var userpw = $("#user_pw").val();
	var userName = $("#user_name").val();
	var nickname = $("#nickname").val();
	var email = $("#email").val();
	
	if(userid == ''){
		alert('아이디를 입력하세요');
		return;
	}
	
	if(userpw == ''){
		alert('암호를 입력하세요');
		return;
	}
	
	if(userName == ''){
		alert('이름을 입력하세요');
		return;
	}
	
	if(nickname == ''){
		alert('닉네임 입력하세요');
		return;
	}
	
	if(email == ''){
		alert('이메일 입력하세요');
		return;
	}
	
	let dataSet = JSON.stringify({  
          "userId" : userid
        , "userPwd" : userpw
        , "userName" : userName
        , "nickname" : nickname
        , "email" : email
    });
	// alert(dataSet);
    callSend("joinUp", dataSet);
	
};

currentDate = function () {
	const now = new Date();
	const year = now.getFullYear();
	const month = now.getMonth() + 1; // getMonth()는 0부터 시작하므로 1을 더함
	const date = now.getDate();
	
	const hours = now.getHours();
	const minutes = now.getMinutes();
	const seconds = now.getSeconds();
	
	const formattedDate = year+"/"+formatTwoDigits(month)+"/"+formatTwoDigits(date);

	return formattedDate;
}

currentTime = function () {
	const now = new Date();
		
	const hours = now.getHours();
	const minutes = now.getMinutes();
	const seconds = now.getSeconds();
	
	
	const time = formatTwoDigits(hours) + " : " + formatTwoDigits(minutes) + " : " +formatTwoDigits(seconds);
	return time;
}

formatTwoDigits = function(num) {
    return num < 10 ? '0' + num : num;
}

callSend = function (actUrl , dataSet) {
	//alert('아작스');
	$.ajax({
	    type : 'post',           // 타입 (get, post, put 등등)
	    url : actUrl,           // 요청할 서버url
	    async : true,            // 비동기화 여부 (default : true)
	    headers : {              // Http header
	      "Content-Type" : "application/json",
	      "X-HTTP-Method-Override" : "POST"
	    },
	    dataType : 'json',       // 데이터 타입 (html, xml, json, text 등등)
	    data : dataSet ,
	    success : function(result) { // 결과 성공 콜백함수
	    	// console.log ( JSON.stringify(result));
	    	if (result == "1") {
	    		alert("가입되었습니다. 로그인해주세요.");
	    		window.location.href = '/ct';
	    	} else {
	    		alert("정확한 내용을 입력해주세요.");
	    		return;
	    	}
	    	
	    },
	    error : function(request, status, error) { // 결과 에러 콜백함수
	        // console.log(error);
	        alert("오류가 발생하였습니다.");
	        return;
	    }
	})
		
}
</script>

</head>
<body >
<jsp:include page="/WEB-INF/views/include/meta.jsp" />
<jsp:include page="../include/header.jsp"/>

	<div style="width : 80%; margin : auto; padding : 50px;">
		<table
			style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
			<tr>
				<td style="text-align: left">
					<p><strong>아이디를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="idChk"></span></p>
				</td>							
			</tr>
			<tr>
				<td><input type="text" name="" id="user_id"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
					placeholder="숫자와 영어로 4-30자">
					</td>
			</tr>
			<tr>
				<td style="text-align: left">
					<p><strong>비밀번호를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk"></span></p>
				</td>
			</tr>
			<tr>
				<td><input type="password" maxlength="30" name="" id="user_pw"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
					placeholder="비밀번호를 입력하세요">
					</td>
			</tr>
			<tr>
			<td style="text-align: left">
					<p><strong>실명을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="nameChk"></span></p>
				</td>
			</tr>
			<tr>
				<td><input type="name" maxlength="30" name="" id="user_name"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
					placeholder="이름을 입력하세요">
					</td>
			</tr>
			<tr>
			<td style="text-align: left">
					<p><strong>닉네임을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="nickChk"></span></p>
				</td>
			</tr>
			<tr>
				<td><input type="nick" maxlength="30" name="" id="nickname"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
					placeholder="닉네임을 입력하세요">
					</td>
			</tr>
			<tr>
			<td style="text-align: left">
					<p><strong>이메일을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="emailChk"></span></p>
				</td>
			</tr>
			<tr>
				<td><input type="email" maxlength="30" name="" id="email"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
					placeholder="이메일을 입력하세요">
					</td>
			</tr>
			<tr>
			<td style="text-align: left">
					<p><strong>회원가입일</strong>&nbsp;&nbsp;&nbsp;<span id="DateChk"></span></p>
				</td>
			</tr>
			<tr>
				<td><input type="enroll" maxlength="30" name="" id="enrollDate"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de">
					</td>
			</tr>
			<tr>
				<td><button class="signBtn1" id="joinBt" value="가입">가입</button></td>
				<td><button class="signBtn2" id="btlogin" value="취소">취소</button> </td>
			</tr>
		</table>

	</div>
	
</body>
</html>