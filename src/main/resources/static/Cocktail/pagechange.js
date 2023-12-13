window.onload = function () {
    setDefaultActive();
};

function setDefaultActive() {
    const defaultSection = document.querySelector('.section');
    defaultSection.classList.add('active');
}

function changeActive(element) {
    const sections = document.querySelectorAll('.section');
    sections.forEach(section => section.classList.remove('active'));

    element.classList.add('active');

    // 1초 후에 "칵테일 정보"에 active 클래스 추가
    setTimeout(function () {
        const cocktailSection = document.querySelector('.section');
        cocktailSection.classList.add('active');
    }, 300); // 1000ms = 1초

    // 1초 후에 "재료 정보"의 active 클래스 제거
    setTimeout(function () {
        element.classList.remove('active');
    }, 300);
}


function searchCocktails(searchText,context) {
    console.log(searchText);
    $.ajax({
        type: "GET",
        url: context + "/Cocktail/search",
        data: { searchText: searchText },
        dataType: "json",
        success: function (data) {
            let container = document.getElementsByClassName('grid-container')[0];
            let inner = "";
            data.forEach(function (r) {
                inner += `
                 <div class="grid-item">
                    <a href="${context}/Cocktail/cakinfo?name=${r.name}">                  
                        <img src=${r.cocktail_img} alt="게시물1썸네일" class="thumbnail">
                        <div>${r.name}</div>
                        <div class="dz">${r.cocktail_detail}</div>
                    </a>
                    <div class="tags">
                        <div class="tag1"></div>
                        <div class="tag2"></div>
                        <div class="tag3"></div>
                    </div>
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



