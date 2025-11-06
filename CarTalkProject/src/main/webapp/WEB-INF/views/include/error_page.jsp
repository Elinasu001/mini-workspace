<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러!!</title>
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/meta.jsp" />
	
		<h1>에러페이지: ${msg}</h1>
	
	<jsp:include page="../include/footer.jsp" />
</body>
</html>