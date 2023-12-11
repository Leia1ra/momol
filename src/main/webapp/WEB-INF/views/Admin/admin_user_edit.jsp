<%@ page language="java"  pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">


<style>
    #ect_header, #footer, header, footer, nav, aside {
        display: none;
    }
</style>


<p> 받아온 아이디 : ${userid} </p>
<p> 받아온 닉네임 : ${usernick} </p>

<p> 아이디(${userid})의 닉네임 "${usernick}"을 수정하시겠습니까?</p>

<form action="usernickedit" method="post">
    <input type="hidden" name="userid" value="${userid}">
    <input value="${usernick}" type="text" name="usernick" id="usernick" placeholder="닉네임을 입력해주세요.">
    <button id="submit_btn" class="btn btn-primary" type="submit">수정</button>
</form>

<script>

    //유효성 검사
    $(function(){
        $("#submit_btn").click(function(){
            if($("#usernick").val() == ""){
                alert("닉네임을 입력해주세요.");
                $("#usernick").focus();
                return false;
            }
        });
    });




</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
