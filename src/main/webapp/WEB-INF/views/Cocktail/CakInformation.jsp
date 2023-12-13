<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <script src="/resources/Cocktail/pagechange.js"></script>
    <link rel="stylesheet" href="/resources/Cocktail/CakInformation.css" type="text/css">
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
        <img class="imgsize" src="${vo.cocktail_img}" alt="${vo.name} 이미지">
        <div class="explain">
            <div class="cakname">
                ${vo.name}
                <div class="engname">${vo.name_eng}</div>
            </div>
            <div class="cakexplain">${vo.cocktail_detail}</div>
            <div class="tags">
                <div class="tag1">#진베이스</div>
                <div class="tag2">#베르무트</div>
                <div class="tag3">#도수강한</div>
                <div class="tag4">#강렬하고진한</div>
            </div>
        </div>
    </div>

    <div class="second">
        <div class="jaeryo">
            <div class="title">재료 정보</div>
            <div class="jaeryos">
                <c:forEach var="data" items="${li}">
                <div>
                    <img src="/resources/img/나.jpg" class="jaeryoimg">
                    <div class="jaeryoname_wrap">
                        <p class="jaeryoname">${data.name}</p>
                        <div class="yang">${data.ing_amount}</div>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>

        <div class="method">
            <div class="title">만드는 법</div>
            <div class="methods">
                <div>${vo.recipe}</div>
            </div>
        </div>
    </div>

    <div class="third">
        <div class="title">어울리는 안주</div>
        <div class="anju">
            <div class="d"><img src="/resources/img/나.jpg" class="anjuimg"><div class="anjuname">#감스트안주</div></div>
            <div class="d"><img src="/resources/img/나.jpg" class="anjuimg"><div class="anjuname">#감스트안주</div></div>
        </div>
    </div>

    <div class="fourth">
        <div class="fourthtitle">관련 칵테일</div>
        <div class="ang">
            <div class="rhksfus">
                <a href="#"><img src="/resources/img/나.jpg" class="imgimg"></a>
                <div class="title2">나는 루피에요</div>
                <div class="explain2">루피루피루피루피루피루피루피루피루피루피루피루피루</div>
                <div class="tagss">
                    <div class="tag10">#데낄라</div>
                    <div class="tag20">#달아요</div>
                    <div class="tag30">#과일향</div>
                </div>
            </div>
        </div>
    </div>

</main>
</body>
