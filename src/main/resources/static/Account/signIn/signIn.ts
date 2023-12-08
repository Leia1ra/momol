/* INPUTS *////////////////////////
let errCnt = 0;
let errMsg : HTMLDivElement;
// @ts-ignore
let id : HTMLInputElement;
let pw : HTMLInputElement;
let pwRe : HTMLInputElement;
let meter : HTMLProgressElement;
let nick : HTMLInputElement;
// @ts-ignore
let userName : HTMLInputElement;
// @ts-ignore
let email : HTMLInputElement;
let telDiv : HTMLDivElement;
let Phone : HTMLInputElement;
let telNums0 : HTMLSelectElement;
let telNums1 : HTMLInputElement;
let telNums2 : HTMLInputElement;
let gender : HTMLSelectElement;
let birth : HTMLInputElement;
let signIn : HTMLFormElement;
/*결과 저장 변수*////////////////////
let idPassable:boolean;
let passable:boolean;
let nickPassable:boolean;
let namePassable:boolean;
let emailPassable:boolean;
/*유효성검사*////////////////////////
let idReg = /^[a-zA-Z]{1}[a-zA-Z0-9_]{4,12}$/;
let nickReg = /^[a-zA-Z가-힣0-9]{4,15}$/;
let nameReg = /^[가-힣]{2,7}$/;
let emailReg = /^\w{4,14}[@][a-z]{3,10}[.][a-z]{2,3}([.][a-z]{2,3})?$/;
///////////////////////////////////
enum ErrType {
    unfilled = '미입력된 양식이 존재합니다.',
    pwCheck = '입력된 비밀번호와 확인번호가 일치하지 않습니다.',
    pwStrength = '6-15자리, 특수문자, 대소문자, 숫자를 최소 2가지를 조합하여 비밀번호를 입력하세요',
    capsLock = 'CapsLock이 켜져있습니다.',
    numCheck = '숫자만 입력해 주세요'
}
enum Condition {
    Default='1px solid #ddd',
    Err = '2px solid red',
    Focus = '2px solid #1ebee6'
}

/* CapsLock검사 */
document.addEventListener('keydown', function (event) {
    if (event.getModifierState('CapsLock')) {
        errMsg.innerHTML = ErrType.capsLock;
        errMsg.style.display = "block";
    } else {
        errMsg.innerHTML = "";
    }
});
/*일반적인 체크*/
function validationCheck(element:HTMLInputElement, reg:RegExp, errMsgbox?:HTMLDivElement, errMsg?:string) {
    let result:boolean;
    element.addEventListener("focusout", function () {
        if(!reg.test(this.value)){
            this.style.border = Condition.Err;
            errMsgbox.innerHTML = `올바른 ${errMsg} 양식이 아닙니다.`;
            result = false;
        } else {
            this.style.border = Condition.Default;
            errMsgbox.innerHTML = '';
            result = true;
        }
        /*진심 최후의 최후의 최후의 수단*/
        if(element.id==="id"){
            idPassable = result;
        } else if(element.id === "name"){
            namePassable = result;
        } else if(element.id === "email"){
            emailPassable = result;
        } else if(element.id === "nick") {
            nickPassable = result;
        }
    })
    element.addEventListener("focusin", function () {
        this.style.border = Condition.Focus;
    })
    // return result;
}

