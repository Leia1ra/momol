<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.example.momol.DTO.CommunityVO" %>

<% CommunityVO board = (CommunityVO) request.getAttribute("board"); %>
<html>
<head>
    <link rel="stylesheet" href="/resources/Community/style.css" type="text/css">
    <script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>
</head>
<body>
<main>
    <h2>글쓰기</h2>

    <form action="/community/edit/<%= board.getNum() %>" method="post" id="posting">

        <div class="boardselect">
            <select name="Catnum" id="Catnum">
                <option value="0">게시판을 선택해 주세요</option>
                <option value="1">담벼락</option>
                <option value="2">추천해 주세요</option>
                <option value="3">다녀왔습니다</option>
                <option value="4">나만의 레시피</option>
                <option value="5">위시리스트</option>
            </select>
        </div>

        <input type="text" name="title" value="<%= board.getTitle() %>" required>

        <!-- CKEditor -->
        <textarea name="content" required><%= board.getContent() %></textarea>

        <script>
            ClassicEditor
                .create( document.querySelector( '#editor' ) )
                .catch( error => {
                    console.error( error );
                });
        </script>

        <input type="hidden" name="UID" VALUE="asdads">

        <div class="btns">
            <a id="canclebtn" href="javascript:history.back()">취소</a>
            <input type="submit" id="confirmbtn" value="등록">
        </div>

        <script>
            function validate() {
                var catnumValue = document.getElementById('Catnum').value;

                if (catnumValue == 0) {
                    alert('카테고리를 지정해 주세요.');
                    return false;
                }
                return true;
            }
        </script>
    </form>
</main>
</body>
</html>

<script src="/resources/main/gnb_community.js"></script>