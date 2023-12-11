<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="/resources/Cocktail/pagechange.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/resources/Cocktail/CakMain.css" type="text/css">
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

    <div class="info_top_wrap">
        <div class="topwrap">
            <div class="btn">
                <select class = "button" >
                    <option value="one">전체 (베이스 주)</option>
                    <option value="two">맥주</option>
                    <option value="three">막걸리</option>
                    <option value="four">양주</option>
                    <option value="five">루피</option>
                    <option value="six">뽀로로</option>
                </select>
            </div>

            <div class="btn"><select class = "button" >
                <option value="one">도수</option>
                <option value="two">100도</option>
                <option value="three">70도</option>
                <option value="four">50도</option>
                <option value="five">40도</option>
                <option value="six">독도</option>
                <option value="six">제주도</option>
            </select></div>

            <div class="btn">
                <select class = "button" >
                    <option value="one">맛</option>
                    <option value="two">달달</option>
                    <option value="three">짭짤</option>
                    <option value="four">느끼</option>
                    <option value="five">매워</option>
                    <option value="six">으엑</option>
                </select>
            </div>

            <div class="btn">
                <select class = "button" >
                    <option value="one">그 외</option>
                    <option value="two">잠</option>
                    <option value="three">자</option>
                    <option value="four">고</option>
                    <option value="five">싶</option>
                    <option value="six">다</option>
                </select>
            </div>
        </div>
        <!--검색바-->
        <div class="search-container">
            <input class="search" type="search" placeholder="검색내용을 입력해주세요" oninput="searchCocktails(this.value,'<%=request.getContextPath()%>')">
        </div>
    </div>


    <div class="grid-container">
        <c:forEach var="data" items="${li}">
        <div class="grid-item">
            <a href="<%=request.getContextPath()%>/Cocktail/cakinfo?name=${data.name}">
                <img src=${data.cocktail_img} alt="게시물1썸네일" class="thumbnail">
                <div>${data.name}</div>
                <div class="dz">${data.cocktail_detail}</div>
            </a>
            <div class="tags">
                <div class="tag1"></div>
                <div class="tag2"></div>
                <div class="tag3"></div>
            </div>
        </div>
        </c:forEach>
    </div>

</main>
</body>