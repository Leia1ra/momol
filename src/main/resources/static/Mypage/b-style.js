 document.addEventListener('DOMContentLoaded', function () {
    // expand-button1 클릭 시
    document.getElementById('expand-button1').addEventListener('click', function () {
        // business-li 요소를 하나 늘린다.
        var newLi = document.createElement('li');
        newLi.className = 'business-li';
        newLi.innerHTML = '<div class="business-h2-left"></div><div class="business-h2-right"></div>';
        document.getElementById('business-ul').appendChild(newLi);
    });

    // expand-button2 클릭 시
    document.getElementById('expand-button2').addEventListener('click', function () {
    // business-li 요소의 개수를 가져온다.
    var liCount = document.getElementsByClassName('business-li').length;

    // business-li가 세 개 이상이면 마지막 요소를 삭제한다.
    if (liCount > 3) {
    var lastLi = document.getElementsByClassName('business-li')[liCount - 1];
    lastLi.parentNode.removeChild(lastLi);
}

});
});