<%@ page import="com.example.momol.DTO.CommunityVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="/resources/Community/style.css" type="text/css">
</head>
<body>
<main>
    <!-- 검색 결과 -->
    <div class="board-header">
        <h2>검색 결과</h2>
    </div>
    <section id="board">
        <div class="table-header">
            <div>제목</div>
            <div>작성자</div>
            <div>작성일</div>
            <div>조회수</div>
            <div>좋아요</div>
        </div>
        <c:forEach var="result" items="${searchResults}">
            <div class="post">
                <div>
                    <a href="<c:url value='/community/walls/${result.num}'/>">${result.title}</a>
                </div>
                <div>${result.UID}</div>
                <div>${result.writetime}</div>
                <div>${result.views}</div>
                <div>${result.likes}</div>
            </div>
        </c:forEach>
    </section>
</main>
</body>
</html>
