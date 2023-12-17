/*비밀번호 강도 + 유효성 검사*!/
/* 비밀번호 강도 검사 */
let typeData;
let UID;
// @ts-ignore
let pw;
let newPw;
// @ts-ignore
let pwRe;
// @ts-ignore
let meter;
let err;
let submit;
let pass;
/* CapsLock검사 */
document.addEventListener('keydown', function (event) {
    if (event.getModifierState('CapsLock')) {
        err.innerHTML = 'CapsLock이 켜져있습니다.';
        err.style.display = "block";
    }
    else {
        err.innerHTML = "";
    }
});
function findPw(type, tmp) {
    if (type === "temporary") {
        pw.style.display = "none";
        pw.value = tmp;
    }
    else if (type === "logUser") {
        pw.style.display = "block";
    }
}
/*비밀번호 강도 + 유효성 검사*/
// @ts-ignore
function StrengthCheck(pwValue, meter) {
    let strength = 0;
    const pwReg = [
        /[a-z]+/,
        /[A-Z]+/,
        /[0-9]+/,
        /[$@#&!]+/
    ];
    pwReg.forEach((value, idx) => {
        // strength += value.test(pw.value) ? 1 : 0
        if (pwValue.length == 0) {
            strength = 0;
        }
        else if (pwValue.length < 6) {
            meter.style.setProperty("--progress", "red");
            strength = 1;
            // meter.style.backgroundColor = 'red';
        }
        else if (pwValue.length > 15) {
            meter.style.setProperty("--progress", "red");
            strength = 1;
            // meter.style.backgroundColor = 'red';
        }
        else {
            meter.style.backgroundColor = 'white';
            strength += value.test(pwValue) ? 1 : 0;
        }
    });
    meter.value = strength;
    switch (strength) {
        case 1:
            meter.style.setProperty("--progress", "red");
            break;
        case 2:
        case 3:
            meter.style.setProperty("--progress", "orange");
            break;
        case 4:
            meter.style.setProperty("--progress", "green");
            break;
    }
    /*if(strength >= 2 ) { return true; }
    else { return false; }*/
    return strength >= 2;
}
// @ts-ignore
function pwCheck(newPw, meter, errMsg) {
    // let passable:boolean;
    newPw.addEventListener('focusout', function () {
        pass = StrengthCheck(newPw.value, meter);
        if (!pass) {
            newPw.style.border = '2px solid red';
        }
        else {
            newPw.style.border = '1px solid #ddd';
        }
    });
    newPw.addEventListener('keyup', function () {
        pass = StrengthCheck(newPw.value, meter);
        if (pass) {
            newPw.style.border = '2px solid #1ebee6';
        }
        else {
            newPw.style.border = '2px solid red';
        }
    });
    newPw.addEventListener('focusin', function () {
        pass = StrengthCheck(newPw.value, meter);
        if (pass) {
            errMsg.innerHTML = "";
            newPw.style.border = '2px solid #1ebee6';
        }
        else {
            errMsg.innerHTML = '6-15자리, 특수문자, 대소문자, 숫자를 최소 2가지를 조합하여 비밀번호를 입력하세요';
            newPw.style.border = '2px solid red';
        }
    });
    // return passable;
}
document.addEventListener('DOMContentLoaded', () => {
    errCnt = 0;
    typeData = document.getElementById("type");
    UID = document.getElementById("UID");
    pw = document.getElementById("pw");
    newPw = document.getElementById("newPw");
    pwRe = document.getElementById("pwRe");
    meter = document.getElementById("meter");
    submit = document.getElementById("pwChange");
    err = document.getElementById("err");
    pwCheck(newPw, meter, err); /*비밀번호 유효성 검사*/
    submit.addEventListener("submit", function (event) {
        event.preventDefault();
        let sameCheck;
        if (newPw.value !== pwRe.value) {
            newPw.value = "";
            pwRe.value = "";
            pwRe.style.border = '2px solid red';
            err.innerHTML = '입력된 비밀번호와 확인번호가 일치하지 않습니다.';
            sameCheck = false;
        }
        else {
            sameCheck = true;
        }
        if (pass && sameCheck) {
            event.preventDefault();
            const data = new FormData();
            data.append(pw.name, pw.value);
            data.append(newPw.name, newPw.value);
            data.append(UID.name, UID.value);
            data.append(typeData.name, typeData.value);
            fetch('/account/pwChangeAsync', {
                method: 'POST',
                headers: {},
                body: data
            }).then((result) => {
                return result.json();
            }).then((data) => {
                console.log(data);
                if (data.result) {
                    HTMLFormElement.prototype.submit.call(submit);
                }
                else {
                    err.innerHTML = data.message;
                }
            }).catch((err) => {
                console.log(err);
            });
        }
        else {
            event.preventDefault();
        }
    });
});
