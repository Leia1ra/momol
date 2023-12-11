<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.example.momol.DTO.CommunityVO" %>

<%@ page import="java.util.List" %>
<%@ page import="com.example.momol.DTO.CommentsVO" %>
<%@ page import="com.example.momol.DAO.CommentsDAO" %>

<% CommunityVO board = (CommunityVO) request.getAttribute("board"); %>

<html>
<head>
    <link rel="stylesheet" href="/resources/Community/style.css" type="text/css">
</head>
<body>
<main>
    <section id="board">
        <h2>담벼락</h2>
        <div class="post1">
            <div class="post-header">
                <div class="title"><%= board.getTitle() %>
                </div>
                <div class="post-info">
                    <div class="author"><%= board.getAuthor() %>
                    </div>
                    <div class="writetime"><%= board.getWritetime() %>
                    </div>
                    <div class="views">조회 <%= board.getViews() %>
                    </div>
                    <div class="comments">댓글 <%= board.getAuthor() %>
                    </div> <!-- 확인하기 -->
                    <button>신고</button>
                </div>
            </div>
            <div class="post-main">
                <%= board.getContent() %>
            </div>
            <div class="likes">좋아요 (<%= board.getLikes() %>)</div>

            <div class="viewcomment">
                <div><h3>댓글( )</h3></div>
                <c:forEach var="comments" items="${comments}">
                <!-- 코멘트 데이터베이스 확인하고 수정 요함 -->
                <div class="comment">
                    <div class="c-author">${comments.getUID2()}</div>
                    <div class="c-comment">${comments.getContent()}</div>
                    <div class="comment-info">
                        <div class="c-writetime">
                            ${comments.getWritetime()}
                        </div>
                        <div class="c-likes">
                            좋아요 (${comments.getLikes()})
                        </div>
                        <div class="report"> 신고</div>
                    </div>
                </div>
                </c:forEach>

                <div class="comment-input">
                    <form action="/addComment" method="post">
                        <input type="hidden" name="UID2" value="ffff">
                        <input type="hidden" name="num" value="<%= board.getNum() %>">
                        <input type="text" name="content" placeholder="댓글을 남겨보세요">
                        <input type="submit" value="등록">
                    </form>
                </div>
            </div>
        </div>
    </section>

    <script>
        function toList() {
            history.back();
            /*location.reload();*/
        }
    </script>
    <section id="bottom">
        <div class="btns_p">
            <a href="writing">
                <button>글쓰기</button>
            </a>
            <button>수정</button>
            <button onclick="toList()">목록</button>
            <button>TOP</button>
        </div>
    </section>
</main>

<footer>
</footer>
</body>
</html>
