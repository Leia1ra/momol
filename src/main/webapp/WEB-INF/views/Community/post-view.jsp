<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <h2>게시글 작성하기</h2>
        <div class="post1">
            <div class="post-header">
                <div class="title"><%= board.getTitle() %>
                </div>
                <div class="post-info">
                    <div class="author"><%= board.getUID() %>
                    </div>
                    <div class="writetime"><%= board.getWritetime() %>
                    </div>
                    <div class="views">조회 <%= board.getViews() %>
                    </div>
                    <div class="comments">댓글 <%= commentCount %>
                    </div> <!-- 확인하기 -->
                    <button onclick="deletePost(<%= board.getNum() %>)">삭제</button>
                </div>
            </div>
            <div class="post-main">
                <%= board.getContent() %>
            </div>
            <div class="likes">
                <button onclick="likePost()">좋아요</button> (<span id="likesCount"><%= board.getLikes() %></span>)
            </div>


            <div class="viewcomment">
                <div><h3>댓글(<%= commentCount %>)</h3></div>
                <c:forEach var="comments" items="${comments}">
                    <!-- 코멘트 데이터베이스 확인하고 수정 요함 -->
                    <div id="comment_${comments.getUID()}" class="comment">
                        <div class="c-author">${comments.getUID2()}</div>
                        <div class="c-comment">${comments.getContent()}</div>
                        <div class="comment-info">
                            <div class="c-writetime">
                                    ${comments.getWritetime()}
                            </div>
                            <div class="c-likes">
                                <button onclick="likeComment(${comments.getUID()})">좋아요</button> (<span id="likesCount_">${comments.getLikes()}</span>)
                            </div>
                            <button onclick="deleteComment(${comments.getUID()})">삭제</button>
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
            <a href="/community/edit/<%= board.getNum() %>">
                <button>수정</button>
            </a>
            <button onclick="toList()">목록</button>

        </div>
    </section>
</main>

<footer>
</footer>
</body>
</html>
