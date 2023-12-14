<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<main id="admin_user">
    <p class="fs-2">유저 관리</p>

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

    <%--    유저 리스트 출력 --%>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th scope="col">UID</th>
                            <th scope="col">아이디</th>
                            <th scope="col">닉네임</th>
                            <th scope="col">전화번호</th>
                            <th scope="col">성별</th>
                            <th scope="col">이메일</th>
                            <th scope="col">생일</th>
                            <th scope="col">생성일</th>
                            <th scope="col">관리자여부</th>
                            <th scope="col">관리</th>

                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${user}">
                            <tr>
                                <th scope="row">${user.UID}</th>
                                <th scope="row">${user.id}</th>
                                <th scope="row">${user.nick}</th>
                                <th scope="row">${user.phone}</th>
                                <th scope="row">${user.gender}</th>
                                <th scope="row">${user.email}</th>
                                <th scope="row">${user.birth}</th>
                                <th scope="row">joindate 왜 안나옴</th>
                                <%--<th scope="row">${use.JoinDate}</th>--%>
                                <th scope="row">
                                    <c:choose>
                                        <c:when test="${user.UID.startsWith('ADMIN') || user.UID.startsWith('admin')}">
                                            <span class="badge bg-primary">관리자</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">일반유저</span>
                                        </c:otherwise>
                                    </c:choose>
                                </th>
                                <td>
                                    <form method="post" class="btn btn-primary user_edit_btn">수정
                                        <input type="hidden" name="userid" value="${user.id}">
                                        <input type="hidden" name="usernick" value="${user.nick}">
                                    </form>
                                    <form method="post" class="btn btn-danger user_del_btn">삭제
                                        <input type="hidden" name="userid" value="${user.id}">
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script>

        const user_edit_btns = document.querySelectorAll('.user_edit_btn');
        const user_del_btns = document.querySelectorAll('.user_del_btn');

        //작동 안하게


        user_edit_btns.forEach((user_edit_btn) => {
            user_edit_btn.addEventListener('click', () => {
                // 부모 요소의 td 2번째 자식의 text 가져오기
                const userid = user_edit_btn.parentElement.parentElement.children[1].innerText;
                const usernick = user_edit_btn.parentElement.parentElement.children[2].innerText;
                // console.log(userid);
                const edit_url = "/admin/useredit?userid=" + userid + "&usernick=" + usernick;
                console.log(edit_url);
                window.open(edit_url, '유저수정', 'width=500, height=500, left=100, top=50')
            });
        });

        user_del_btns.forEach((user_del_btn) => {
            user_del_btn.addEventListener('click', () => {
                const userid = user_del_btn.parentElement.parentElement.children[1].innerText;
                const del_url = "/admin/userdel?userid=" + userid;
                window.open(del_url, '유저삭제', 'width=500, height=500, left=100, top=50')
            });
        });

    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </main>