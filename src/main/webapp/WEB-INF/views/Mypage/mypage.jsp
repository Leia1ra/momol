<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<%--    <link rel="stylesheet" href="resources/Account/login.css">--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/resources/Mypage/a-style.css" type="text/css">
    <script src="/resources/Mypage/a-style.js"></script>

</head>
<body>
<main>
    <div id="activity-top">
        <b id="activity-b1">마이페이지</b>
        <input type="radio" class="activity-btn" id="activity-radio1" checked="checked"
               name="menu"/><label class="activity-lable" for = "activity-radio1"><b class="activity-b2">활동내역</b></label>
        <input type="radio" class="activity-btn" id="activity-radio2"
               name="menu"/><label class="activity-lable" for = "activity-radio2"><b class="activity-b3">회원정보수정</b></label>
    </div>

    <div id="v1">
        <div id="activity-mid">
            <p class="activity-p1">즐겨찾기 </p>
            <div id="activity-mid-button">
                <input type="button" id="show-more-btn"
                       value="더 보기" />
            </div>

            <ul id="activity-ul">
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">청하</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">참이슬</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">처음처럼</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">별빛청하</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">진로</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">새로</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">잭다니엘</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">마티니</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">마티니</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">마티니</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">마티니</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">마티니</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">마티니</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">마티니</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">마티니</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">마티니</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">마티니</p>
                </li>
                <li class="activity-li">
                    <div class="activity-li-div">

                    </div>
                    <p class="activity-p2">마티니</p>
                </li>

            </ul>

        </div>

        <div id="activity-bottom">
            <p class="activity-p1">
                내가 쓴 글
            </p>
            <div id="activity-bottom-subject">
                <div class="activity-bottom-subject-1">
                    <p class="activity-p3-1">
                        제목
                    </p>
                </div>
                <div class="activity-bottom-subject-2">
                    <p class="activity-p3">
                        카테고리
                    </p>
                </div>
                <div class="activity-bottom-subject-3">
                    <p class="activity-p3">
                        작성일
                    </p>
                </div>
                <div class="activity-bottom-subject-4">
                    <p class="activity-p3">
                        좋아요
                    </p>
                </div>
                <div class="activity-bottom-subject-5">
                    <p class="activity-p3">
                        조회수
                    </p>
                </div>
            </div>

            <ul id="activity-ul2">

                <c:forEach var="li" items="${postList}">
                    <li class="activity-li2">
                        <a>
                        <div class="activity-bottom-subject-1">
                            ${li.title}
                        </div>
                        <div class="activity-bottom-subject-2">
                            ${li.catnum}
                        </div>
                        <div class="activity-bottom-subject-3">
                            <fmt:formatDate value="${li.writetime}" pattern="yyyy-MM-dd" />
<%--                            ${li.writetime}--%>
                        </div>
                        <div class="activity-bottom-subject-4">
                            ${li.views}
                        </div>
                        <div class="activity-bottom-subject-5">
                            ${li.likes}
                        </div>
                        </a>
                    </li>
                </c:forEach>

            </ul>

            <div id="activity-pagenb">

                <button id="prev-page">이전</button>
                <div id="page-buttons"></div>
                <button id="next-page">다음</button>

            </div>

        </div>
    </div>

    <div id="v2">
        <p class="activity-p1">마이페이지</p>
        <div id="activity-v2">

            <form id="activity-form" method="post" action="/mmypage/mypageOk">
                <input type="text" class="activity-text" id="activity-id" name= "id" value="${user.getId()}" placeholder="ID" readonly>
                <input type="text" class="activity-text" id="activity-pw" name= "pw" value="${user.getPw()}" placeholder="PW" readonly>
                <input type="text" class="activity-text" id="activity-name" name= "name" value="${user.getName()}" placeholder="이름" readonly>
                <input type="text" class="activity-text" id="activity-nick" name= "nick" value="${user.getNick()}" placeholder="닉네임" readonly>
                <select class="activity-text" id="activity-gender" name= "gender" value="${user.getGender()}" placeholder="성별" readonly>
                    <option value="mail">남성</option>
                    <option value="femail">여성</option>
                    <option value="privat">비공개</option>
                </select>
                <input type="date" class="activity-text" id="activity-birth" name= "birth" value="${user.getBirth()}" placeholder="생년월일" readonly>
                <input type="text" class="activity-text" id="activity-phone" name= "phone" value="${user.getPhone()}" placeholder="전화번호" readonly>
                <input type="text" class="activity-text" id="activity-email" name= "email" value="${user.getEmail()}" placeholder="이메일" readonly>
                <input type="button" id="activity-button-business"
                       value="사업자 인증하기 or 사업자 프로필 보기" />
                <input type="button" id="activity-button" value="정보수정" />
                <input type="submit" id="activity-button-submit" value="정보저장" />
            </form>
        </div>
    </div>
</main>
</body>