<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<main id="statis_wrap">
    <p class="fs-2">통계</p>
    <%--네비게이션 바--%>
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

    <%--위쪽 상자--%>
    <div id="statis_first_wrap" class="container row">

        <%--회원 통계쪽--%>
        <div id="user_statis" class="col">
            <span class="display-6">총 회원 </span>
            <span>( + 오늘 새로가입한인원)</span>
            <div class = "user_statis__div row"  >
                <div class="col-sm-5">총 회원</div>
                <div class="col-sm-4">
                    <span>${count_user_all}</span>
                    <span></span>
                </div>
            </div>

            <div class = "user_statis__div row" >
                <div class="col-sm-5">비지니스 회원</div>
                <div class="col-sm-4">
                    <span>${countUserBis}</span>
                    <span>( + ${count_news_bis}명 )</span>
                </div>
            </div>

            <div class = "user_statis__div row" >
                <div class="col-sm-5">일반 회원</div>
                <div class="col-sm-4">
                    <span>${countUserGene}</span>
                    <span>( + ${count_news_gene}명 )</span>
                </div>
            </div>

        </div>

        <%--유저 통계 원그래프--%>
        <div id="user_statis_graph" class="col" style="margin: 15px;">
            <p class="display-6">계정타입별 비율</p>
            <canvas id="user_graph">
            </canvas>
        </div>


    </div>

    <div id="statis_2nd_wrap" class="container">
        <p class="display-6">작성된 게시글 현황</p>
        <%--게시글 통계 꺽은선 그래프?--%>
        <canvas id="myChart"></canvas>
    </div>



</main>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>

    const user_graph = document.getElementById('user_graph');
    const board_graph = document.getElementById('board_statis_wrap');
    const ctx = document.getElementById('myChart');

    //오늘부터 10일전까지 날짜
    const dayList = [
        <c:forEach var="day" items="${dayList}">
        '${day}',
        </c:forEach>
    ];

    console.log (dayList);


    new Chart(ctx, {
        type: 'line',
        data: {
            labels: dayList,
            datasets: [{
                label: '게시글 갯수',
                data: ${count_news},
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    const user_data =  {
        labels : [
            '일반',
            '비지니스',
            '임시',
            '관리자' ],
        datasets : [{
            label : '계정타입별 비율',
            data : [ '${countUserGene}', '${countUserBis}', '${countUserTemp}', '${countUserAdmin}' ],
            backgroundColor : [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)'
            ],
            hoverOffset: 4
        }]
    }

    new Chart(user_graph, {
        type: 'doughnut',
        data: user_data, // user_data 객체를 정확하게 전달
    });

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>