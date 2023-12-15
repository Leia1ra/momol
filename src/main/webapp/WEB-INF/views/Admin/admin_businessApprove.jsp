<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<head>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin_businessApprove.css" type="text/css"/>
	<%--<script>
		function imgUpLoad(){
			let imgUpload = document.getElementById("upload");
			let imgPreview = document.getElementById("preview");

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
	</script>--%>
</head>
<section id="sectionContainer">
	<header id="MainTitleHeader">
		<h2>사업자 인증</h2>
		<span></span>
	</header>
	<article id="mainArticle">
		<form method="post" action="<%=request.getContextPath()%>/Admin/certifyReject" id="writeForm">
			<label id="lside">
				<h3>인증 사진</h3>
				<img src="/resources/img/Certificate/${CertificateImg}" alt="" id="preview">
			</label>

			<div id="rside">
				<div id="rTopSide">
					<select name="authorization" id="authorization">
						<option value="approve">승인</option>
						<option value="reject">반려</option>
					</select>
					<input type="submit" value="제출">
				</div>
				<input type="text" name="Name" placeholder ="사업자 이름" value="${user.name}">
				<input type="text" name="Phone" placeholder ="사업자 전화번호" value="${user.phone}">
				<input type="text" name="Email" placeholder ="사업자 이메일" value="${user.email}">
				
				<input type="text" name="bizno" placeholder ="사업자 번호" value="${business.bizno}">
				<input type="text" name="UID" placeholder ="UID" value="${business.UID}">
				<input type="text" name="place" placeholder ="장소" value="${business.place}">
				<input type="text" name="other" placeholder ="other..?" value="${business.other}">
				<input type="text" name="address" placeholder ="주소" value="${business.address}">
				<input type="text" name="date" placeholder ="영업일" value="${business.date}">
				<input type="text" name="time" placeholder ="영업시간" value="${business.time}">
				
			</div>
		</form>
	</article>
</section>