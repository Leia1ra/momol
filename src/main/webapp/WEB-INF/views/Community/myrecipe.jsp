
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <link rel="stylesheet" href="/resources/Community/style.css" type="text/css">
</head>
<body>
<main>
  <h2>나만의 레시피</h2>
  <section id="board_r">
    <c:forEach var="board" items="${boards}">
        <c:if test="${board.catnum == 4}">
          <a href="<c:url value='/community/myrecipe/${board.num}'/> ">
            <div class="recipe-card">
              <img src="#<%--${board.image}--%>" alt="${board.title}" class="recipe-image">
              <h3 class="title">${board.title}</h3>
              <div class="recipe-info">
                <div class="author">${board.author}</div>
                <div class="date-views-likes">
                  <div class="writedate">${board.writetime}</div>
                  <div class="views">조회수 ${board.views}</div>
                  <div class="likes">좋아요 ${board.likes}</div>
                </div>
              </div>
            </div>
          </a>
      </c:if>
    </c:forEach>
  </section>

  <!-- 게시판 하단 -->
  <section id="bottom">
    <div class="buttons">
      <div class="write">
        <a href="writing"> <button>글쓰기</button></a>
      </div>
      <div class="pages">
        <button>이전</button>
        <a href="#">1</a>
        <button>다음</button>
      </div>
    </div>
    </div>
    <div class="search">
      <form action="/community/search" method="get">
        <select name="searchType" id="searchType">
          <option value="title">제목</option>
          <option value="author">글쓴이</option>
          <option value="content">내용</option>
        </select>
        <input type="text" name="keyword">
        <button type="submit">검색</button>
      </form>
    </div>
  </section>
</main>
</body>
</html>
