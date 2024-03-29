<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="com.example.momol.DTO.UserVO" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.userdetails.UserDetails" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    #ect_header {
        display: none;
    }

    #main_wrap {
        width: 100%;
        min-width: 100%;
        max-width: 100%;
        padding : 0;
    }


</style>

<header class="main_header">

    <!--로고 넣어야 하는 부분(좌측)-->
    <div>
        <a href="/">
            <%--<img src="/resources/main/logo_temp.png"--%>
            <%--     alt="logo"--%>
            <%--     class="main__main-logo">--%>
            <img src="<%=request.getContextPath()%>/resources/main/momol_logo_2.svg" alt="logo" class="main_header__logo_img">
            <span style="font-family: 'YanoljaYacheR'" class="no-drag">모히또에서 몰디브를</span>
        </a>
    </div>

    <!--메인페이지 헤더의 네비게이션 부분 (우측) -->


    <nav class="main_header__nav no-drag">

        <c:if test="${empty sessionScope.logUID}" >
            <a href="/account/signIn">
                <div class="main_header__nav__iconbox">
                    <span class="material-icons">person_add</span>
                    <p class="main_Header__nav__iconbox_text">회원가입</p>
                </div>
            </a>

            <a href="/account/login">
                <div class="main_header__nav__iconbox">
                    <span class="material-icons">login</span>
                    <p class="main_Header__nav__iconbox_text">로그인</p>
                </div>
            </a>
        </c:if>

        <c:if test="${not empty sessionScope.logUID}" >
            <%--        로그아웃--%>
            <a href="/account/logout">
                <div class="main_header__nav__iconbox">
                    <span class="material-icons">logout</span>
                    <p class="main_Header__nav__iconbox_text">로그아웃</p>
                </div>
            </a>

            <%--마이페이지--%>
            <a href="/mmypage/mypage">
                <div class="main_header__nav__iconbox">
                    <span class="material-icons">account_circle</span>
                    <p class="main_Header__nav__iconbox_text">마이페이지</p>
                </div>
            </a>
        </c:if>

        <a href="#">
            <div class="main_header__nav__iconbox">
                <span class="material-icons">menu</span>
            </div>
        </a>

    </nav>


</header>

<%--<div id="header_menu">--%>
<%--    <div class="header_menu_wrap">--%>
<%--        <div class="header_menu__title">--%>
<%--            &lt;%&ndash;<span class="material-icons">menu</span>&ndash;%&gt;--%>
<%--            <p>모히또에서 몰디브를</p>--%>
<%--        </div>--%>
<%--        <div class="header_menu__content_area">--%>

<%--        </div>--%>

<%--    </div>--%>

<%--</div>--%>

