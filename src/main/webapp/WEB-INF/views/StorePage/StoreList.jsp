<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<style>
		#storePageMain * {
			box-sizing: border-box;
		}
		#storePageMain{
			max-width: 1200px;
			width: 100%;
		}
		#storePageMain>h1{
			font-size: 3em;
			text-align: center;
			margin-bottom: 50px;
		}
		@media (max-width: 900px) {
			#stores{
                grid-template-columns: 1fr 1fr 1fr !important;
			}
        }
        @media (max-width: 800px) {
            #stores{
                grid-template-columns: 1fr 1fr !important;
            }
        }
		#stores{
			display: grid;
			grid-template-columns: 1fr 1fr 1fr 1fr;
			/*grid-template-rows: 1fr 1fr;*/
			justify-items: center;
			/*flex-direction: row;*/
			/*flex-wrap: wrap;*/
		}
		.storeList{
			max-width: 300px;
			min-width: 200px;
			/*width: 100%;*/
			height: 400px;
            margin: 10px;
            border: 1px solid #1ebee6;
			
		}
		.storeList>a{
			height: 100%;
			padding: 10px;
            display: grid;
            grid-template-rows: 200px 1fr;
            grid-template-columns: 1fr;
		}
		/* 이미지 */
		.imgView{
			width: 100%;
            height: 200px;
			overflow: hidden;
			display: flex;
			justify-content: center;
			align-items: center;
			border-radius: 10px;
		}
        .storeList img{
	        width: 100%;
        }
        /* 기타 문구 */
		.storeDescription{
			display: grid;
			grid-template-rows:  40px 1fr;
			grid-template-columns: 1fr;
			align-items: stretch;
		}
		.storeDescription>h3{
			font-weight: bold;
			font-size: 1.5em;
			text-align: center;
			line-height: 40px;
		}
		.storeDescription>div{
            padding: 10px;
		}
	</style>
</head>
<body>
<main id="storePageMain">
	<h1>상점 리스트</h1>
	<section id="stores">
		<c:forEach var="li" items="${list}">
		<article class="storeList">
			<a href="/store/view?bizno=${li.bizno}">
				<div class="imgView">
					<img src="/resources/img/Store/${li.UID}/${li.imgPath}" alt="" onerror="this.src='/resources/main/menuNone.png'">
				</div>
				<div class="storeDescription">
					<h3>${li.place}</h3>
					<div>${li.other}</div>
				</div>
			</a>
		</article>
		</c:forEach>
	</section>
	
</main>
</body>
