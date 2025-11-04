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
	.my_pageBt {
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
    .my_pageBtn {
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
	$('#user_id').attr('readonly', true);
	$('#user_pw').attr('readonly', true);
	$('#user_name').attr('readonly', true);
	$('#nickname').attr('readonly', true);
	$('#email').attr('readonly', true);
	$('#enrollDate').attr('readonly', true);
	$('#upDate').attr('readonly', true);
	var joinBt = $("#updateBt");
	var cncalBt = $("#cancelBt");

	joinBt.click(saveBt);
	cncalBt.click(cncalBt2);
	
});

cncalBt2 = function() {
	//alert("1");
	var userpw = $("#user_pw").val();
	var change_pw = $("#change_pw").val();
	
	if(userpw=="") {
		alert("기존 암호를 동일하게 입력하세요!");
		return;	
	}
	
	if(change_pw ==  "") {
		alert("탈퇴를 하기 위해서 암호를 동일하게 입력하세요!");
		return;
	}
	
	if(change_pw !=  userpw) {
		alert("탈퇴를 하기 위해서 암호를 동일하게 입력하세요!");
		return;
	}
	
	if (change_pw ==  userpw) {
		var result = confirm('정말 탈퇴를 하시겠습니까?');
		if(result) {
			let dataSet = JSON.stringify({  
		          "userId" : $("#user_id").val()
		        , "userNo" : $("#userNo").val()
		    });
			
			 callSend("deletInfo", dataSet,'2');
		}
	}
};

saveBt = function() {
	// alert("회원가입");
	
	var userid = $("#user_id").val();
	var userpw = $("#user_pw").val();
	var change_pw = $("#change_pw").val();
	
	if(userpw == ''){
		alert('암호를 입력하세요');
		return;
	}
	
	if(change_pw == ''){
		alert('이름을 입력하세요');
		return;
	}
	
	if(change_pw == userpw){
		alert('같은 비밀번호를 입력하실수 없습니다.');
		return;
	}
	
	let dataSet = JSON.stringify({  
          "userId" : userid
        , "userPwd" : userpw
        , "changePwd" : change_pw
    });
	// alert(dataSet);
    callSend("updateInfo", dataSet, "1");
	
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

callSend = function (actUrl , dataSet, str) {
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
	    		if(str== "1") {
	    			alert("수정되었습니다. 다시 로그인 해주세요");
	    		} else {
	    			alert("탈퇴되었습니다. 다음에 또 만나요~!");
	    		}
	    		window.location.href = '/ct';
	    	} else {
	    		alert("수정도중 오류발생!");
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
|나의 정보
<c:choose>
<input type="hidden" id="userNo" value="${Member.userNo}">
</c:choose>
	<div style="width : 100%; margin : auto; padding : 50px;">
		<table
			style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
			<tr>
				<td style="text-align: left">
					<p><strong>아이디</strong>&nbsp;&nbsp;&nbsp;<span id="idChk"></span></p>
				</td>							
			</tr>
			<tr>
				<td>
				<c:choose>
					<input type="text" name="" id="user_id"
						class="form-control tooltipstered" maxlength="14"
						required="required" aria-required="true"
						style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
						placeholder="숫자와 영어로 4-30자" value="${Member.userId}">
				</c:choose>
				</td>
			</tr>
			<tr>
				<td style="text-align: left">
					<p><strong>비밀번호</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk"></span></p>
				</td>
			</tr>
			<tr>
			<c:choose>
				<td><input type="password" maxlength="30" name="" id="user_pw"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
					placeholder="비밀번호를 입력하세요" value="${Member.userPwd}">
				</td>
			</c:choose>
			</tr>
			<tr>
				<td style="text-align: left">
					<p><strong>비밀번호 체크</strong>&nbsp;&nbsp;&nbsp;<span id="newPwd"></span></p>
				</td>
			</tr>
			<tr>
			<c:choose>
				<td><input type="password" maxlength="30" name="" id="change_pw"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
					placeholder="정보변경(새로운 비밀번호 입력) / 회원탈퇴(기존비밀번호 입력)하세요." >
				</td>
			</c:choose>
			</tr>
			<tr>
			<td style="text-align: left">
					<p><strong>실명</strong>&nbsp;&nbsp;&nbsp;<span id="nameChk"></span></p>
				</td>
			</tr>
			<tr><c:choose>
				<td><input type="name" maxlength="30" name="" id="user_name"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
					placeholder="이름을 입력하세요" value="${Member.userName}">
					</td>
					</c:choose>
			</tr>
			<tr>
			<td style="text-align: left">
					<p><strong>닉네임</strong>&nbsp;&nbsp;&nbsp;<span id="nickChk"></span></p>
				</td>
			</tr>
			<tr>
			<c:choose>
				<td><input type="nick" maxlength="30" name="" id="nickname"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
					placeholder="닉네임을 입력하세요" value="${Member.nickName}">
					</td>
					</c:choose>
			</tr>
			<tr>
			<td style="text-align: left">
					<p><strong>이메일</strong>&nbsp;&nbsp;&nbsp;<span id="emailChk"></span></p>
				</td>
			</tr>
			<tr>
				<c:choose>
				<td><input type="email" maxlength="30" name="" id="email"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
					placeholder="이메일을 입력하세요" value="${Member.email}">
					</td>
					</c:choose>
			</tr>
			<tr>
			<td style="text-align: left">
					<p><strong>회원가입</strong>&nbsp;&nbsp;&nbsp;<span id="DateChk"></span></p>
				</td>
			</tr>
			<tr>
			<c:choose>
				<td><input type="enroll" maxlength="30" name="" id="enrollDate"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
					value="${Member.enrollDate}">
					</td>
					</c:choose>
			</tr>
			<tr>
			<td style="text-align: left">
					<p><strong>정보수정일</strong>&nbsp;&nbsp;&nbsp;<span id="updateDate"></span></p>
				</td>
			</tr>
			<tr>
			<c:choose>
				<td><input type="enroll" maxlength="30" name="" id="upDate"
					class="form-control tooltipstered" maxlength="14"
					required="required" aria-required="true"
					style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
					value="${Member.updateDate}">
					</td>
					</c:choose>
			</tr>
			<tr>
				<td><button class="my_pageBt" id="updateBt" value="변경">비밀번호변경</button></td>
				<td><button class="my_pageBtn" id="cancelBt" value="취소">회원탈퇴</button> </td>
			</tr>
		</table>

	</div>
	
</body>
</html>