<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    main{
        max-width:1200px;
        min-width:600px;
        margin:0 auto;
    }
	#errorSection{
        max-width: 800px;
		width: 75%;
		margin: 0 auto;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	#errorSection>img{
		width: 50%;
		
	}
	#errorSection>h1{
		text-align: center;
		font-size: 3em;
        font-weight: bolder;
	}
	#errorSection>h2{
        font-size: 2em;
        font-weight: bolder;
		margin-bottom: 20px;
	}
	#errorSection>div{
		margin-bottom: 10px;
	}
	#errorSection>div:last-child{
		display: flex;
		flex-direction: row;
		justify-content: space-around;
	}
    #errorSection>div:last-child{
	    width: 100%;
        display: flex;
        flex-direction: row;
        justify-content: space-evenly;
	    margin-top: 25px;
    }
    #beforePage{
	    height: 40px;
	    width: 120px;
	    line-height: 40px;
	    text-align: center;
        border: 3px solid #1ebee6;
	    border-radius: 5px;
	    transition: 0.3s ease;
    }
    #beforePage:hover{
	    color: white;
        background: #1ebee6;
    }
    #goToMain{
        height: 40px;
        width: 120px;
        line-height: 40px;
        text-align: center;
        border: 3px solid #93C759;
        border-radius: 5px;
        transition: 0.3s ease;
    }
    #goToMain:hover{
        color: white;
        background: #93C759;
    }
</style>
<main>
    <section id="errorSection">
	    <h1>${status}</h1>
	    <img src="/resources/main/ErrorPage.png" alt="">
	    <h2>${message}</h2>
	    <div>
		    <div>페이지가 존재하지 않거나, 사용할 수 없는 페이지입니다.</div>
		    <div>입력하신 주소가 정확한지 다시 한번 확인해 주세요</div>
	    </div>
	    <div>
		    <a onclick="history.back()" id="beforePage">이전 페이지</a>
			<a href="/" id="goToMain">메인으로</a>
	    </div>
    </section>
</main>