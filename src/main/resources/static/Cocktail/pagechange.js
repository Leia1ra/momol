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