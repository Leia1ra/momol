<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
<%--    <link rel="stylesheet" href="resources/Account/login.css">--%>
    <link rel="stylesheet" href="/resources/Mypage/b-style.css" type="text/css">
    <script src="/resources/Mypage/b-style.js"></script>
</head>
<body >
<main>
    <script>
        function imgUpLoad(){
            let imgUpload = document.getElementById("business-p_img");
            let imgPreview = document.getElementById("img1");
            
            let file = imgUpload.files[0];
            if(file){
                let reader = new FileReader();
                reader.onload = function (e){
                    imgPreview.src = e.target.result;
                };
                reader.readAsDataURL(file);
            } else {
                imgPreview.src="";
            }
        }
        <c:if test="${v == 't'}">
            const menu = new Menu(${list.size()}, '${business.getBizno()}')
        </c:if>
    </script>
    <!-- 사업자페이지 -->
    <p id="business-p1">사업장 정보 작성</p>
    <!-- 사업장 정보 -->
    <form method="post" action="/mmypage/businessOk" enctype="multipart/form-data">
        <div id="business-h1">
            <div id="business-h1-left">
                <input type="text" id="business-h1-left-middle" name="bizno" value="${business.getBizno()}" placeholder="사업자 번호를 입력해주세요" required>
                <input type="text" id="business-h1-left-top" name="place" value="${business.getPlace()}" placeholder="상점 이름을 작성해주세요" required>
                <label id="business-h1-left-bottom">
                    <img id="img1" src="${storeImage}" onerror="this.src='/resources/main/menuNone.png'"/>
                    <input type="file" id="business-p_img" name="p_img" hidden
                           onchange="imgUpLoad()" accept="image/jpeg, image/png">
                    <div id="imgMessage">
                        <div>
                        사진을 변경하려면 클릭하세요
                        </div>
                    </div>
                </label>
            </div>
            
            <div id="business-h1-right">
                <input type="text" id="business-h1-right-top" name= "address" value="${business.getAddress()}" placeholder="주소를 입력해주세요" required>
            
                <div id="business-h1-right-middle">
                    <input type="text" id="business-h1-right-bottom-top-left" name= "date" value="${business.getDate()}" placeholder="영업일" required>
                    <input type="text" id="business-h1-right-bottom-top-right" name= "time" value="${business.getTime()}" placeholder="영업시간" required>
                </div>
                <textarea type="text" name="other" placeholder="상점에 대한 소개글과 기타사항"
                          id="business-h1-right-bottom">${business.getOther()}</textarea>
            </div>
        </div>
        
        <div id="business-submit-div1">
            <input type="hidden" name="businessInfo" value="${v}">
            <input type="submit" id="business-submit1" value="비지니스 업로드" />
        </div>
    </form>
    
    <c:if test="${business.approved}">
    <!-- 주요메뉴 -->
    <article id="business-h2">
        <h3 id="business-p2">주요메뉴</h3>
        
        <div id="business-ul">
            <c:forEach var="m" items="${list}" begin="0" step="1" varStatus="index">
                <form method="post" class="business-form" action="#" enctype="multipart/form-data">
                    <label class="menuImg">
                        <img class="menu" src="${m.imgPath}" onerror="this.src='/resources/main/menuNone.png'"/>
                        <input type="file" class="menu_imgFile" name="menu_imgFile" hidden
                               onchange="menuImgUpLoad(${index.count - 1})" accept="image/jpeg, image/png">
                        <div class="menuImgMessage">
                            <div>
                                사진을 변경하려면 클릭하세요
                            </div>
                        </div>
                    </label>
                    <div class="menuInfo">
                        <input type="text" class="menuSubject" name="subject" value="${m.subject}" placeholder="subject" required>
                        <input type="text" class="menuContent" name="content" value="${m.content}" placeholder="content" required>
                        <div class="menuInfoUpdate">
                            <input type='button' class="menuUpdateBtn" value='메뉴 업데이트' onclick="menu.menuUpdate('${m.subject}', ${index.count-1})">
                            <input type="button" class="menuDeleteBtn" value="메뉴 삭제" onclick="menu.menuDelete(${index.count-1})">
                        </div>
                    </div>
                </form>
            </c:forEach>
        </div>
        <button id="expand-button" onclick="menu.expandMenu()">메뉴 작성란 추가하기</button>
    </article>
    </c:if>
</main>
</body>
