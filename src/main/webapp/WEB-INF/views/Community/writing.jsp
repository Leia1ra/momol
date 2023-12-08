<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <link rel="stylesheet" href="/resources/Community/style.css" type="text/css">
    <script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>
</head>
<body>
<main>
    <h2>글쓰기</h2>
    <form method="post" action="<%=request.getContextPath()%>/community/writing" id="posting">

        <!-- 생략... 나머지 폼 요소들 추가 -->

        <div class="btns">
            <a href="../"> <button id="cancelbtn">취소</button></a>
            <button type="button" id="confirmbtn">등록</button>
        </div>

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

        <div class="title"><input type="text" name="title" placeholder="제목을 입력해 주세요"></div>

        <textarea name="Content" id="editor">

    </textarea>

    </form>

    <script>
        ClassicEditor
            .create( document.querySelector( '#editor' ) )
            .catch( error => {
                console.error( error );
            } );

        document.getElementById('confirmbtn').addEventListener('click', function() {
            // 여기에 필요한 폼 검증 로직을 추가할 수 있습니다.

            // 폼 검증이 완료되면 폼을 서버에 제출
            document.getElementById('posting').submit();
        });

        // 페이지 로딩 후 자동으로 walls로 리다이렉트
        window.onload = function() {
            location.href = '<%=request.getContextPath()%>/community/walls';
        };
    </script>
</main>
</body>
</html>
