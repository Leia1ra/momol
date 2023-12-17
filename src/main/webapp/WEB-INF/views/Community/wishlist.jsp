
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <link rel="stylesheet" href="/resources/Community/style.css" type="text/css">
</head>
<body>
<main>
    <!-- 담벼락 -->
    <div class="board-header">
        <h2>위시리스트</h2>
        <p class="add">주류 정보를 공유해 보아요.</p>
        <div class="sort">
            <button id="sort-lately">최신 순</button>
            <button id="sort-likes">좋아요 순</button>
        </div>
    </div>
    <section id="board">
        <div class="table-header">
            <div>제목</div>
            <div>작성자</div>
            <div>작성일</div>
            <div>조회수</div>
            <div>좋아요</div>
        </div>
        <c:forEach var="board" items="${boards}">
            <c:if test="${board.catnum == 5}">
                <div class="post">
                    <div>
                        <a href="<c:url value='/community/wishlist/${board.num}'/>">${board.title}</a>
                    </div>
                    <div>${board.UID}</div>
                    <div>${board.writetime}</div>
                    <div>${board.views}</div>
                    <div>${board.likes}</div>
                </div>
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
