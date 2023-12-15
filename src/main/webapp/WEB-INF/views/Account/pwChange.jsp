<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
<%--    <link rel="stylesheet" href="resources/Account/login.css">--%>
    <link rel="stylesheet" href="/resources/Account/pwChange/pwChange.css" type="text/css">
    <script src="/resources/Account/pwChange/pwCheck.js"></script>
</head>
<body onload="findPw('${type}','${tmp}')">
<main>
    <!-- sign Section -->
    <section id="pwCh_section">
        <header>
            <h1>비밀번호 변경</h1>
        </header>
        <article>
            <form id="pwChange" method="post" action="<%=request.getContextPath()%>/account/pwChangeOk">
                <input type="password" name="Pw" id="pw" placeholder="기존 비밀번호를 입력해주세요">
                <input type="password" name="newPw" id="newPw" placeholder="새 비밀번호를 입력해 주세요" >
                <input type="password" id="pwRe" placeholder="비밀번호 확인">
                <progress max="4" value="0" id="meter"></progress>
                <div id="err"></div>
                <input type="hidden" name="UID" id="UID" value="${UID}">
                <input type="hidden" name="type" id="type" value="${type}">
                <input type="submit" id="submit" value="Password Change">
            </form>
        </article>
    </section>
    <script>
        console.log(${UID})
    </script>
</main>
</body>
