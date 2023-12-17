<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script>
        function searchCheck() {
            if(document.getElementById("searchWord").value == ""){
                alert("검색어를 입력 후 검색하세요");
                return false;
            }
        }
	</script>
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
            border: 1px solid #93C759;
            border-radius: 10px;
            transition: 0.3s ease-in-out;
		}
        .storeList:hover, .storeList:hover a{
            color: white !important;
            background: #93C759;
        }
        
        
		.storeList>a{
			height: 100%;
			padding: 10px;
            display: grid;
            grid-template-rows: 200px 1fr;
            grid-template-columns: 1fr;
            transition: 0.3s ease-in-out;
            border-radius: 10px;
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
		
		
		.page{
            height: 40px;
            padding-left: 20px;
            padding-right: 20px;
			display: flex;
			justify-content: space-between;
			align-items: center;
		}
		.page>ul{
			width: 300px;
			height: 40px;
			display: grid;
			grid-template-columns: 1fr repeat(5,40px) 1fr;
		}
        .page>ul>li:first-child{
            grid-column: 1;
        }
        .page>ul>li:last-child{
            grid-column: 7;
        }
        .page>ul>li{
	        width: 100%;
	        height: 100%;
            line-height: 40px;
	        text-align: center;
            border-radius: 5px;
        }
        .page>ul>li>a{
	        display: block;
	        width: 100%;
	        height: 100%;
	        line-height: 40px;
	        text-align: center;
	        border-radius: 5px;
	        transition: 0.3s ease-in-out;
        }
        .page>ul>li>a:hover{
            background: #1ebee6;
	        color: white;
        }
        
        .search{
            width: 300px;
	        height: 40px;
        }
        .search>form{
	        width: 100%;
	        display: flex;
            height: 40px;
        }
        .search>form>select{
            height: 100%;
	        text-align: center;
	        border-bottom-left-radius: 10px;
	        border-top-left-radius: 10px;
            border: 1px solid #93C759;

            border-right: 0;
	        flex-grow: 0.5;
        }
        .search>form>input{
	        height: 100%;
            border: 1px solid #93C759;
        }
        .search>form>input:first-child{
            padding: 0;
	        width: 100%;
	        flex-grow: 10;
        }
        .search>form>input:last-child{
            border: 1px solid #93C759;
            border-left: 0;
            border-bottom-right-radius: 10px;
            border-top-right-radius: 10px;
            color: white;
	        background: #93C759;
	        flex-grow: 0.5;
	        transition: 0.3s ease-in-out;
        }
        .search>form>input:last-child:last-child:hover{
	        filter: brightness(110%);
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
	<div class="page">
		<div class="search">
			<form action="<%=request.getContextPath()%>/store/list" onsubmit="return searchCheck()">
				<select name="searchKey">
					<option value="place">상호명</option>
<%--					<option value="address">주소</option>--%>
				</select>
				<input type="text" name="searchWord" id="searchWord">
				<input type="submit" value="Search">
			</form>
		</div>
		<ul>
			<%--prev : 현재 보는 페이지를 기준으로 이전페이지로 이동--%>
			<c:if test="${pVO.nowPage == 1}">
				<li>prev</li>
			</c:if>
			<c:if test="${pVO.nowPage>1}">
				<li><a href="<%=request.getContextPath()%>/store/list?nowPage=${pVO.nowPage - 1}<c:if test="${pVO.searchWord != null}">&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">prev</a></li>
			</c:if>
			
			<%--page--%>
			<c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount -1}">
				<c:if test="${p <= pVO.totalPage}">
					<%--출력할 페이지 번호가 총 페이지 수보다 작거나 같을때 페이지 번호 출력--%>
					<c:if test="${p == pVO.nowPage}"><%--현재 페이지일때--%>
						<li style="background-color: #93C759">
					</c:if><%--현재 페이지가 아닐때--%>
					<c:if test="${p != pVO.nowPage}">
						<li>
					</c:if>
					<a href="<%=request.getContextPath()%>/store/list?nowPage=${p}<c:if test="${pVO.searchWord != null}">&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p}</a>
					</li>
				</c:if>
			</c:forEach>
			
			<%--next--%>
			<c:if test="${pVO.nowPage < pVO.totalPage}">
				<li><a href="<%=request.getContextPath()%>/store/list?nowPage=${pVO.nowPage + 1}<c:if test="${pVO.searchWord != null}">&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">next</a></li>
			</c:if>
			<c:if test="${pVO.nowPage >= pVO.totalPage}">
				<li>next</li>
			</c:if>
		</ul>
	</div>
</main>
</body>
