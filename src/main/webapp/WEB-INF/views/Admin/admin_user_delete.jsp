<%@ page language="java"  pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>

    if ("${result}" > 0) {
        alert("회원을 탈퇴시켰습니다.");
    } else {
        alert("탈퇴시키는데 실패하였습니다.");
    }

    window.close();

</script>