const headerText2 = document.querySelector("#ect_header__2 > a");
headerText2.style.color = "#4299e1";

const headerGnb2 = document.querySelector("#ect_header__2 > div");
headerGnb2.style.display = "block";

const headerGnb_inner2 = document.querySelector("#ect_header__2 > div.ect_header__ul__deep1 > ul");
headerGnb_inner2.style.display = "flex";

let header_area = document.querySelector("#ect_header__nav");
header_area.addEventListener('mouseover', function () {
    gnb_mouseout();
});

header_area.addEventListener('mouseout', function () {
    // 코드 작성
    $('#ect_header__nav > ul > li:nth-child(4) > div').show();
    $('#ect_header__2 > div.ect_header__ul__deep1 > ul').show();

});