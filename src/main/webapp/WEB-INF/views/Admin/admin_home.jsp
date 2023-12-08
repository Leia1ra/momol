<%-- admin 페이지의 메인이 되는 공간 --%>

<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<main id="admin_home">

    <p> 여기는 관리자 페이지 메인</p>

    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">MOMOL_ADMIN</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/admin/board">게시판</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/comment">댓글</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/user">유저</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/recipe">레시피</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/ingredient">재료</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/worldcup">월드컵</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/report">신고</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/statistics">통계</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</main>