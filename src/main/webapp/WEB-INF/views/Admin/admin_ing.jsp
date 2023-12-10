<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<style>
    #admin_ingre {
        width : 80%;
        margin : 0 auto;
    }
</style>

<main id="admin_ingre">
    <%--nav bar--%>
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

    <%--표시--%>
    <p class="fs-2">재료 관리</p>
    <!-- Button trigger modal -->
    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
        재료 추가
    </button>
    <!-- 재료 추가 Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">재료 추가하기</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form class="modal-body" id="ingre_add_form">
                    <div class="mb-3">
                        <label for="ingredientName" class="form-label">재료 이름</label>
                        <input type="text" class="form-control" id="ingredientName" name="ingre_name" placeholder="재료 이름 입력" required>
                    </div>

                    <div class="mb-3">
                        <label for="ingredientEnglishName" class="form-label">재료 영어 이름</label>
                        <input type="text" class="form-control" id="ingredientEnglishName" name="ingre_name_eng" placeholder="재료 영어 이름 입력" required>
                    </div>

                    <div class="mb-3">
                        <label for="ingredientImageUrl" class="form-label">재료 이미지 주소</label>
                        <input type="text" class="form-control" id="ingredientImageUrl" name="ingre_img_url" placeholder="재료 이미지 주소 입력" required>
                    </div>

                    <div class="mb-3">
                        <label for="ingredientDescription" class="form-label">재료 설명</label>
                        <input type="text" class="form-control" id="ingredientDescription" name="ingre_detail" placeholder="재료 설명 입력" required>
                    </div>

                    <div class="mb-3">
                        <label for="ingredientCategory" class="form-label">재료 카테고리</label>
                        <select class="form-select" id="ingredientCategory" name="ing_categ">
                            <option value="강한도수">강한도수</option>
                            <option value="약한도수">약한도수</option>
                            <option value="음료수">음료수</option>
                            <option value="주스">주스</option>
                            <option value="과일">과일</option>
                            <option value="기타">기타</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="ingredientAlcoholPercentage" class="form-label">도수</label>
                        <input type="text" class="form-control" id="ingredientAlcoholPercentage" name="ingre_abv" placeholder="도수 입력">
                    </div>

                </form>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" id="ing_saveBtn">저장하기</button>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div>
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col" class="col-sm-2">이름</th>
                        <th scope="col">영어 이름</th>
                        <th scope="col">이미지</th>
                        <th scope="col">상세</th>
                        <th scope="col" class="col-sm-1">카테고리</th>
                        <th scope="col" class="col-sm-1">도수</th>
                        <th scope="col" class="col-sm-1">관리</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="ing" items="${ingre}">
                        <tr>
                            <th scope="row">${ing.ing_num}</th>
                            <td>${ing.ing_name}</td>
                            <td>${ing.ing_name_eng}</td>
                            <td><img src="${ing.ing_photo}" alt="이미지" width="50px" height="50px"></td>
                            <td>${ing.ing_detail}</td>
                            <td>${ing.ing_categ}</td>
                            <td>${ing.abv}</td>
                            <td>
                                <button type="button" class="btn btn-primary edit_btn" href="/admin/ingredient/update?ing_num=${ing.ing_num}">수정</button>
                                <button type="button" class="btn btn-warning del_btn" href="/admin/ingredient/delete?ing_num=${ing.ing_num}">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <%--재료 수정 모달--%>
        <div class="modal">

        </div>

    <%-- 재료 삭제 모달 --%>

</main>

<%--저장 관련 스크립트--%>
<script>

    const form = document.querySelector('form');

    const ingredientName = document.querySelector('#ingredientName');
    const ingredientEnglishName = document.querySelector('#ingredientEnglishName');
    const ingredientImageUrl = document.querySelector('#ingredientImageUrl');
    const ingredientDescription = document.querySelector('#ingredientDescription');
    const ingredientCategory = document.querySelector('#ingredientCategory');
    const ingredientAlcoholPercentage = document.querySelector('#ingredientAlcoholPercentage');

    const saveBtn = document.querySelector('#ing_saveBtn');

    form.addEventListener('submit', (e) => {
        e.preventDefault();
    });

    // ...

    saveBtn.addEventListener('click', () => {
        var ing_name = ingredientName.value;
        var ing_name_eng = ingredientEnglishName.value;
        var ing_photo = ingredientImageUrl.value;
        var ing_detail = ingredientDescription.value;
        var ing_categ = ingredientCategory.value;
        var abv = parseFloat(ingredientAlcoholPercentage.value);

        if (ingre.ing_name === '') {
            alert('재료 이름을 입력해주세요');
            ingredientName.focus();
            return;
        } else if (ingre.ing_name_eng === '') {
            alert('재료 영어 이름을 입력해주세요');
            ingredientEnglishName.focus();
            return;
        } else if (ingre.ing_photo === '') {
            alert('재료 이미지 주소를 입력해주세요');
            ingredientImageUrl.focus();
            return;
        } else if (ingre.ing_detail === '') {
            alert('재료 설명을 입력해주세요');
            ingredientDescription.focus();
            return;
        } else if (ingre.ing_categ === '') {
            alert('재료 카테고리를 입력해주세요');
            ingredientCategory.focus();
            return;
        }

        console.log( typeof(ingre) + ingre);

        // form.submit();

        $.ajax({
            url : "/admin/ingreadd",
            type : "GET",
            //data : JSON.stringify(ingre),
            contentType : "application/json; charset=utf-8",
            dataType : "json",
            data : {
                ing_name : ing_name,
                ing_name_eng : ing_name_eng,
                ing_photo : ing_photo,
                ing_detail : ing_detail,
                ing_categ : ing_categ,
                abv : abv
            },
            success : function(data) {
                console.log(data);
                alert("재료가 추가되었습니다.");
                location.reload();
            },

            error : function(error) {

                console.log(error);
                alert("재료 추가에 실패하였습니다.");
            }
        })


    });
</script>

<script>
    // 수정, 삭제
    const editBtn = document.querySelectorAll('.edit_btn');
    const delBtn = document.querySelectorAll('.del_btn');

    editBtn.forEach((btn) => {
        btn.addEventListener('click', (e) => {
            const ing_num = e.target.getAttribute('href').substr(33);
            console.log(ing_num);

            window.open ("/admin/ingreedit?ing_num=" + ing_num, "재료 수정", "width=500, height=500, left=100, top=50");

        });
    });




</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>