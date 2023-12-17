const headerText = document.querySelector("#ect_header__2 > a");
headerText.style.color = "#4299e1";

const headerGnb = document.querySelector("#ect_header__2 > div");
headerGnb.style.display = "block";

const headerGnb_inner = document.querySelector("#ect_header__2 > div.ect_header__ul__deep1 > ul");
headerGnb_inner.style.display = "flex";

let header_area = document.querySelector("#ect_header__nav");
header_area.addEventListener('mouseover', function () {
    gnb_mouseout();
});

header_area.addEventListener('mouseout', function () {
    // 코드 작성
    $('#ect_header__nav > ul > li:nth-child(1) > div').show();
    $('#ect_header__1 > div.ect_header__ul__deep1 > ul').show();

});