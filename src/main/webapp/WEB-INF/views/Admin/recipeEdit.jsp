<%@ page language="java"  pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<style>
    #ect_header, #footer, header, footer, nav, aside {
        display: none;
    }
</style>

<main class="container">
    <h1 class="display-4">레시피 수정</h1>

    <%--이름name, 영어이름 name_eng, 도수 ABV, 설명 cocktail_detail, 레시피 recipe, 이미지 cocktail_img --%>
    <div class="mb-3">
        <label for="name" class="form-label">칵테일 이름</label>
        <input type="text" class="form-control" id="name" name="name" value="${cocktail.name}" readonly>
    </div>
    <div class="mb-3">
        <label for="name_eng" class="form-label">영어 이름</label>
        <input type="text" class="form-control" id="name_eng" name="name_eng" value="${cocktail.name_eng}">
    </div>
    <div class="mb-3">
        <label for="ABV" class="form-label">도수</label>
        <input type="text" class="form-control" id="ABV" name="ABV" value="${cocktail.ABV}">
    </div>
    <div class="mb-3">
        <label for="cocktail_detail" class="form-label">설명</label>
        <textarea class="form-control" id="cocktail_detail" name="cocktail_detail" rows="3">${cocktail.cocktail_detail}</textarea>
    </div>
    <div class="mb-3">
        <label for="recipe" class="form-label">레시피</label>
        <textarea class="form-control" id="recipe" name="recipe" rows="3">${cocktail.recipe}</textarea>
    </div>
    <div class="mb-3">
        <label for="cocktail_img" class="form-label">이미지</label>
        <img src="${cocktail.cocktail_img}" width="100px" height="auto" alt="이미지" >
        <input type="text" class="form-control" id="cocktail_img" name="cocktail_img" value="${cocktail.cocktail_img}">
    </div>

    <button class="btn btn-primary" id="recipeEditBtn">수정</button>
    <button class="btn btn-secondary" id="recipeEditCancelBtn">취소</button>

</main>

<script>

    //수정 버튼
    const recipeEditBtn = document.querySelector('#recipeEditBtn');

    recipeEditBtn.addEventListener('click', function() {
        const name = document.querySelector('#name').value;
        const name_eng = document.querySelector('#name_eng').value;
        const ABV = document.querySelector('#ABV').value;
        const cocktail_detail = document.querySelector('#cocktail_detail').value;
        const recipe = document.querySelector('#recipe').value;
        const cocktail_img = document.querySelector('#cocktail_img').value;

        const cocktail = {
            name_eng: name_eng,
            ABV: ABV,
            cocktail_detail: cocktail_detail,
            recipe: recipe,
            cocktail_img: cocktail_img
        }

        $.ajax({
            url : 'recipeEditSubmit',
            dataType : 'json',
            type : 'GET',
            contentType : 'application/json; charset=utf-8',
            data : {
                name : name,
                name_eng : name_eng,
                ABV : ABV,
                cocktail_detail : cocktail_detail,
                recipe : recipe,
                cocktail_img : cocktail_img
            },
            success : function(data) {
                console.log(data)
                alert('수정되었습니다');
                window.close();
            },
            error : function(error) {
                console.log(error)
                alert('수정에 실패하였습니다');

            }

        })

    })

</script>

<script>

    //취소 버튼
    const recipeEditCancelBtn = document.querySelector('#recipeEditCancelBtn');

    recipeEditCancelBtn.addEventListener('click', function() {
        window.close();
    })


</script>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>