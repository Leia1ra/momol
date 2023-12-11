<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<style>
    #ect_header, #footer {
        display: none;
    }
</style>

<main class="container">
    <h1 class="display-4">재료 수정하기</h1>

    <div class="mb-3">
        <label for="ing_num" class="form-label">재료 번호</label>
        <input type="text" value="${ingre.ing_num}" name="ing_num" id="ing_num" class="form-control bg-light" readonly>
    </div>

    <div class="mb-3">
        <label for="ing_name" class="form-label">재료 이름</label>
        <input type="text" value="${ingre.ing_name}" name="ing_name" id="ing_name" class="form-control bg-light" readonly>
    </div>

    <div class="mb-3">
        <label for="ing_name_eng" class="form-label">재료 영어 이름</label>
        <input type="text" value="${ingre.ing_name_eng}" name="ing_name_eng" id="ing_name_eng" class="form-control">
    </div>

    <div class="mb-3">
        <label for="ing_detail" class="form-label">재료 설명</label>
        <input type="text" value="${ingre.ing_detail}" name="ing_detail" id="ing_detail" class="form-control"
               style="height: 150px;  white-space: nowrap; overflow-x: scroll;">
    </div>

    <div class="mb-3">
        <label for="ing_categ" class="form-label">재료 카테고리</label>
        <select class="form-select" id="ing_categ" name="ing_categ">
            <option value="강한도수">강한도수</option>
            <option value="약한도수">약한도수</option>
            <option value="음료수">음료수</option>
            <option value="주스">주스</option>
            <option value="과일">과일</option>
            <option value="기타">기타</option>
        </select>
    </div>

    <div class="mb-3">
        <label for="abv" class="form-label">알콜 도수</label>
        <input type="text" value="${ingre.abv}" name="abv" id="abv" class="form-control">
    </div>

    <div class="mb-3">
        <label for="ing_img" class="form-label">재료 이미지</label>
        <p>미리보기</p>
        <img src="${ingre.ing_photo}" alt="이미지" class="img-fluid" style="max-width: 100px; height: auto;">
        <input type="text" value="${ingre.ing_photo}" name="ing_img" id="ing_img" class="form-control">
    </div>

    <button type="button" class=" btn btn-primary" value="수정" id="editBtn" > 수정 </button>
    <button type="button" class="btn btn-warning" value="취소" id="cancelBtn"> 취소 </button>

</main>

<script>

    const editBtn = document.querySelector('#editBtn');
    const cancelBtn = document.querySelector('#cancelBtn');

    editBtn.addEventListener('click', function () {
        const ing_num = document.querySelector('#ing_num').value;
        const ing_name = document.querySelector('#ing_name').value;
        const ing_name_eng = document.querySelector('#ing_name_eng').value;
        const ing_detail = document.querySelector('#ing_detail').value;
        const ing_categ = document.querySelector('#ing_categ').value;
        const abv = document.querySelector('#abv').value;
        const ing_img = document.querySelector('#ing_img').value;

        $.ajax({
            url : 'ingreadd_submit',
            type : 'get',
            data : {
                ing_num : ing_num,
                ing_name : ing_name,
                ing_name_eng : ing_name_eng,
                ing_detail : ing_detail,
                ing_categ : ing_categ,
                abv : abv,
                ing_img : ing_img
            },
            dataType : 'json',
            success : function (data) {
                console.log(data + "성공");
                alert("수정되었습니다.");
                window.close();
            },

            error : function (err) {
                console.log("수정 실패");
                window.close();
            }
        })
    });

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>