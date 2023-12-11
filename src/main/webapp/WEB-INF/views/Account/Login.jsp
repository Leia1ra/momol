<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
<%--    <link rel="stylesheet" href="resources/Account/login.css">--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/Account/login/login.css" type="text/css">
    <script src="/resources/Account/login/login.js"></script>
</head>
<body>
<main>
    <!-- Login Section -->
    <section id="login_section">
        <header>
            <h1>로그인</h1>
        </header>
        <article>
            <form id="login" method="post" action="<%=request.getContextPath()%>/account/loginOk">
                <input type="text" name="Id" id="id" placeholder="아이디를 입력해주세요">
                <input type="password" name="Pw" id="pw" placeholder="비밀번호를 입력해주세요">
                <div id="err">${exception}</div>
                <div>
                    <a href="<%=request.getContextPath()%>/account/findAccount?type=ID">아이디</a> /
                    <a href="<%=request.getContextPath()%>/account/findAccount?type=PW">비밀번호</a> 찾기
                </div>
                <input type="submit" id="submit" value="LogIn">
            </form>
        </article>
    </section>
</main>
</body>
