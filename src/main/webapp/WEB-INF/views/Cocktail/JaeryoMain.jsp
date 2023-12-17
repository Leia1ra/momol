<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/resources/Cocktail/JaeryoMain.css" type="text/css">

<main>
    <div class="container">
        <a href="<%=request.getContextPath()%>/Cocktail/cakmain"><div class="section">
            <h2>칵테일 정보</h2>
        </div></a>

        <a href="<%=request.getContextPath()%>/Cocktail/jaeryomain"><div class="section">
            <h2>재료 정보</h2>
        </div></a>

        <a href="<%=request.getContextPath()%>/Cocktail/wordbook"><div class="section">
            <h2>용어 사전</h2>
        </div></a>
    </div>

    <div class="info_top_wrap">

        <div class="topwrap">
            <label class="button" id="labelOne">
                <input type="radio" name="drinkType" value="one" onclick="changeColor('labelOne'); searchCocktails2('','<%=request.getContextPath()%>')" checked>전체
            </label>
            <label class="button" id="labelTwo">
                <input type="radio" name="drinkType" value="two" onclick="changeColor('labelTwo'); getCategoryData('<%=request.getContextPath()%>','약한도수')">약한도수
            </label>

            <label class="button" id="labelThree">
                <input type="radio" name="drinkType" value="three" onclick="changeColor('labelThree'); getCategoryData('<%=request.getContextPath()%>','강한도수')">강한도수
            </label>

            <label class="button" id="labelFour">
                <input type="radio" name="drinkType" value="four" onclick="changeColor('labelFour'); getCategoryData('<%=request.getContextPath()%>','음료수')">음료수
            </label>

            <label class="button" id="labelFive">
                <input type="radio" name="drinkType" value="five" onclick="changeColor('labelFive') ; getCategoryData('<%=request.getContextPath()%>','주스')">주스
            </label>
        </div>

        <!--검색바-->
        <div class="search-container">
            <span class="material-icons no-drag">search</span>
            <input class="search" type="search" placeholder="검색내용을 입력해주세요" oninput="searchCocktails2(this.value,'<%=request.getContextPath()%>')">
        </div>
    </div>


    <div class="grid-container">
        <c:forEach var="data" items="${li}">
            <div class="grid-item">
                <a href="<%=request.getContextPath()%>/Cocktail/jaeryoinfo?ing_num=${data.ing_num}">
                    <img src="${data.ing_photo}" alt="${data.ing_name} 사진" class="thumbnail">
                    <div>${data.ing_name}</div>
                    <div>${data.ing_detail}</div>
                </a>
            </div>
        </c:forEach>
    </div>

</main>
<script src="/resources/Cocktail/jaeryosearch.js"></script>
<script src="/resources/main/gnb_cak.js"></script>