<%@ page import="com.example.momol.DTO.CommunityVO" %>
<%@ page import="com.example.momol.DAO.BoardDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="today" value="<%=new java.util.Date()%>" />

<html>
    <head>
        <link rel="stylesheet" href="/resources/Community/style.css" type="text/css">
    </head>
    <body>
        <script>

        </script>

        <main>
            <!-- 담벼락 -->
            <div class="board-header">
                <div class="board_title_wrap">
                    <h2 class="title">담벼락</h2>
                    <p class="add">자유롭게 이야기를 나눠보세요..</p>
                </div>
                <div class="sort" style="opacity: 0">
                    <button id="sort-lately" onclick="sortPosts('최신')">최신 순</button>
                    <button id="sort-likes" onclick="sortPosts('좋아요')">좋아요 순</button>
                </div>
            </div>
            <section id="board">
                <div class="table-header">
                    <div class="post_num">번호</div>
                    <div class="post_title">제목</div>
                    <div class="post_nick">작성자</div>
                    <div class="post_time">작성일</div>
                    <div class="post_view">조회수</div>
                    <div class="post_like">좋아요</div>
                </div>
                <c:forEach var="board" items="${boards}">
                    <c:if test="${board.catnum == 1}">
                        <div class="post">
                            <div class="post_num">
                                    ${board.num}
                            </div>
                            <div class="post_title">
                                <a href="<c:url value='/community/walls/${board.num}'/>">${board.title}</a>
                            </div>
                            <div class="post_nick">${board.nick}</div>

                            <c:choose>
                                <c:when test="${today.year == board.writetime.year}">
                                    <c:choose>
                                        <c:when test="${today.month == board.writetime.month && today.date == board.writetime.date}">
                                            <div class="post_time">
                                                <fmt:formatDate value="${board.writetime_Ts}" pattern="HH:mm" />
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="post_time">
                                                <fmt:formatDate value="${board.writetime_Ts}" pattern="MM.dd" />
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <div class="post_time">
                                        <fmt:formatDate value="${board.writetime_Ts}" pattern="yyyy.MM.dd" />
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="post_view">${board.views}</div>
                            <div class="post_like">${board.likes}</div>
                        </div>
                    </c:if>
                </c:forEach>
            </section>

            <!-- 게시판 하단 -->
            <section id="bottom">
                <div class="write">
                    <a href="writing">
                        <button id="writeBtn" class="board_list__button_t1">
                            <span class="material-icons">create</span>
                            글쓰기
                        </button>
                    </a>
                </div>

                <div class="buttons">

                    <div class="pages no-drag">
                        <button class="page_btn">
                            <span class="material-icons">navigate_before</span>
                        </button>
                        <a class="page_nums" href="#">1</a>

                        <button class="page_btn">
                            <span class="material-icons">navigate_next</span>
                        </button>
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

<script src="/resources/main/gnb_community.js"></script>