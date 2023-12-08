<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<head>

</head>
<body>
<h1>ㅎㅇ2</h1>
<a href="<%=request.getContextPath()%>/account/login">로그인</a>
<a href="<%=request.getContextPath()%>/account/signIn">회원가입</a>
<a href="<%=request.getContextPath()%>/account/logout">로그아웃</a>
<hr>
<a href="<%=request.getContextPath()%>/general/role">일반 사용자</a>
<a href="<%=request.getContextPath()%>/business/role">사업자 사용자</a>
<a href="<%=request.getContextPath()%>/admin/role">관리자</a>
<hr>
<a href="<%=request.getContextPath()%>/community/wishlist">위시리스트</a>
<a href="<%=request.getContextPath()%>/community/walls">담벼락</a>
<a href="<%=request.getContextPath()%>/community/dadaima">다녀왔습니다</a>
<a href="<%=request.getContextPath()%>/community/recommendme">추천해주세요</a>
<a href="<%=request.getContextPath()%>/community/myrecipe">나만의 레시피</a>
<a href="<%=request.getContextPath()%>/community/writing">글쓰기</a>
<p>${logIn}</p>
<p>${logUID}</p>
<p>${logNick}</p>



</body>
