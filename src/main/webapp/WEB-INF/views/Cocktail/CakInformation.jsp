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
                    <div class="tag1">#${vo.basetag}</div>
                    <div class="tag2">#${vo.tastetag}</div>
                    <div class="tag3">#${vo.smelltag}</div>
            </div>
        </div>
    </div>

    <div class="second">
        <div class="jaeryo">
            <div class="title">재료 정보</div>
            <div class="jaeryos">
                <c:forEach var="data" items="${li}">
                <div><img src="${data.ing_photo}" class="jaeryoimg">
                    <div class="jaeryoname">
                        <div>${data.ing_name} </div>
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

    <div class="fourth">
        <div class="fourthtitle">같은 "베이스주" 의 칵테일</div>
        <div class="ang">
            <div class="rhksfus">
                <c:forEach var="data" items="${li2}">
                <div class="make_cocktail_wrap">
                    <a href="<%=request.getContextPath()%>/Cocktail/cakinfo?name=${data.name}"><img src="${data.cocktail_img}" class="imgimg"></a>
                        <div class="title2">${data.name}</div>
                        <div class="explain2">${data.cocktail_detail}</div>
                    <div class="tagss">
                        <div class="tag10">${data.basetag}</div>
                        <div class="tag20">${data.tastetag}</div>
                        <div class="tag30">${data.smelltag}</div>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>
    </div>

</main>
</body>

<script>
    const headerText = document.querySelector("#ect_header__1 > a");
    headerText.style.color = "#4299e1";

    const headerGnb = document.querySelector("#ect_header__1 > div");
    headerGnb.style.display = "block";
</script>

<script src="/resources/main/gnb_cak.js"></script>