/*비밀번호 강도 + 유효성 검사*/
function StrengthCheck(pwValue:string, meter:HTMLProgressElement):boolean {
    let strength = 0;
    const pwReg:RegExp[] = [/* + 는 하나 이상 포함*/
        /[a-z]+/,
        /[A-Z]+/,
        /[0-9]+/,
        /[$@#&!]+/
    ];
    pwReg.forEach((value:RegExp, idx:number) => {
        // strength += value.test(pw.value) ? 1 : 0
        if (pwValue.length == 0){
            strength = 0;
        } else if(pwValue.length < 6){
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

    /*if(strength >= 2 ) { return true; }
    else { return false; }*/
    return strength >= 2
}
function pwCheck(pw:HTMLInputElement, meter:HTMLProgressElement, errMsg:HTMLDivElement){
    // let passable:boolean;
    pw.addEventListener('focusout', function () {
        passable = StrengthCheck(pw.value, meter);
        if(!passable){
            pw.style.border = '2px solid red';
        }
        else {
            pw.style.border = '1px solid #ddd';
        }
    })
    pw.addEventListener('keyup', function () {
        passable = StrengthCheck(pw.value, meter);
        if(passable){
            pw.style.border = '2px solid #1ebee6';
        } else {
            pw.style.border = '2px solid red';
        }
    })
    pw.addEventListener('focusin', function () {
        passable = StrengthCheck(pw.value, meter);
        if(passable) {
            errMsg.innerHTML = "";
            pw.style.border = '2px solid #1ebee6';
        } else {
            errMsg.innerHTML = ErrType.pwStrength;
            pw.style.border = '2px solid red';
        }
    })
    // return passable;
}
/*전화번호 체크*/
function telCheck(element:HTMLInputElement, telBox:HTMLDivElement) {
    let isNum = /^\d+$/;
    element.addEventListener('keydown', function (event) {
        if((!isNum.test(event.key) && event.key !== 'Backspace') || (element.value.length > 3 && event.key !== 'Backspace')){
            telBox.style.border = Condition.Err;
            event.preventDefault();
        } else {
            telBox.style.border = Condition.Focus;
        }
    })
    element.addEventListener("focusout", function () {
        telBox.style.border = Condition.Default;
    })
}

document.addEventListener('DOMContentLoaded', function () {
    errCnt = 0;
    errMsg = document.getElementById('err') as HTMLDivElement;
    /*inputs*/
    id = document.getElementById('id') as HTMLInputElement;
    pw = document.getElementById('pw') as HTMLInputElement;
    pwRe = document.getElementById('pwRe') as HTMLInputElement;
    meter = document.getElementById('meter') as HTMLProgressElement;
    nick = document.getElementById('nick') as HTMLInputElement;
    userName = document.getElementById('name') as HTMLInputElement;
    email = document.getElementById('email') as HTMLInputElement;
    telDiv = document.getElementById('tel-container') as HTMLDivElement;
    Phone = document.getElementById('tel') as HTMLInputElement;
    telNums0 = document.getElementsByClassName('tel-nums')[0] as HTMLSelectElement;
    telNums1 = document.getElementsByClassName('tel-nums')[1] as HTMLInputElement;
    telNums2 = document.getElementsByClassName('tel-nums')[2] as HTMLInputElement;
    gender = document.getElementById('gender') as HTMLSelectElement;
    birth = document.getElementById('birth') as HTMLInputElement;
    signIn = document.getElementById("signIn") as HTMLFormElement;

})/*이벤트 로드 INPUTS 초기화*/
document.addEventListener('DOMContentLoaded', function () {
    validationCheck(id, idReg, errMsg,"아이디"); /*아이디 유효성 검사*/
    validationCheck(nick, nickReg, errMsg, "닉네임") /*아이디 유효성 검사*/
    validationCheck(userName, nameReg, errMsg, "이름");/*이름 유효성 검사*/
    validationCheck(email, emailReg, errMsg, "이메일");/*이메일 유효성 검사*/
    pwCheck(pw,meter, errMsg);/*비밀번호 유효성 검사*/
    telCheck(telNums1, telDiv);/*전화 번호 입력 제한 + 유효성 검사*/
    telCheck(telNums2, telDiv);

    /* 사업자 */
    let business = document.getElementById('business') as HTMLInputElement;
    let certify = document.getElementById('bc') as HTMLInputElement
    business.addEventListener('change', function () {
        let inputBox = document.getElementById('business-input') as HTMLDivElement;
        if(business.checked == true){
            inputBox.style.display = "block";
            certify.disabled = false;
        } else if(business.checked == false){
            inputBox.style.display = "none";
            certify.disabled = true;
        }
    })

    /* 서버접속전 점검 */
    signIn.addEventListener('submit', function (event) {
        if(!idPassable){
            id.style.border = Condition.Err;
            ++errCnt
        }

        /*PW*/
        if (!passable){
            pw.style.border = Condition.Err;
            errMsg.innerHTML = ErrType.pwStrength;
            ++errCnt
        } else if(pw.value !== pwRe.value){
            pw.value = "";
            pwRe.value = "";
            pwRe.style.border = Condition.Err;
            errMsg.innerHTML = ErrType.pwCheck;
            ++errCnt
        }

        /*Name*/
        if(!nickPassable) {
            nick.style.border = Condition.Err;
            ++errCnt;
        }

        /*Name*/
        if(!namePassable) {
            userName.style.border = Condition.Err;
            ++errCnt;
        }

        /*Email*/
        if(!emailPassable){
            email.style.border = Condition.Err;
            ++errCnt;
        }

        /*Tel*/
        Phone.value = `${telNums0.value}-${telNums1.value}-${telNums2.value}`;
        if(telNums0.value === "" || telNums1.value === "" || telNums2.value === ""){
            document.getElementById('tel-container').style.border = Condition.Err;
            ++errCnt;
        }

        /*Personal*/
        if(birth.value == null || birth.value == ""){
            birth.style.border = Condition.Err;
            ++errCnt;
        }

        if(errCnt === 0){
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

            fetch(
                "/account/accountCheck",{
                    method:'POST',
                    headers: {

                    },
                    body:data
                }
            ).then((res)=>{
                return res.json()
            }).then((data)=>{
                let exist:string[] = new Array<string>();
                if(data.Id){ // 아이디 칸에 빨간 태두리
                    id.style.border = Condition.Err
                    exist.push('아이디');
                }
                if(data.Nick){
                    nick.style.border = Condition.Err;
                    exist.push('닉네임')
                }
                if(data.Phone){ // 전화번호 칸에 빨간 태두리
                    telDiv.style.border = Condition.Err;
                    exist.push('전화번호');
                }
                if(data.email){ // 이메일 칸에 빨간 태두리
                    email.style.border = Condition.Err;
                    exist.push('이메일');
                }
                console.log(exist.length);
                if(exist.length != 0){
                    errMsg.innerHTML = `${exist.toString()}이(가) 이미 사용중입니다.`;
                } else {
                    HTMLFormElement.prototype.submit.call(signIn); // signIn.submit();
                }
            }).catch((err)=>{
                console.log(err)
            })

        } else {
            console.log(errCnt);
            errCnt = 0;
            event.preventDefault();
        }
    });
})