<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<main>
    <div class="main_wrap">
        <section class="page_title">
            <p class="page_title__main">
                술장고
            </p>
            <p class="page_title__sub">
                나만의 술장고를 만들어보세요!
            </p>

            <!--구분선-->
            <hr class="main_wrap__hr">
        </section>

        <section id="suljanggo">

            <!--재료 선택하는 부분-->
            <div class="suljanggo_box" id="suljanggo_zairyo">
                <div class="s__zairyo__top">
                    <div class="s__zairyo__top__text">
                        <form id="sel_category">
                            <label class="z_sel">
                                <input type="radio" name="sel" value="d_all" checked>
                                <span>전체</span>
                            </label>

                            <label class="z_sel">
                                <input type="radio" name="sel" value="d_week">
                                <span>강한도수</span>
                            </label>

                            <label class="z_sel">
                                <input type="radio" name="sel" value="d_week">
                                <span>약한도수</span>
                            </label>

                            <label class="z_sel">
                                <input type="radio" name="sel" value="d_drink">
                                <span>음료수</span>
                            </label>

                            <label class="z_sel">
                                <input type="radio" name="sel" value="d_juice">
                                <span>주스</span>
                            </label>

                            <label class="z_sel">
                                <input type="radio" name="sel" value="d_fruit">
                                <span>과일</span>
                            </label>

                            <label class="z_sel">
                                <input type="radio" name="sel" value="d_ect">
                                <span>기타</span>
                            </label>
                        </form>

                    </div>

                    <!-- 검색창 -->
                    <div class="s__zairyo__top__search">
                        <input type="search" placeholder="검색어를 입력하세요" class="search_input">
                        <span class="material-icons search_icon search_btn" id="combain__search_btn">search</span>
                    </div>
                </div>
                <div class="s__zairyo__bottom">

                    <form id="sel_zairyo">

                        <p class="combain__notice_text_box"></p>

                        <%-- 재료 총 allIngList 출력--%>
                        <c:forEach var="ing" items="${allIngList}">

                            <label>
                                <input type="checkbox" name="ing" value="${ing}" >
                                <span>${ing}</span>
                            </label>

                        </c:forEach>

                    </form>


                </div>
            </div>

            <!-- 선택된 재료 보여지는 부분-->
            <div class="suljanggo_box" id="suljanggo_sel">
                <div class="suljanggo_sel__top">
                    <p class="suljanggo_top_text">선택된 재료</p>
                    <div class="suljanggo_sel__btns">
                        <button class="suljanggo_sel__btn btn btn-secondary btn-sm" id="sel__reset">초기화</button>

                        <c:choose>
                            <c:when test="${sessionScope.logIn == 'Y'}">
                                <button class="suljanggo_sel__btn" id="sel__load">불러오기</button>
                                <button class="suljanggo_sel__btn" id="sul__save">저장</button>
                            </c:when>

                            <c:otherwise>
                                <button class="suljanggo_sel__btn disabled" id="sel__load">불러오기</button>
                                <button class="suljanggo_sel__btn disabled" id="sul__save">저장</button>
                            </c:otherwise>

                        </c:choose>


                    </div>
                </div>
                <div class="suljanggo_sel__bottom" id="selectedList">
                    <span> 선택된 재료가 없습니다.</span>
                </div>

            </div>

            <%
                //로그인 중이면 불러오기/저장 기능 활성화 -> 클래스 추가
                if ( session.getAttribute("logIn") == "Y") {

                } else {

                }
            %>

            <!-- 만들 수 있는 술 리스트 출력 -->
            <div class="suljanggo_box" id="suljanggo_result">

                <div class="suljanggo_result__top">
                    <p class="suljanggo_top_text">만들 수 있는 칵테일</p>
                    <p class="suljanggo_top_canmakecount"> 재료를 입력해 주세요 </p>

                    <div id="suljanggo_result__middle">
                    </div>

                </div>

            </div>

        </section>
    </div>

    <script>

    </script>

    <script src="/resources/combain/combain.js"></script>
    <script src="/resources/combain/combain_cate.js"></script>

</main>