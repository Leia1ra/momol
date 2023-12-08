<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
<%--    <link rel="stylesheet" href="resources/Account/login.css">--%>
    <link rel="stylesheet" href="/resources/Mypage/b-style.css" type="text/css">
    <script src="/resources/Mypage/b-style.js"></script>
</head>
<body>
<main>
    <!-- 사업자페이지 -->

    <!-- 페이지 제목 -->

    <p id="business-p1">사업장 정보 작성</p>

    <!-- 사업장 정보 -->

    <div id="business-h1">

        <div id="business-h1-left">

            <div id="business-h1-left-top">
                상호명
            </div>

            <div id="business-h1-left-bottom">
                가게사진
            </div>

        </div>

        <div id="business-h1-right">

            <div id="business-h1-right-top">
                주소
            </div>

            <div id="business-h1-right-bottom">

                <div id="business-h1-right-bottom-top">

                    <div id="business-h1-right-bottom-top-left">
                        월화 수
                    </div>

                    <div id="business-h1-right-bottom-top-right">
                        ㅇㄴ영시간
                    </div>

                </div>

                <div id="business-h1-right-bottom-bottom">
                    기탈
                </div>

            </div>

        </div>
    </div>

    <!-- 주요메뉴  lorem1000-->

    <div id="business-h2">
        <p id="business-p2">주요메뉴</p>
        <div id="expand">
            <button id="expand-button1">+</button>
            <button id="expand-button2">-</button>
        </div>
        <ul id="business-ul">
            <li class="business-li">
                <div class ="business-h2-left" >

                </div>
                <div class ="business-h2-right" >

                </div>
            </li>
            <li class="business-li">
                <div class ="business-h2-left" >

                </div>
                <div class ="business-h2-right" >

                </div>
            </li>
            <li class="business-li">
                <div class ="business-h2-left" >

                </div>
                <div class ="business-h2-right" >

                </div>
            </li>
        </ul>
    </div>

    <!-- 등록버튼 -->
    <div id="business-submit-div">
        <input type='submit' id="business-submit" value='등록'>
    </div>

</main>
</body>
