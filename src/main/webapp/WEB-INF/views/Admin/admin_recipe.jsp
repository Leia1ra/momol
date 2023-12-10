<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<style>
    #admin_recipe_wrap {
        width : 90%;
        margin : 0 auto;
    }
</style>

<main id="admin_recipe_wrap">

    <%--NAV BAR--%>
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

    <p class="fs-2">칵테일 관리</p>
    <form action="" method="post" id="recipe_add_btn" class="btn btn-primary">칵테일 추가</form>

    <%-- 레시피 테이블 --%>
    <div class="">
        <table class="table table-hover table-striped">
            <thead class="table-dark">
                <tr class="active">
                    <th scope="col" class="col-sm-1">이미지</th>
                    <th scope="col" class="col-sm-1">이름</th>
                    <th scope="col" class="col-sm-1">영어이름</th>
                    <th scope="col" class="col-sm-1">도수</th>
                    <th scope="col" class="col-sm-3">설명</th>
                    <th scope="col" class="col-sm-3">레시피</th>
                    <th scope="col" class="col-sm-1">관리</th>

                </tr>
            </thead>
            <tbody>
                <c:forEach var="cocktail" items="${cocktail}">
                    <tr>
                        <td><img alt="cock_img" src="${cocktail.cocktail_img}" width="80px" height="auto"></td>
                        <td>${cocktail.name}</td>
                        <td>${cocktail.name_eng}</td>
                        <td>${cocktail.ABV}</td>
                        <td>${cocktail.cocktail_detail}</td>
                        <td>${cocktail.recipe}</td>
                        <td>
                            <form value="수정" class="btn btn-primary">수정</form>
                            <form value="삭제" class="btn btn-danger">삭제</form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div>
        <form id="myForm" method="post" action="ingreadd">
            <input type="text" name="data" value="Hello, World!">
            <button type="button" onclick="submitFormAndOpenNewWindow()">새 창으로 열기</button>
        </form>

    </div>

        <script>
            function submitFormAndOpenNewWindow() {
                // 폼을 서버로 제출 (POST 방식)
                document.getElementById("myForm").submit();

                window.open("ingreeadd",'재료추가','width=500, height=500, toolbar=no, menubar=no, scrollbars=no, resizable=yes');
            }
        </script>


</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>