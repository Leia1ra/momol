
let state:HTMLHeadingElement;
// @ts-ignore
let id:HTMLInputElement;
// @ts-ignore
let email:HTMLInputElement;
// @ts-ignore
let userName:HTMLInputElement;
let search:NodeListOf<HTMLInputElement>;
let searchId:HTMLElement;
let searchPw:HTMLElement;

function stateFn(value:string) {
    state.innerHTML = `${value} 찾기`;
    if(value == 'ID'){
        searchId.setAttribute("checked", "true");
        userName.disabled = false;
        userName.style.display = 'block';
        id.disabled = true;
        id.style.display = 'none';

        userName.value = "";
        id.value = "";
        email.value = "";


    } else if(value == 'PW'){
        searchPw.setAttribute("checked", "true");
        userName.disabled = true;
        userName.style.display = 'none';
        id.disabled = false;
        id.style.display = 'block';

        userName.value = "";
        id.value = "";
        email.value = "";
    }
}
// document.getElementById('searchPw').setAttribute("checked", "true");

document.addEventListener('DOMContentLoaded', function () {
    let errCnt = 0;
    state = document.getElementById("state") as HTMLHeadingElement;

    userName = document.getElementById('name') as HTMLInputElement;
    id = document.getElementById('id') as HTMLInputElement;
    email = document.getElementById('email') as HTMLInputElement;

    search = document.getElementsByName('search') as NodeListOf<HTMLInputElement>;
    searchId = document.getElementById('searchId') as HTMLInputElement;
    searchPw = document.getElementById('searchPw') as HTMLInputElement;

    search.forEach(function (tag, key) {
        tag.addEventListener('change', function () {
            if(tag.value == 'ID'){
                stateFn(tag.value);
            } else if(tag.value == 'PW'){
                stateFn(tag.value);
            }
        })
    })
    
    let searchFrm = document.getElementById("searchFrm") as HTMLFormElement;
    searchFrm.addEventListener('submit',function (event){
        const color:string = 'red';
        let type:string;
        const data = new FormData();
        search.forEach(function (result) {
            if(result.checked){
                console.log(result.value);
                type=result.value;
                data.append("type", result.value)
                if(result.value == "ID"){
                    data.append(userName.name, userName.value);
                    data.append(email.name, email.value);
                } else if(result.value == "PW"){
                    data.append(id.name, id.value);
                    data.append(email.name, email.value);
                }
            }
        })
        if(type=='ID' && (userName.value == null || userName.value == "")){
            userName.style.border = `2px solid ${color}`;
            ++errCnt;
        }
        if(type=='PW' && (id.value == null || id.value == "")){
            id.style.border = `2px solid ${color}`;
            ++errCnt;
        }
        if(email.value == null || email.value == ""){
            email.style.border = `2px solid ${color}`;
            ++errCnt;
        }

        if(errCnt === 0){
            event.preventDefault();
            fetch('/account/findCheck',{
                method:'POST',
                headers: {

                },
                body:data
            }).then(function (res:Response) {
                return res.text();
            }).then(function (data) {
                document.getElementById("err").innerHTML = data;
                if(type === 'PW'){
                    
                }
            }).catch((errType)=>{
                console.log(errType);
            })
        } else {
            event.preventDefault();
        }
    });
})