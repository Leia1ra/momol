document.addEventListener('DOMContentLoaded', function () {
    let login = document.getElementById("login");
    login.addEventListener('submit', function (event) {
        const color = 'red';
        let id = document.getElementById("id");
        let pw = document.getElementById("pw");
        let errCnt = 0;
        if (id.value == null || id.value == "") {
            let style = id.style;
            style.border = `2px solid ${color}`;
            ++errCnt;
        }
        if (pw.value == null || pw.value == "") {
            let style = pw.style;
            style.border = `2px solid ${color}`;
            ++errCnt;
        }
        if (errCnt === 0) {
            // 추후 검증 절차 추가
        }
        else {
            event.preventDefault();
        }
    });
});
