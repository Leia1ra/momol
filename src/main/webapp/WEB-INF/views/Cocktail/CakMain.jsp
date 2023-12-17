<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/resources/Cocktail/CakMain.css" type="text/css">
</head>
<body onload="setDefaultActive()">
<main>

    <div class="container">
        <a href="<%=request.getContextPath()%>/Cocktail/cakmain"><div class="section">
            <h2>칵테일 정보</h2>
        </div></a>

        <a href="<%=request.getContextPath()%>/Cocktail/jaeryomain"><div class="section" >
            <h2>재료 정보</h2>
        </div></a>

        <a href="<%=request.getContextPath()%>/Cocktail/wordbook"><div class="section" >
            <h2>용어 사전</h2>
        </div></a>
    </div>

    <div class="info_top_wrap">
        <div class="topwrap">
            <div class="btn">
                <select class = "button" id="select_base" >
                    <option value="">전체 (베이스 주)</option>
                    <option value="진베이스">진베이스</option>
                    <option value="럼베이스">럼베이스</option>
                    <option value="보드카">보드카</option>
                    <option value="테킬라">테킬라</option>
                    <option value="브랜디">브랜디</option>
                    <option value="위스키">위스키</option>
                </select>
            </div>

            <div class="btn"><select class = "button" id="select_base2" >
                <option value="">전체 (도수)</option>
                <option value="0">무알코올</option>
                <option value="20">약한도수</option>
                <option value="40">강한도수</option>
            </select></div>

            <div class="btn">
                <select class = "button" id="select_base3" >
                    <option value="">전체 (맛)</option>
                    <option value="시원함">시원함</option>
                    <option value="달달함">달달함</option>
                    <option value="부드러움">부드러움</option>
                    <option value="새콤함">새콤함</option>
                    <option value="심플함">심플함</option>
                    <option value="씁쓸함">씁쓸함</option>
                    <option value="짭짤함">짭짤함</option>
                    <option value="위스키">위스키</option>
                    <option value="기름짐">기름짐</option>
                    <option value="떫음">떫음</option>
                    <option value="민트맛">민트맛</option>
                </select>
            </div>

        </div>
        <!--검색바-->
        <div class="search-container">
            <span class="material-icons no-drag">search</span>
            <input class="search" type="search" placeholder="검색내용을 입력해주세요" oninput="searchCocktails(this.value,'<%=request.getContextPath()%>')">
        </div>
    </div>


    <div class="grid-container">
    <c:forEach var="data" items="${li}">
        <div class="grid-item">
            <a href="<%=request.getContextPath()%>/Cocktail/cakinfo?name=${data.name}">
                <img src="${data.cocktail_img}" alt="" class="thumbnail">
                <div>${data.name}</div>
                <div class="dz">${data.cocktail_detail}</div>
            </a>
            <div class="tags">
                <div class="tag1">${data.basetag}</div>
                <div class="tag2">${data.tastetag}</div>
                <div class="tag3">${data.smelltag}</div>
            </div>
        </div>
        </c:forEach>

    </div>

</main>
</body>
<script src="/resources/Cocktail/pagechange.js"></script>
<script src="/resources/main/gnb_cak.js"></script>