<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<title>Title</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/Account/findAccount/findAccount.css">
	<script src="<%=request.getContextPath()%>/resources/Account/findAccount/findAccount.js"></script>
</head>
<body onload="stateFn('${type}')">
<main >
	<!-- Login Section -->
	<section id="find_section">
		<header>
			<h1 id="state"></h1>
		</header>
		<article>
			<form id="searchFrm" method="post" action="<%=request.getContextPath()%>/account/findAction">
				<div id="find">
					<label for="searchId">아이디 찾기 <input type="radio" name="search" id="searchId" value="ID"></label>
					<label for="searchPw">비밀번호 찾기 <input type="radio" name="search" id="searchPw" value="PW"></label>
				</div>
				<input type="text" name="Name" id="name" placeholder="이름을 입력해주세요" disabled >
				<input type="text" name="Id" id="id" placeholder="아이디를 입력해주세요" disabled>
				
				<input type="text" name="email" id="email" placeholder="이메일을 입력해주세요">
				<div id="err"></div>
				<input type="submit" id="submit" value="Submit">
			</form>
		</article>
	</section>
</main>
</body>
</html>
