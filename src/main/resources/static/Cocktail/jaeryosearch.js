window.onload = function () {
    setDefaultActive();
    changeColor('labelOne');
    let type = document.getElementsByName("drinkType");

    type.forEach((value, key)=> {
        let arr = ['One','Two','Three','Four','Five'];
        value.addEventListener("",function () {
            if(value.checked === true){
                changeColor('label'+arr[key])
            }
        })
    });
};

function setDefaultActive() {
    //칵테일정보를 초기로 지정해놓고 글씩 커졌다 작아졌다 설정
    const defaultSection = document.querySelectorAll('.section')[1];
    defaultSection.classList.add('active');
}

function changeActive(element) {
    const sections = document.querySelectorAll('.section');
    sections.forEach(section => section.classList.remove('active'));

    // 클릭된 섹션에 active 클래스 추가
    element.classList.add('active');

    setTimeout(function () {
        const cocktailSection = document.querySelectorAll('.section')[1];
        cocktailSection.classList.add('active');
    }, 300); // 1000ms = 1초

    // 1초 후에 "재료 정보"의 active 클래스 제거
    setTimeout(function () {
        element.classList.remove('active');
    }, 300);
}

function changeColor(labelId) {
    var labels = document.querySelectorAll('.button');
    labels.forEach(function (label) {
        label.style.backgroundColor = ''; // 모든 라벨의 배경색 초기화
    });

    var selectedLabel = document.getElementById(labelId);
    selectedLabel.style.backgroundColor = 'lightgreen'; // 선택된 라벨의 배경색 변경
}

function searchCocktails2(searchText,context) {
    console.log(searchText);
    $.ajax({
        type: "GET",
        url: context + "/Cocktail/search2",
        data: { searchText: searchText },
        dataType: "json",
        success: function (data) {
            let container = document.getElementsByClassName('grid-container')[0];
            let inner = "";
            data.forEach(function (r) {
                inner += `
                        <div class="grid-item">
                            <a href="${context}/Cocktail/jaeryoinfo?ing_num=${r.ing_num}">
                                <img src="${r.ing_photo}" alt="게시물1 썸네일" class="thumbnail">
                                <div>${r.ing_name}</div>
                                <div>${r.ing_detail}</div>
                                </a>
                        </div>
                        `
            })
            container.innerHTML= inner;
        },
        error: function (error) {
            console.error("Error during search:", error);
        }
    });
}

function getCategoryData(context, category) {
    $.ajax({
        type: "GET",
        url: context + "/Cocktail/getCategoryData",
        data: { category: category },
        dataType: "json",
        success: function (data) {
            let container = document.getElementsByClassName('grid-container')[0];
            let inner = "";
            data.forEach(function (r) {
                inner += `
                    <div class="grid-item">
                        <a href="${context}/Cocktail/jaeryoinfo?ing_num=${r.ing_num}">
                            <img src="${r.ing_photo}" alt="게시물1 썸네일" class="thumbnail">
                            <div>${r.ing_name}</div>
                            <div>${r.ing_detail}</div>
                            </a>
                    </div>
                    `
            })
            container.innerHTML= inner;
        },
        error: function (error) {
            console.error("Error during category data retrieval:", error);
        }
    });
}

