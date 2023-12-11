<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="/resources/Cocktail/wordbook.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/resources/Cocktail/WordBook.css" type="text/css">
</head>
<body onload="setDefaultActive()">
<main>

    <div class="container">
        <a href="<%=request.getContextPath()%>/Cocktail/cakmain"><div class="section" onclick="changeActive(this)">
            <h2>칵테일 정보</h2>
        </div></a>

        <a href="<%=request.getContextPath()%>/Cocktail/jaeryomain"><div class="section" onclick="changeActive(this)">
            <h2>재료 정보</h2>
        </div></a>

        <a href="<%=request.getContextPath()%>/Cocktail/wordbook"><div class="section" onclick="changeActive(this)">
            <h2>용어 사전</h2>
        </div></a>
    </div>

        <table>
            <tr>
                <th>용어</th>
                <th>설명</th>
            </tr>
            <tr>
                <td>칵테일</td>
                <td>두 가지 이상의 음료를 혼합하여 만든 음료. 주로 알코올이 포함되지만, 알코올이 없는 칵테일도 있다.</td>
            </tr>
            <tr>
                <td>몰탈</td>
                <td>칵테일을 만들 때 사용하는 도구 중 하나로, 약재를 갈아서 물질을 추출하는 데 사용한다.</td>
            </tr>
            <tr>
                <td>믹서</td>
                <td>칵테일 재료를 빠르게 혼합하는 데 사용하는 기계.</td>
            </tr>
            <tr>
                <td>샷</td>
                <td>알코올 음료를 소량으로 한 번에 마시는 것.</td>
            </tr>
            <tr>
                <td>스트레이너</td>
                <td>칵테일을 만들 때 사용하는 도구 중 하나로, 칵테일을 다른 그릇으로 붓을 때 과일 씨나 얼음 등을 걸러내는 데 사용합니다.</td>
            </tr>
            <tr>
                <td>네온</td>
                <td>칵테일에 쓰이는 알코올 음료의 한 종류로, 특히 색이 뚜렷한 칵테일을 만드는 데 사용됩니다.</td>
            </tr>
            <tr>
                <td>칵테일 쉐이커</td>
                <td>칵테일 재료를 강하게 흔들어 혼합하는 데 사용하는 도구입니다.</td>
            </tr>
            <tr>
                <td>리퀴어</td>
                <td>과일, 허브, 스파이스 등으로 맛을 낸 달콤한 알코올 음료로, 칵테일에 다양한 맛과 색을 추가하는 데 사용됩니다.</td>
            </tr>
            <tr>
                <td>뮬</td>
                <td>보드카를 기반으로 하는 칵테일의 한 종류로, 라임 주스와 진저 비어를 추가하여 만듭니다.</td>
            </tr>
            <tr>
                <td>카라펠</td>
                <td>와인이나 주스 등을 담는 유리나 도자기 그릇을 말합니다. 칵테일을 담는 데도 사용됩니다.</td>
            </tr>
            <tr>
                <td>칵테일 쉐이커</td>
                <td>칵테일 재료를 강하게 흔들어 혼합하는 데 사용하는 도구입니다.</td>
            </tr>
            <tr>
                <td>칵테일 쉐이커</td>
                <td>칵테일 재료를 강하게 흔들어 혼합하는 데 사용하는 도구입니다.</td>
            </tr>
            <tr>
                <td>블렌더</td>
                <td>과일이나 얼음을 갈아서 스무디나 프로즌 칵테일을 만드는 데 사용하는 기계입니다.
            </tr>
            <tr>
                <td>데코레이션</td>
                <td>칵테일 잔에 장식을 추가하는 것을 말하며, 과일 슬라이스, 허브, 꽃 등을 사용합니다.
            </tr>
            <tr>
                <td>뮤델러</td>
                <td>과일이나 허브를 으깨는 데 사용하는 바 도구입니다.
            </tr>
            <tr>
                <td>피치</td>
                <td>여러 사람이 공유할 수 있는 양의 칵테일을 담는 큰 그릇입니다.
            </tr>
            <tr>
                <td>소다</td>
                <td>탄산수를 의미하며, 다양한 칵테일에 사용됩니다.
            </tr>
            <tr>
                <td>스피릿</td>
                <td>고알코올 음료를 일반적으로 가리키는 용어입니다.
            </tr>
            <tr>
                <td>토닉 워터</td>
                <td>퀴닌이 들어간 탄산 음료로, 진 토닉 등의 칵테일에 사용됩니다.
            </tr>
            <tr>
                <td>비터스</td>
                <td>강한 향과 맛을 가진 알코올 음료로, 칵테일에 복합적인 맛을 추가하는 데 사용됩니다.
            </tr>
            <tr>
                <td>에일</td>
                <td>발효시킨 맥주의 한 종류로, 몇몇 칵테일에 사용됩니다.
            </tr>
            <tr>
                <td>가니쉬</td>
                <td>칵테일의 마지막 장식으로, 보통 과일이나 허브를 사용합니다.
            </tr>
            <tr>
                <td>플로터</td>
                <td>칵테일의 상단에 알코올을 부유시키는 방법을 말합니다.
            </tr>
            <tr>
                <td>레이어</td>
                <td>칵테일 재료를 층으로 나누어 부어서 색을 분리하는 방법을 말합니다.
            </tr>
            <tr>
                <td>모히토</td>
                <td>럼, 라임 주스, 민트, 설탕, 소다 워터로 만드는 칵테일의 한 종류입니다.
            </tr>
            <tr>
                <td>마티니</td>
                <td>진 또는 보드카와 드라이 베르무트로 만드는 칵테일의 한 종류입니다.
            </tr>
            <tr>
                <td>올드 패션드</td>
                <td>위스키, 설탕, 비터스로 만드는 칵테일의 한 종류입니다.
            </tr>
            <tr>
                <td>플레임</td>
                <td>칵테일을 불을 붙여 만드는 방법을 말합니다.
            </tr>
            <tr>
                <td>러스트</td>
                <td>칵테일 재료가 산화되거나 변색하는 것을 말합니다.
            </tr>
            <tr>
                <td>미스트</td>
                <td>칵테일에 물방울을 분사하는 방법을 말합니다.
            </tr>
            <tr>
                <td>버번</td>
                <td>주로 미국에서 생산하는 옥수수 기반의 위스키입니다.
            </tr>
            <tr>
                <td>스카치</td>
                <td>스코틀랜드에서 생산하는 보리 기반의 위스키입니다.
            </tr>
            <tr>
                <td>아이리시</td>
                <td>아일랜드에서 생산하는 보리 기반의 위스키입니다.
            </tr>
            <tr>
                <td>브랜디</td>
                <td>와인을 증류하여 만든 알코올 음료입니다.
            </tr>
            <tr>
                <td>룸</td>
                <td>설탕수수를 증류하여 만든 알코올 음료입니다.
            </tr>
            <tr>
                <td>테킬라</td>
                <td>아가베를 증류하여 만든 알코올 음료입니다.
            </tr>
            <tr>
                <td>진</td>
                <td>주니퍼 베리를 주재료로 증류하여 만든 알코올 음료입니다.
            </tr>
            <tr>
                <td>보드카</td>
                <td>곡물이나 감자를 증류하여 만든 알코올 음료입니다.
            </tr>
            <tr>
                <td>샴페인</td>
                <td>프랑스 샴페인 지방에서 생산하는 탄산 와인입니다.
            </tr>
            <tr>
                <td>위스키</td>
                <td>곡물을 증류하여 만든 알코올 음료입니다.
            </tr>
            <tr>
                <td>코르키</td>
                <td>와인 병의 코르크가 부서지거나 훼손될 때 나타나는 와인의 불쾌한 맛을 말합니다.
            </tr>
            <tr>
                <td>디제스티프</td>
                <td>식사 후에 마시는 알코올 음료를 일컫는 용어입니다.
            </tr>
            <tr>
                <td>어퍼티프</td>
                <td>식사 전에 마시는 알코올 음료를 일컫는 용어입니다.
            </tr>
        </table>

</main>
</body>