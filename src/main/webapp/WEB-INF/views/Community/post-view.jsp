<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="com.example.momol.DTO.CommunityVO" %>

<%@ page import="java.util.List" %>
<%@ page import="com.example.momol.DTO.CommentsVO" %>
<%@ page import="com.example.momol.DAO.CommentsDAO" %>
<%@ page import="com.example.momol.DAO.BoardDAO" %>

<% CommunityVO board = (CommunityVO) request.getAttribute("board");
    BoardDAO boardDAO = new BoardDAO();
    int commentCount = boardDAO.getCommentCount(board.getNum());
%>

<html>
    <head>
        <link rel="stylesheet" href="/resources/Community/style.css" type="text/css">
        <script>

            function deletePost(num) {
                if (confirm("정말로 삭제하시겠습니까?")) {
                    // 확인을 누르면 서버로 삭제 요청을 보냄
                    fetch(`/community/delete/${num}`, {
                        method: 'GET'
                    })
                        .then(response => {
                            if (response.ok) {
                                alert("게시글이 삭제되었습니다.");
                                window.location.href = '/community/walls'; // 삭제 후 목록 페이지로 이동
                            } else {
                                alert("게시글 삭제에 실패했습니다.");
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });
                }
            }

            function deleteComment(UID) {
                if (confirm("정말로 삭제하시겠습니까?")) {
                    fetch(`/deleteComment`, {
                        method: 'DELETE',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ UID: UID })
                    })
                        .then(response => {
                            if (response.ok) {
                                // 삭제 성공 시 댓글을 동적으로 제거
                                const commentElement = document.getElementById(`comment_${UID}`);
                                if (commentElement) {
                                    commentElement.remove();
                                }
                            } else {
                                alert("댓글 삭제에 실패했습니다.");
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });
                }
            }


            function likePost() {
                // 게시글 번호를 가져오기
                const num = <%= board.getNum() %>;

                fetch(`/community/walls/${num}/like`, {
                    method: 'POST'
                })
                    .then(response => {
                        if (response.ok) {
                            return response.json(); // JSON 응답을 파싱
                        } else {
                            throw new Error('좋아요 실패');
                        }
                    })
                    .then(data => {
                        // 좋아요 수를 동적으로 화면에 업데이트
                        document.getElementById('likesCount').innerText = data;
                    })
                    .catch(error => {
                        console.error('에러', error);
                    });
            }

            function likeComment(UID) {
                fetch(`/likeComment`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ UID: UID })
                })
                    .then(response => {
                        if (response.ok) {
                            return response.json();
                        } else {
                            throw new Error('좋아요 실패');
                        }
                    })
                    .then(data => {
                        // 좋아요 수를 동적으로 화면에 업데이트
                        document.getElementById('likesCount_').innerText = data;

                    })
                    .catch(error => {
                        console.error('에러', error);
                    });
            }



        </script>
    </head>
    <body>

        <main>
            <section id="board">
                <%--<h2>게시글 작성하기</h2>--%>
                <div class="post1">
                    <div class="post-header">
                        <div class="title">${board.title}
                        </div>
                        <div class="post-info">
                            <div class="author"> ${board.category}　|　${board.nick}
                            </div>
                            <div class="post-info__right_wrap">
                                <div class="writetime">
                                    <c:choose>
                                        <c:when test="${today == postDate}">
                                            <div class="writetime">
                                                <fmt:formatDate value="${board.writetime_Ts}" pattern="HH:mm" />
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="writetime">
                                                <fmt:formatDate value="${board.writetime_Ts}" pattern="MM-dd" />
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="views">조회 <%= board.getViews() %>
                                </div>
                                <div class="comments">댓글 <%= commentCount %>
                                </div> <!-- 확인하기 -->
                                <c:if test="${board.UID == sessionScope.logUID}">
                                    <button class="comBtns" onclick="deletePost(<%= board.getNum() %>)">삭제</button>
                                </c:if>

                            </div>
                        </div>
                    </div>
                    <div class="post-main">
                        <%= board.getContent() %>
                    </div>
                    <div class="likes">
                        <button class="comBtns" onclick="likePost()">좋아요</button>
                        <span id="likesCount">
                            (${board.likes})
                        </span>
                    </div>


                    <div class="viewcomment">
                        <div><h3>댓글(<%= commentCount %>)</h3></div>
                        <c:forEach var="comments" items="${comments}">
                            <!-- 코멘트 데이터베이스 확인하고 수정 요함 -->
                            <div id="comment_${comments.getUID()}" class="comment">
                                <div class="c-author">${comments.getNick()}</div>
                                <div class="c-comment">${comments.getContent()}</div>
                                <div class="comment-info">
                                    <div class="c-writetime">
                                        <c:choose>
                                            <c:when test="${today == postDate}">
                                                <div class="c-writetime">
                                                    <fmt:formatDate value="${comments.getWritetime()}" pattern="HH:mm" />
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="c-writetime">
                                                    <fmt:formatDate value="${comments.getWritetime()}" pattern="MM-dd" />
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="c-likes">
                                        <button class="comBtns" onclick="likeComment(${comments.getUID()})">좋아요</button> (<span id="likesCount_">${comments.getLikes()}</span>)
                                    </div>
                                    <button class="comBtns" onclick="deleteComment(${comments.getUID()})">삭제</button>
                                </div>
                            </div>
                        </c:forEach>

                        <div class="comment-input">
                            <form action="/addComment" method="post">
                                <input type="hidden" name="UID2" value="${board.UID}">
                                <input type="hidden" name="num" value="${board.num}">
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
                    <a href="/community/edit/<%= board.getNum() %>">
                        <button class="comBtns">수정</button>
                    </a>
                    <button class="comBtns" onclick="toList()">목록</button>

                </div>
            </section>
        </main>
    </body>
</html>


<script src="/resources/main/gnb_community.js"></script>