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
	.my-button {
	    background-color: lightblue;
	    color: black;
	    padding: 10px 20px;
	    border: none; /* 테두리 없음 */
	    border-radius: 5px; /* 테두리 둥글게 */
	    font-size: 20px; /* 글자 크기 */
	    width: 200px;   /* 너비 고정 */
   		height: 40px;   /* 높이 고정 */
    	text-align: center; /* 텍스트 정렬 */
  }
</style>

<script >
$( document ).ready(function() {

	var btObj = $("#btlogin");
	
	btObj.click(function () {
		//alert('login !!');
		var userid = $("#user_id").val();
		var userpw = $("#user_pw").val();
		if(userid == ''){
			alert('아이디를 입력하세요');
			return;
		}
		
		if(userpw == ''){
			alert('암호를 입력하세요');
			return;
		}
		callSend(userid, userpw);
	});

});


callSend = function (userId, userPw) {
	//alert('아작스');
	$.ajax({
	    type : 'post',           // 타입 (get, post, put 등등)
	    url : 'login',           // 요청할 서버url
	    async : true,            // 비동기화 여부 (default : true)
	    headers : {              // Http header
	      "Content-Type" : "application/json",
	      "X-HTTP-Method-Override" : "POST"
	    },
	    dataType : 'json',       // 데이터 타입 (html, xml, json, text 등등)
	    data : JSON.stringify({  // 보낼 데이터 (Object , String, Array)
	        "userId" : userId, "userPwd" : userPw
	    }),
	    success : function(result) { // 결과 성공 콜백함수
	    	console.log ( JSON.stringify(result));
	    	if (result == "1") {
	    		alert("로그인성공");
	    		window.location.href = '/ct';
	    	} else {
	    		alert("아이디/비밀번호가 존재하지 않습니다.");
	    		return;
	    	}
	    	
	    },
	    error : function(request, status, error) { // 결과 에러 콜백함수
	        console.log(error);
	        alert("로그인 도중 오류가 발생하였습니다.");
	        return;
	    }
	})
		
}
</script>

</head>
<body >
<jsp:include page="/WEB-INF/views/include/meta.jsp" />
<jsp:include page="../include/header.jsp"/>

	<div style="width : 60%; margin : auto; padding : 50px;">
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
					placeholder="암호를 입력하세요">
					</td>
			</tr>
			<tr>
				<td><button class="my-button" id="btlogin" value="로그인">로그인</button> </td>			
			</tr>
		</table>

	</div>
	
</body>
</html>