<main id="main_wrap">
    <section id="main__img">

        <p class="madi no-drag">Cocktail</p>

        <!--메인 이미지 하단 네비게이션 메뉴바-->
        <div id="main__nav">
            <a href="<%=request.getContextPath()%>/Cocktail/cakmain">
                <div class="main__nav__box">
                    <span class="material-icons">local_bar</span>
                    <p class="bold">칵테일 정보</p>
                </div>
            </a>

            <a href="<%=request.getContextPath()%>/combain">
                <div class="main__nav__box">
                    <span class="material-icons">kitchen</span>
                    <p class="bold">술장고</p>
                </div>
            </a>

            <a href="<%=request.getContextPath()%>/worldcup">
                <div class="main__nav__box">
                    <span class="material-icons">emoji_events</span>
                    <p class="bold">월드컵</p>
                </div>
            </a>

            <a href="<%=request.getContextPath()%>/community/walls">
                <div class="main__nav__box">
                    <span class="material-icons">forum</span>
                    <p class="bold">커뮤니티</p>
                </div>
            </a>

        </div>

    </section>

    <section id="main__content">

        <div class="main__content__wrap">
            <div class="main__content__box">

                <div class="main__beige_area"></div>
                <div style="background-image:url('/resources/img/image 33.png')" class="main__img_area_1"></div>
                <div style="background-image:url('/resources/img/image 11.png')" class="main__img_area_2"></div>

                <div class="main__text_area_1">
                    <p>Let's Drink!</p>
                </div>

                <a href="#">
                    <div class="main__content__box_text">칵테일 보기 ▶ </div>
                </a>
            </div>
        </div>

        <div class="main__content__wrap">
            <div class="main__content__box">

                <div class="main__beige_area_2"></div>
                <div style="background-image:url('/resources/img/image 28.png')" class="main__img_area_3"></div>

                <div style="background-image:url('/resources/img/image 24.png')" class="main__img_area_4"></div>

                <div class="main__text_area_2">
                    <p>섞고, 섞고, 돌리고, 섞고.</p>
                    <p>Mix, mix, spin, mix.</p>
                </div>
                <div class="main__text_area_3">
                    <p>술은 행복한 자에게만 달콤하다.</p>
                </div>

                <a href="#">
                    <div class="main__content__box_text">술장고 만들기 ▶ </div>
                </a>
            </div>
        </div>

        <div class="main__content__wrap">
            <div class="main__content__box">

                <div class="main__img_area_5"></div>
                <div class="main__text_area_4 no-drag">칵테일 좋아하세요?</div>

                <a href="#">
                    <div class="main__content__box_text">커뮤니티 ▶</div>
                </a>
            </div>
        </div>

    </section>

</main>

<script>

    window.onload = function () {
        sun_rise_api();
        insert_img();
    }


    function insert_img () {
        const img_box = document.querySelectorAll(".main__content__box")
        //현재시간 불러오기
        const date = new Date();
        const hour = date.getHours();
        //시간에 따라 배경이미지 변경
        img_box.forEach((box, index) => {
            box.style.backgroundImage = `url(/resources/main/main_img${index + 1}.png)`;
        });

    }

    function sun_rise_api () {
        const main_img = document.querySelector("#main__img");

        const base_url = "https://api.sunrise-sunset.org/json?";
        const lat = "lat=37.3412"; //서울
        const lng = "lng=126.5837";

        //날자붙러오기
        const date = new Date();
        const hour = date.getHours();
        const min = date.getMinutes();

        const url = base_url + lat + "&" + lng + "&" + "date=today&&tzId=Asia/Seoul";

        try {

            fetch(url)
                .then(res => res.json())
                .then(data => {
                    const sunrise = data.results.sunrise;
                    const sunset = data.results.sunset;

                    const sunrise_hour = sunrise.split(":")[0]; //일출 시간 - 시
                    const sunrise_min = sunrise.split(":")[1]; //일출 시간 - 분

                    let sunset_hour = sunset.split(":")[0]; //읾롤시간 - 시
                    sunset_hour = parseInt(sunset_hour)+12;
                    const sunset_min = sunset.split(":")[1]; //일몰시간 - 분


                    if ( (hour >= sunset_hour && min >=sunrise_min) || (hour <= sunrise_hour && min <= sunrise_min) ) {
                        main_img.style.backgroundImage = `url(/resources/main/main_img_1.png)`;
                        console.log("낮");

                    } else {
                        main_img.style.backgroundImage = `url(/resources/main/main_img_2.png)`;
                        console.log("밤");
                    }

                })

                .catch(err => console.log(err));

        } catch (e) {
            console.log(e);
        }

    }
</script>

<script>
    function handleScroll() {
        const header = document.querySelector("#wrap > header.main_header");
        // 현재 스크롤 위치를 가져옵니다.
        var scrollY = window.scrollY || window.pageYOffset;
        console.log(scrollY);

        if (scrollY >= 750) {
            header.style.backgroundColor = "#63b3ed" //text-blue-400
        } else {
            header.style.backgroundColor = "rgba(255, 255, 255, 0)";

        }
    }

    // 스크롤 이벤트를 리스닝합니다.
    window.addEventListener("scroll", handleScroll);

</script>