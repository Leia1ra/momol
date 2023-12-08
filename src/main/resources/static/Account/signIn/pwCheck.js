/*
/!*비밀번호 강도 + 유효성 검사*!/
/!* 비밀번호 강도 검사 *!/
function StrengthCheck(pwValue:string, meter:HTMLProgressElement):boolean {
    let strength = 0;
    const pwReg:RegExp[] = [/!* + 는 하나 이상 포함*!/
        /[a-z]+/,
        /[A-Z]+/,
        /[0-9]+/,
        /[$@#&!]+/
    ];
    pwReg.forEach((value:RegExp, idx:number) => {
        // strength += value.test(pw.value) ? 1 : 0
        if(pwValue.length < 6){
            meter.style.setProperty("--progress", "red");
            strength = 1;
            // meter.style.backgroundColor = 'red';
        } else if(pwValue.length > 15) {
            meter.style.setProperty("--progress", "red");
            strength = 1;
            // meter.style.backgroundColor = 'red';
        } else {
            meter.style.backgroundColor = 'white';
            strength += value.test(pwValue) ? 1 : 0
        }
    })
    meter.value = strength;
    switch (strength) {
        case 1 :
            meter.style.setProperty("--progress", "red");
            break
        case 2:
        case 3:
            meter.style.setProperty("--progress", "orange");
            break
        case 4:
            meter.style.setProperty("--progress", "green");
            break
    }

    /!*if(strength >= 2 ) { return true; }
    else { return false; }*!/
    return strength >= 2
}

function pwCheck(pw:HTMLInputElement, meter:HTMLProgressElement, errMsg:HTMLDivElement):boolean {
    let passable:boolean;
    pw.addEventListener('focusin', function () {
        passable = StrengthCheck(pw.value, meter);
        if(passable) {
            errMsg.innerHTML = "";
            errMsg.style.display = 'none';
            pw.style.border = '2px solid #1ebee6';
        }
        else {
            errMsg.innerHTML = '6-15자리, 특수문자, 대소문자, 숫자를 최소 2가지를 조합하여 비밀번호를 입력하세요';
            errMsg.style.display = 'block';
            pw.style.border = '2px solid red';
        }

        pw.addEventListener('keyup', function () {
            passable = StrengthCheck(pw.value, meter);
            console.log(passable);
            if(passable){
                pw.style.border = '2px solid #1ebee6';
            } else {
                pw.style.border = '2px solid red';
            }
        })
    })

    pw.addEventListener('focusout', function () {
        passable = StrengthCheck(pw.value, meter);/!*불필요한 검사긴 함*!/
        if(!passable){
            pw.style.border = '2px solid red';
        }
        else {
            pw.style.border = '1px solid #ddd';
        }
    })
    return passable;
}*/
