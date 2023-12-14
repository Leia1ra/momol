document.addEventListener('DOMContentLoaded', function () {

})
function loginSubmit(locked?:boolean) {
    const color:string = 'red';
    let id= document.getElementById("id") as HTMLInputElement;
    let pw = document.getElementById("pw") as HTMLInputElement;
    let errCnt = 0;

    if(id.value == null || id.value == ""){
        let style = id.style;
        style.border = `2px solid ${color}`;
        ++errCnt;
    }
    if(pw.value == null || pw.value == ""){
        let style = pw.style;
        style.border = `2px solid ${color}`;
        ++errCnt;
    }

    if(errCnt === 0){
        // 추후 검증 절차 추가
        let login = document.getElementById('login') as HTMLFormElement;
        let userIn = document.getElementById('userIn') as HTMLInputElement;
        let data = new FormData();
        data.append("userIn", userIn.value)
        if(locked){
            fetch('/account/captchaImageCheck',{
                method:'POST',
                headers:{

                },
                body:data
            }).then((result) => {
                return result.json();
            }).then((data) => {
                console.log(data.result);
                if(data.result){
                    HTMLFormElement.prototype.submit.call(login);
                } else {
                    return false;
                }
            }).catch((err) => {
                console.log(err);
            })
        } else {
            HTMLFormElement.prototype.submit.call(login);
        }
        return false
    } else {
        // event.preventDefault();
        return false
    }
}

function capthaImageChage(locked?:boolean){
    let capt = document.getElementById("captcha")
    if(locked){
        capt.style.display = "flex";
        // 비동기식으로 서버에서 captha이미지를 가져와 img태그의 src속성의 값을 변환한다.
        let xhr = new XMLHttpRequest();

        xhr.responseType = "blob"; //응답받는 정보의 타입

        xhr.onload = function(){
            //서버에서 받아온 이미지를 img 태그에 셋팅
            var imgUrl = URL.createObjectURL(this.response);
            let captchImg = document.getElementById("imageCaptcha") as HTMLImageElement;
            captchImg.src = imgUrl;
        }
        //               url
        xhr.open("post", "/account/captchaImage");
        xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        xhr.send();
    }
}

