/* INPUTS */ ///////////////////////
let errCnt = 0;
let errMsg;
// @ts-ignore
let id;
let pw;
let pwRe;
let meter;
let nick;
// @ts-ignore
let userName;
// @ts-ignore
let email;
let telDiv;
let Phone;
let telNums0;
let telNums1;
let telNums2;
let gender;
let birth;
let signIn;
/*결과 저장 변수*/ ///////////////////
let idPassable;
let passable;
let nickPassable;
let namePassable;
let emailPassable;
/*유효성검사*/ ///////////////////////
let idReg = /^[a-zA-Z]{1}[a-zA-Z0-9_]{4,12}$/;
let nickReg = /^[a-zA-Z가-힣0-9]{4,15}$/;
let nameReg = /^[가-힣]{2,7}$/;
let emailReg = /^\w{4,14}[@][a-z]{3,10}[.][a-z]{2,3}([.][a-z]{2,3})?$/;
///////////////////////////////////
var ErrType;
(function (ErrType) {
    ErrType["unfilled"] = "\uBBF8\uC785\uB825\uB41C \uC591\uC2DD\uC774 \uC874\uC7AC\uD569\uB2C8\uB2E4.";
    ErrType["pwCheck"] = "\uC785\uB825\uB41C \uBE44\uBC00\uBC88\uD638\uC640 \uD655\uC778\uBC88\uD638\uAC00 \uC77C\uCE58\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
    ErrType["pwStrength"] = "6-15\uC790\uB9AC, \uD2B9\uC218\uBB38\uC790, \uB300\uC18C\uBB38\uC790, \uC22B\uC790\uB97C \uCD5C\uC18C 2\uAC00\uC9C0\uB97C \uC870\uD569\uD558\uC5EC \uBE44\uBC00\uBC88\uD638\uB97C \uC785\uB825\uD558\uC138\uC694";
    ErrType["capsLock"] = "CapsLock\uC774 \uCF1C\uC838\uC788\uC2B5\uB2C8\uB2E4.";
    ErrType["numCheck"] = "\uC22B\uC790\uB9CC \uC785\uB825\uD574 \uC8FC\uC138\uC694";
})(ErrType || (ErrType = {}));
var Condition;
(function (Condition) {
    Condition["Default"] = "1px solid #ddd";
    Condition["Err"] = "2px solid red";
    Condition["Focus"] = "2px solid #1ebee6";
})(Condition || (Condition = {}));
/* CapsLock검사 */
document.addEventListener('keydown', function (event) {
    if (event.getModifierState('CapsLock')) {
        errMsg.innerHTML = ErrType.capsLock;
        errMsg.style.display = "block";
    }
    else {
        errMsg.innerHTML = "";
    }
});
/*일반적인 체크*/
function validationCheck(element, reg, errMsgbox, errMsg) {
    let result;
    element.addEventListener("focusout", function () {
        if (!reg.test(this.value)) {
            this.style.border = Condition.Err;
            errMsgbox.innerHTML = `올바른 ${errMsg} 양식이 아닙니다.`;
            result = false;
        }
        else {
            this.style.border = Condition.Default;
            errMsgbox.innerHTML = '';
            result = true;
        }
        /*진심 최후의 최후의 최후의 수단*/
        if (element.id === "id") {
            idPassable = result;
        }
        else if (element.id === "name") {
            namePassable = result;
        }
        else if (element.id === "email") {
            emailPassable = result;
        }
        else if (element.id === "nick") {
            nickPassable = result;
        }
    });
    element.addEventListener("focusin", function () {
        this.style.border = Condition.Focus;
    });
    // return result;
}
/*비밀번호 강도 + 유효성 검사*/
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
function pwCheck(pw, meter, errMsg) {
    // let passable:boolean;
    pw.addEventListener('focusout', function () {
        passable = StrengthCheck(pw.value, meter);
        if (!passable) {
            pw.style.border = '2px solid red';
        }
        else {
            pw.style.border = '1px solid #ddd';
        }
    });
    pw.addEventListener('keyup', function () {
        passable = StrengthCheck(pw.value, meter);
        if (passable) {
            pw.style.border = '2px solid #1ebee6';
        }
        else {
            pw.style.border = '2px solid red';
        }
    });
    pw.addEventListener('focusin', function () {
        passable = StrengthCheck(pw.value, meter);
        if (passable) {
            errMsg.innerHTML = "";
            pw.style.border = '2px solid #1ebee6';
        }
        else {
            errMsg.innerHTML = ErrType.pwStrength;
            pw.style.border = '2px solid red';
        }
    });
    // return passable;
}
/*전화번호 체크*/
function telCheck(element, telBox) {
    let isNum = /^\d+$/;
    element.addEventListener('keydown', function (event) {
        if ((!isNum.test(event.key) && event.key !== 'Backspace') || (element.value.length > 3 && event.key !== 'Backspace')) {
            telBox.style.border = Condition.Err;
            event.preventDefault();
        }
        else {
            telBox.style.border = Condition.Focus;
        }
    });
    element.addEventListener("focusout", function () {
        telBox.style.border = Condition.Default;
    });
}
document.addEventListener('DOMContentLoaded', function () {
    errCnt = 0;
    errMsg = document.getElementById('err');
    /*inputs*/
    id = document.getElementById('id');
    pw = document.getElementById('pw');
    pwRe = document.getElementById('pwRe');
    meter = document.getElementById('meter');
    nick = document.getElementById('nick');
    userName = document.getElementById('name');
    email = document.getElementById('email');
    telDiv = document.getElementById('tel-container');
    Phone = document.getElementById('tel');
    telNums0 = document.getElementsByClassName('tel-nums')[0];
    telNums1 = document.getElementsByClassName('tel-nums')[1];
    telNums2 = document.getElementsByClassName('tel-nums')[2];
    gender = document.getElementById('gender');
    birth = document.getElementById('birth');
    signIn = document.getElementById("signIn");
}); /*이벤트 로드 INPUTS 초기화*/
document.addEventListener('DOMContentLoaded', function () {
    validationCheck(id, idReg, errMsg, "아이디"); /*아이디 유효성 검사*/
    validationCheck(nick, nickReg, errMsg, "닉네임"); /*아이디 유효성 검사*/
    validationCheck(userName, nameReg, errMsg, "이름"); /*이름 유효성 검사*/
    validationCheck(email, emailReg, errMsg, "이메일"); /*이메일 유효성 검사*/
    pwCheck(pw, meter, errMsg); /*비밀번호 유효성 검사*/
    telCheck(telNums1, telDiv); /*전화 번호 입력 제한 + 유효성 검사*/
    telCheck(telNums2, telDiv);
    /* 사업자 */
    let business = document.getElementById('business');
    let certify = document.getElementById('bc');
    business.addEventListener('change', function () {
        let inputBox = document.getElementById('business-input');
        if (business.checked == true) {
            inputBox.style.display = "block";
            certify.disabled = false;
        }
        else if (business.checked == false) {
            inputBox.style.display = "none";
            certify.disabled = true;
        }
    });
    /* 서버접속전 점검 */
    signIn.addEventListener('submit', function (event) {
        if (!idPassable) {
            id.style.border = Condition.Err;
            ++errCnt;
        }
        /*PW*/
        if (!passable) {
            pw.style.border = Condition.Err;
            errMsg.innerHTML = ErrType.pwStrength;
            ++errCnt;
        }
        else if (pw.value !== pwRe.value) {
            pw.value = "";
            pwRe.value = "";
            pwRe.style.border = Condition.Err;
            errMsg.innerHTML = ErrType.pwCheck;
            ++errCnt;
        }
        /*Name*/
        if (!nickPassable) {
            nick.style.border = Condition.Err;
            ++errCnt;
        }
        /*Name*/
        if (!namePassable) {
            userName.style.border = Condition.Err;
            ++errCnt;
        }
        /*Email*/
        if (!emailPassable) {
            email.style.border = Condition.Err;
            ++errCnt;
        }
        /*Tel*/
        Phone.value = `${telNums0.value}-${telNums1.value}-${telNums2.value}`;
        if (telNums0.value === "" || telNums1.value === "" || telNums2.value === "") {
            document.getElementById('tel-container').style.border = Condition.Err;
            ++errCnt;
        }
        /*Personal*/
        if (birth.value == null || birth.value == "") {
            birth.style.border = Condition.Err;
            ++errCnt;
        }
        if (errCnt === 0) {
            /* DB 조회 로직 추가 */
            event.preventDefault();
            const data = new FormData();
            data.append(id.name, id.value);
            // data.append(pw.name, pw.value);
            data.append(nick.name, nick.value);
            // data.append(userName.name, userName.value);
            data.append(email.name, email.value);
            data.append(Phone.name, Phone.value);
            // data.append(gender.name, gender.value);
            // data.append(birth.name, birth.value);
            fetch("/account/accountCheck", {
                method: 'POST',
                headers: {},
                body: data
            }).then((res) => {
                return res.json();
            }).then((data) => {
                let exist = new Array();
                if (data.Id) { // 아이디 칸에 빨간 태두리
                    id.style.border = Condition.Err;
                    exist.push('아이디');
                }
                if (data.Nick) {
                    nick.style.border = Condition.Err;
                    exist.push('닉네임');
                }
                if (data.Phone) { // 전화번호 칸에 빨간 태두리
                    telDiv.style.border = Condition.Err;
                    exist.push('전화번호');
                }
                if (data.email) { // 이메일 칸에 빨간 태두리
                    email.style.border = Condition.Err;
                    exist.push('이메일');
                }
                console.log(exist.length);
                if (exist.length != 0) {
                    errMsg.innerHTML = `${exist.toString()}이(가) 이미 사용중입니다.`;
                }
                else {
                    HTMLFormElement.prototype.submit.call(signIn); // signIn.submit();
                }
            }).catch((err) => {
                console.log(err);
            });
        }
        else {
            console.log(errCnt);
            errCnt = 0;
            event.preventDefault();
        }
    });
});
