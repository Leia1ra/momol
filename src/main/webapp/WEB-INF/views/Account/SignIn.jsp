<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
<%--    <link rel="stylesheet" href="resources/Account/login.css">--%>
    <link rel="stylesheet" href="/resources/Account/signIn/signIn.css" type="text/css">
    <script src="/resources/Account/signIn/signIn.js"></script>
</head>
<body>
<main>
    <!-- sign Section -->
    <section id="sign_section">
        <header>
            <h1>회원가입</h1>
        </header>
        <article>
            <form id="signIn" method="post" enctype="multipart/form-data"
                  action="<%=request.getContextPath()%>/account/signInOk">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <input type="text" name="Id" id="id" placeholder="아이디를 입력해주세요" value="dl1197">
                <input type="password" name="Pw" id="pw" placeholder="비밀번호를 입력해 주세요" value="123!@#">
                <input type="password" id="pwRe" placeholder="비밀번호 확인" value="123!@#">
                <progress max="4" value="0" id="meter"></progress>
                
                <input type="text" name="Nick" id="nick" placeholder="닉네임을 입력해주세요" value="leia92">
                <input type="text" name="Name" id="name" placeholder="이름을 입력해주세요" value="이선왕">
                <input type="email" name="email" id="email" placeholder="이메일을 입력해주세요" value="leiaira92@gmail.com">
                <div id="tel-container">
                    <input type="hidden" name="Phone" id="tel">
                    <select class="tel-nums">
                        <option value="010" selected>010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                        <option value="018">018</option>
                        <option value="019">019</option>
                    </select>
                    <span>-</span>
                    <input type="number" class="tel-nums" maxlength="4" placeholder="앞자리(4)" value="0000">
                    <span>-</span>
                    <input type="number" class="tel-nums" maxlength="4" placeholder="뒷자리(4)" value="1234">
                </div>
                
                <div id="personal">
                    <select name="gender" id="gender">
                        <option value="male">남성</option>
                        <option value="female">여성</option>
                        <option value="none">비공개</option>
                    </select>
                    <input type="date" name="Birth" id="birth" placeholder="생년월일">
                </div>
                <label for="business"><input type="checkbox" name="isBusiAcc" id="business" value="checked">사업자 계정으로 가입하기</label>
                <div id="business-input">
                    <p>민감한 개인정보를 가린 후 신분증, 사업자증명서 사진을 첨부해 주세요</p>
                    <input type="file" id="bc" name="Business_certificate"
                           disabled accept="image/jpeg, image/png" required>
                </div>
                <div id="err"></div>
                <input type="submit" id="submit" value="Sign In">
            </form>
        </article>
    </section>
</main>
</body>
