<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
	<%--    <link rel="stylesheet" href="resources/Account/login.css">--%>
	<link rel="stylesheet" href="/resources/Account/signIn/signUpDone.css" type="text/css">
</head>
<body>
<main>
	<div id="heawon-v">
		<div id="heawon-top">
			<b id="heawon-b1">회원가입</b>
		</div>
		<div id="heawon-bottom">
			<div id="heawon-bottom-top">
				<img src="<%=request.getContextPath()%>/resources/img/signUpDone.png" alt="이미지를 불러오는데 실패하였습니다.">
			</div>
			<div id="heawon-bottom-mid">
				<p id="heawon-p1">모든 회원가입 절차가 완료되었습니다.
					<br>메일을 통한 인증과정 이후 모든 서비스를 이용하실 수 있습니다.</p>
			</div>
			<div id="heawon-bottom-bottom">
				<div id="heawon-bottom-bottom-top">
                <span class="heawon-span1">
                    <p class="heawon-p2">
						이름
                    </p>
                </span>
					<span class="heawon-span2">
                    <p class="heawon-p3">
						${vo.getName()}
                    </p>
                </span>
				</div>
				<div id="heawon-bottom-bottom-bottom">
                <span class="heawon-span1">
                    <p class="heawon-p2">
						아이디
                    </p>
                </span>
					<span class="heawon-span2">
                    <p class="heawon-p3">
	                    ${vo.getNick()}
                    </p>
                </span>
				</div>
			</div>
			<div id="heawon-bottom-bottom-button">
				<button id="expand-button2" onclick="location.href='<%=request.getContextPath()%>/'">메인으로</button>
			</div>
		</div>
	</div>
</main>
</body>
