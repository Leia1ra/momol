window.onload = function () {
    setDefaultActive();
    changeColor('labelOne');
};

function setDefaultActive() {
    //칵테일정보를 초기로 지정해놓고 글씩 커졌다 작아졌다 설정
    const defaultSection = document.querySelectorAll('.section')[2];
    defaultSection.classList.add('active');
}

function changeActive(element) {
    const sections = document.querySelectorAll('.section');
    sections.forEach(section => section.classList.remove('active'));

    // 클릭된 섹션에 active 클래스 추가
    element.classList.add('active');

    setTimeout(function () {
        const cocktailSection = document.querySelectorAll('.section')[2];
        cocktailSection.classList.add('active');
    }, 300); // 1000ms = 1초

    // 1초 후에 "재료 정보"의 active 클래스 제거
    setTimeout(function () {
        element.classList.remove('active');
    }, 300);
}