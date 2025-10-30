<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

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
</style>

<script >
$( document ).ready(function() {

	var btObj = $("#loginBt");
	
	btObj.click(function () {
		callSend($("#user_id").val(), $("#user_pw").val());
	});

});


callSend = function (userId, userPw) {
	
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
	        "userId" : userId, "userPw" : userPw
	    }),
	    success : function(result) { // 결과 성공 콜백함수
	        console.log(result);
	    },
	    error : function(request, status, error) { // 결과 에러 콜백함수
	        console.log(error)
	    }
	})
		
}
</script>

</head>
<body >
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
					placeholder="암호를 입력하세요">
					</td>
			</tr>
			<tr>
				<td><button id="loginBt" value="로그인">로그인</button> </td>			
			</tr>
		</table>

	</div>
	
</body>
</html>