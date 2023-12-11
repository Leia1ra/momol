<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
<%--    <link rel="stylesheet" href="resources/Account/login.css">--%>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/resources/Cocktail/JaeryoMain.css" type="text/css">
</head>
<body onload="setDefaultActive()">
<main>

    <div class="container">
        <a href="<%=request.getContextPath()%>/Cocktail/cakmain"><div class="section" onclick="changeActive(this)">
            <h2>칵테일 정보</h2>
        </div></a>

        <a href="<%=request.getContextPath()%>/Cocktail/jaeryomain"><div class="section" onclick="changeActive(this)">
            <h2>재료 정보</h2>
        </div></a>

        <div class="section" onclick="changeActive(this)">
            <h2>용어 사전</h2>
        </div>
    </div>

    <div class="info_top_wrap">

        <div class="topwrap">
            <label class="button" id="labelOne">
                <input type="radio" name="drinkType" value="one" onclick="changeColor('labelOne')" checked="checked">전체
            </label>

            <label class="button" id="labelTwo">
                <input type="radio" name="drinkType" value="two" onclick="changeColor('labelTwo')">술(약한도수)
            </label>

            <label class="button" id="labelThree">
                <input type="radio" name="drinkType" value="three" onclick="changeColor('labelThree')">술(강한도수)
            </label>

            <label class="button" id="labelFour">
                <input type="radio" name="drinkType" value="four" onclick="changeColor('labelFour')">음료수
            </label>

            <label class="button" id="labelFive">
                <input type="radio" name="drinkType" value="five" onclick="changeColor('labelFive')">주스
            </label>

            <label class="button" id="labelSix">
                <input type="radio" name="drinkType" value="six" onclick="changeColor('labelSix')">기타
            </label>
        </div>

        <!--검색바-->
        <div class="search-container">
            <input class="search" type="search" placeholder="검색내용을 입력해주세요">
            <span class="material-icons">search</span>
        </div>
    </div>


    <div class="grid-container">
        <c:forEach var="data" items="${li}">
        <div class="grid-item">
            <a href="<%=request.getContextPath()%>/Cocktail/jaeryoinfo?ing_num=${data.ing_num}">
                <img src="${data.ing_photo}" alt="게시물1 썸네일" class="thumbnail">
                <div>${data.ing_name}</div>
                <div>${data.ing_detail}</div>
            </a>
        </div>
        </c:forEach>
    </div>


    <script>
        window.onload = function () {
            setDefaultActive();
            changeColor('labelOne');
        };

        function setDefaultActive() {
            //칵테일정보를 초기로 지정해놓고 글씩 커졌다 작아졌다 설정
            const defaultSection = document.querySelectorAll('.section')[1];
            defaultSection.classList.add('active');
        }

        function changeActive(element) {
            const sections = document.querySelectorAll('.section');
            sections.forEach(section => section.classList.remove('active'));

            // 클릭된 섹션에 active 클래스 추가
            element.classList.add('active');

            setTimeout(function () {
                const cocktailSection = document.querySelectorAll('.section')[1];
                cocktailSection.classList.add('active');
            }, 300); // 1000ms = 1초

            // 1초 후에 "재료 정보"의 active 클래스 제거
            setTimeout(function () {
                element.classList.remove('active');
            }, 300);
        }

        function changeColor(labelId) {
            var labels = document.querySelectorAll('.button');
            labels.forEach(function (label) {
                label.style.backgroundColor = ''; // 모든 라벨의 배경색 초기화
            });

            var selectedLabel = document.getElementById(labelId);
            selectedLabel.style.backgroundColor = 'lightgreen'; // 선택된 라벨의 배경색 변경
        }
    </script>





</main>
</body>
