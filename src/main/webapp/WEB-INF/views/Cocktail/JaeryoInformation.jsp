<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
<%--    <link rel="stylesheet" href="resources/Account/login.css">--%>
    <link rel="stylesheet" href="/resources/Cocktail/JaeryoInformation.css" type="text/css">
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

        <a href="<%=request.getContextPath()%>/Cocktail/wordbook"><div class="section" onclick="changeActive(this)">
            <h2>용어 사전</h2>
        </div></a>
    </div>

    <div class="first">
        <div class="imgsize"><img src="${vo.ing_photo}"></div>
        <div class="explain">
            <div class="cakname">
                ${vo.ing_name}
                <div class="engname">${vo.ing_name_eng}</div>
            </div>
            <div class="cakexplain">${vo.ing_detail}</div>
        </div>
    </div>


    <div class="fourth">
        <div class="title">해당 재료로 만들 수 있는 칵테일</div>
        <div class="ang">
            <div class="rhksfus">
                <c:forEach var="vo" items="${li}">
                <a href="<%=request.getContextPath()%>/Cocktail/jaeryoinfo?ing_num=${data.ing_num}">
                    <img src="${vo.cocktail_img}" class="imgimg"></a>
                <div class="title2">${vo.name}</div>
                <div class="explain2">${vo.cocktail_detail}</div>
                </c:forEach>
            </div>
        </div>
    </div>


    <script>
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
    </script>

</main>
</body>
