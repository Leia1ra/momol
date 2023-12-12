<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<style>
    #admin_recipe_wrap {
        width : 90%;
        margin : 0 auto;
    }
</style>

<main id="admin_recipe_wrap">

    <%--NAV BAR--%>
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">MOMOL_ADMIN</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/admin/board">게시판</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/comment">댓글</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/user">유저</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/recipe">레시피</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/ingredient">재료</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/worldcup">월드컵</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/report">신고</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/statistics">통계</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <p class="fs-2">칵테일 관리</p>
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">칵테일 추가</button>

    <!-- 재료 추가 Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">칵테일 추가하기</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <%----%>

                <div class="modal-body" id="recipe_add_form">
                    <div class="mb-3">
                        <label for="cock_name" class="form-label">칵테일 이름</label>
                        <input type="text" class="form-control" id="cock_name" name="name" placeholder="재료 이름 입력" required>
                    </div>

                    <div class="mb-3">
                        <label for="cock_name_eng" class="form-label">칵테일 이름(영어)</label>
                        <input type="text" class="form-control" id="cock_name_eng" name="name" placeholder="재료 이름(영문) 입력" required>
                    </div>

                    <%--도수--%>
                    <div class="mb-3">
                        <label for="abv" class="form-label">도수</label>
                        <input type="text" class="form-control" id="abv" name="abv" placeholder="도수 입력">
                    </div>

                    <div class="mb-3">
                        <label for="des" class="form-label">도수</label>
                        <input type="text" class="form-control" id="des" name="des" placeholder="칵테일 설명" required style="height:100px" >
                    </div>

                    <%--레시피--%>
                    <div class="mb-3">
                        <label for="recipe" class="form-label">레시피</label>
                        <input type="text" class="form-control" id="recipe" name="recipe" placeholder="레시피 입력" required
                               style = "height: 100px;">
                    </div>

                    <div class="mb-3">
                        <label for="img" class="form-label">이미지</label>
                        <input type="text" class="form-control" id="img" name="img" placeholder="이미지 링크 입력" required>
                        <button type="button" id="previewBtn" class="btn btn-info">이미지 미리보기</button>
                        <div id="img_preview_area">
                        </div>
                    </div>
                </div>

                <%----%>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" id="recipe_saveBtn">저장하기</button>
                </div>
            </div>
        </div>
    </div>

    <%-- 레시피 테이블 --%>
    <div class="">
        <table class="table table-hover table-striped">
            <thead class="table-dark">
                <tr class="active">
                    <th scope="col" class="col-sm-1">이미지</th>
                    <th scope="col" class="col-sm-1">이름</th>
                    <th scope="col" class="col-sm-1">영어이름</th>
                    <th scope="col" class="col-sm-1">도수</th>
                    <th scope="col" class="col-sm-3">설명</th>
                    <th scope="col" class="col-sm-3">레시피</th>
                    <th scope="col" class="col-sm-1">관리</th>

                </tr>
            </thead>
            <tbody>
                <c:forEach var="cocktail" items="${cocktail}">
                    <tr>
                        <td><img alt="cock_img" src="${cocktail.cocktail_img}" width="80px" height="auto"></td>
                        <td>${cocktail.name}</td>
                        <td>${cocktail.name_eng}</td>
                        <td>${cocktail.ABV}</td>
                        <td>${cocktail.cocktail_detail}</td>
                        <td>${cocktail.recipe}</td>
                        <td>
                            <form value="수정" class="btn btn-primary recipe_editBtn">수정</form>
                            <form value="삭제" class="btn btn-danger recipe_delBtn">삭제</form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</main>

<%--새 칵테일 추가하기--%>
<script>
    // 이미지 미리보기 버튼 구현
    const previewBtn = document.querySelector("#previewBtn");
    const preview_area = document.querySelector("#img_preview_area");

    previewBtn.addEventListener('click',(function() {
        const img_link = document.querySelector("#img").value;
        // console.log("프리뷰버튼 누름" + img_link);
        preview_area.innerHTML = "<img src='" + img_link + "' width='100px' height='auto'>";
            <%--`<img src="${img_link}" width="100px" height="auto">`;--%>
    }));

    // 칵테일 추가하기
    const recipe_saveBtn = document.querySelector("#recipe_saveBtn");
    function cocktail_add () {
        const cocktail_name = document.querySelector("#cock_name").value;
        const cocktail_name_eng = document.querySelector("#cock_name_eng").value;
        const cocktail_abv = document.querySelector("#abv").value;
        const cocktail_recipe = document.querySelector("#recipe").value;
        const cocktail_img = document.querySelector("#img").value;
        const cocktail_des = document.querySelector("#des").value;

        function validateForm() {
            if (
                cocktail_name.trim() === "" ||
                cocktail_name_eng.trim() === "" ||
                cocktail_abv.trim() === "" ||
                cocktail_recipe.trim() === "" ||
                cocktail_img.trim() === "" ||
                cocktail_des.trim() === "" ||
                !/^[가-힣]+$/.test(cocktail_name) ||
                !/^[a-zA-Z]+$/.test(cocktail_name_eng) ||
                !/^[0-9]+$/.test(cocktail_abv)
            ) {
                alert("입력된 값을 확인해주세요");
                return false;
            }
            return true;
        }

        const result = validateForm();
        if (!result) {
            return;
        } else {
            //여기부터 ajax
            $.ajax({
                type: "GET",
                url: "/admin/recipeAdd",
                data: {
                    cocktail_name: cocktail_name,
                    cocktail_name_eng: cocktail_name_eng,
                    cocktail_abv: cocktail_abv,
                    cocktail_des: cocktail_des,
                    cocktail_recipe: cocktail_recipe,
                    cocktail_img: cocktail_img
                },
                success: function (respon) {
                    // console.log("칵테일 추가 결과" + respon);
                    alert("칵테일 추가 완료");
                    location.reload();
                },
                error : function (error) {
                    console.log(error);
                    alert("칵테일 추가 실패");
                }

            })

        }



    }

    recipe_saveBtn.addEventListener('click', cocktail_add);

</script>

<script>

    const editBtn = document.querySelectorAll(".recipe_editBtn");
    const delBtn = document.querySelectorAll(".recipe_delBtn");

    // 칵테일 수정하기
    editBtn.forEach((btn) => {

        btn.addEventListener('click', (e) => {
            const name = btn.parentNode.parentNode.querySelector("td:nth-child(2)").textContent
            console.log(name);

            window.open ("/admin/recipeEdit?cocktail_name=" + name, "칵테일 수정하기", "width=500, height=500, left=100, top=50");

        })
    });


    // 칵테일 삭제하기
    const delBtns = document.querySelectorAll(".recipe_delBtn");
    delBtns.forEach((btn) => {
        btn.addEventListener('click', (e) => {
            const name = btn.parentNode.parentNode.querySelector("td:nth-child(2)").textContent
            console.log(name);

            //정말로 삭제하시겠습니까?
            if (!confirm("정말로 삭제하시겠습니까?")) {
                return;
            }

            $.ajax({
                type: "GET",
                url: "/admin/recipeDel",
                data: {
                    cocktail_name: name
                },
                success: function (respon) {
                    console.log("칵테일 삭제 결과" + respon);
                    alert("칵테일 삭제 완료");
                    location.reload();
                },
                error : function (error) {
                    console.log(error);
                    alert("칵테일 삭제 실패");
                }

            })

        })
    });


</script>




<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>