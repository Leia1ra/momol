let state;
// @ts-ignore
let id;
// @ts-ignore
let email;
// @ts-ignore
let userName;
let search;
let searchId;
let searchPw;
function stateFn(value) {
    state.innerHTML = `${value} 찾기`;
    if (value == 'ID') {
        searchId.setAttribute("checked", "true");
        userName.disabled = false;
        userName.style.display = 'block';
        id.disabled = true;
        id.style.display = 'none';
        userName.value = "";
        id.value = "";
        email.value = "";
    }
    else if (value == 'PW') {
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
    state = document.getElementById("state");
    userName = document.getElementById('name');
    id = document.getElementById('id');
    email = document.getElementById('email');
    search = document.getElementsByName('search');
    searchId = document.getElementById('searchId');
    searchPw = document.getElementById('searchPw');
    search.forEach(function (tag, key) {
        tag.addEventListener('change', function () {
            if (tag.value == 'ID') {
                stateFn(tag.value);
            }
            else if (tag.value == 'PW') {
                stateFn(tag.value);
            }
        });
    });
    let searchFrm = document.getElementById("searchFrm");
    searchFrm.addEventListener('submit', function (event) {
        const color = 'red';
        let type;
        const data = new FormData();
        search.forEach(function (result) {
            if (result.checked) {
                console.log(result.value);
                type = result.value;
                data.append("type", result.value);
                if (result.value == "ID") {
                    data.append(userName.name, userName.value);
                    data.append(email.name, email.value);
                }
                else if (result.value == "PW") {
                    data.append(id.name, id.value);
                    data.append(email.name, email.value);
                }
            }
        });
        if (type == 'ID' && (userName.value == null || userName.value == "")) {
            userName.style.border = `2px solid ${color}`;
            ++errCnt;
        }
        if (type == 'PW' && (id.value == null || id.value == "")) {
            id.style.border = `2px solid ${color}`;
            ++errCnt;
        }
        if (email.value == null || email.value == "") {
            email.style.border = `2px solid ${color}`;
            ++errCnt;
        }
        if (errCnt === 0) {
            event.preventDefault();
            fetch('/account/findCheck', {
                method: 'POST',
                headers: {},
                body: data
            }).then(function (res) {
                return res.text();
            }).then(function (data) {
                document.getElementById("err").innerHTML = data;
                if (type === 'PW') {
                }
            }).catch((errType) => {
                console.log(errType);
            });
        }
        else {
            event.preventDefault();
        }
    });
});
