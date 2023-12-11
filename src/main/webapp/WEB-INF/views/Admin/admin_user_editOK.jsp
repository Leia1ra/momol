<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<script>
    <%--alert("${result}");--%>
    if ( ${result} === 1) {
        alert("닉네임 변경 성공");
    } else {
        alert("닉네임 변경 실패");
    }
    //창 닫기
    window.close();
</script>