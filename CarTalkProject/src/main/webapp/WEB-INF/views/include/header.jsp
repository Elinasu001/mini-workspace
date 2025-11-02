<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {

    $("#loginBt").click(function() {
        $("#frm").attr("action", "${pageContext.request.contextPath}/loginPage").submit();
    });

    $("#logOutBt").click(function() {
        $("#frm").attr("action", "${pageContext.request.contextPath}/logout").submit();
    });

});
</script>

<form name="frm" method="post" id="frm"></form>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <!-- 로고 -->
        <a class="navbar-brand fw-bold" href="#">CarTalk</a>

        <!-- 햄버거 버튼 -->
        <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- PC 메뉴 -->
        <div class="collapse navbar-collapse d-none d-lg-flex justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/event/list">이벤트 게시판</a></li>
                <li class="nav-item"><a class="nav-link" href="#">일반 게시판</a></li>
                <li class="nav-item"><a class="nav-link" href="#">사진 게시판</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/used/list">거래 게시판</a></li>
            </ul>

            <div class="auth-links">
                <c:choose>
                    <c:when test="${empty sessionScope.loginMember}">
                        <a href="#login" id="loginBt" class="btn-login line">로그인</a>
                        <a href="#signup" class="btn-signup">회원가입</a>
                    </c:when>
                    <c:otherwise>
                        ${sessionScope.loginMember.userName} 님 환영합니다.
                        <a href="#logout" id="logOutBt" class="btn-login line">로그아웃</a>
                        <a href="#myPage" class="btn-signup">마이페이지</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- 모바일 메뉴 -->
        <div class="offcanvas offcanvas-end d-lg-none" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasNavbarLabel">Menu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>

            <div class="auth-links">
                <c:choose>
                    <c:when test="${empty sessionScope.loginMember}">
                        <a href="#login" id="loginBt" class="btn-login line">로그인</a>
                        <a href="#signup" class="btn-signup">회원가입</a>
                    </c:when>
                    <c:otherwise>
                        ${sessionScope.loginMember.userName} 님 환영합니다.
                        <a href="#logout" id="logOutBt" class="btn-login line">로그아웃</a>
                        <a href="#myPage" class="btn-signup">마이페이지</a>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="offcanvas-body">
                <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/event/list">이벤트 게시판</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">일반 게시판</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">사진 게시판</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/used/list">거래 게시판</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>
