let index = 0;

class Menu{
    constructor(menuSize, bizno) {
        this.size = menuSize;
        this.incress = 0;
        this.bizno = bizno;
    }

    expandMenu() { // business-li 요소를 하나 늘린다.
        var newMenu = document.createElement('div');
        newMenu.className = 'business-form-container';
        newMenu.id = "menu_"+this.incress;
        newMenu.innerHTML = `
            <form method="post" class="business-form" action="#" enctype="multipart/form-data">
                <input type="hidden" name="bizno" value="${this.bizno}">
                <label class="menuImg">
                    <img class="menu" src="" onerror="this.src='/resources/main/menuNone.png'"/>
                    <input type="file" class="menu_imgFile" name="menu_imgFile" hidden
                           onchange="menuImgUpLoad(${this.size + this.incress})" accept="image/jpeg, image/png">
                    <div class="menuImgMessage">
                        <div>
                        사진을 변경하려면 클릭하세요
                        </div>
                    </div>
                </label>
                <div class="menuInfo">
                    <input type="text" class="menuSubject" name="subject" placeholder="subject" required>
                    <input type="text" class="menuContent" name="content" placeholder="content" required>
                    <div class="menuInfoUpdate">
                        <input type='button' class="menuInsertBtn" value='메뉴 추가' onclick="menu.menuAsyncUpload(${this.size + this.incress})">
                    </div>
                </div>
            </form>
        `;

        document.getElementById('business-ul').appendChild(newMenu);
        // this.size++;
        this.incress++;
    }

    menuAsyncUpload(index) {
        let form = document.getElementsByClassName("business-form")[index];
        let parentNode = document.getElementById(form.parentNode.id);
        const formData = new FormData(form);
        let beforeSubject = formData.get("subject");
        console.log(beforeSubject);
        $.ajax({
            type:'POST',
            url:'/mmypage/menuInsertOk',
            data:formData,
            contentType:false,
            processData:false,
            success:function (result) {
                if(result){
                    document.getElementsByClassName("menu_imgFile")[index].value = "";
                    let menuInfo = document.getElementsByClassName("menuInfoUpdate")[index];
                    menuInfo.innerHTML = `
                        <input type="button" class="menuUpdateBtn" value="메뉴 업데이트" onclick="menu.menuUpdate('${beforeSubject}',${index})">
                        <input type="button" class="menuDeleteBtn" value="메뉴 삭제" onclick="menu.menuDelete(${index})">
                    `;
                    let onDataBase = document.getElementById('business-ul')
                    let container = document.getElementsByClassName("business-form-container");
                    if(container){
                        onDataBase.insertBefore(form, container[0]);
                        onDataBase.removeChild(parentNode);
                    } else{
                        onDataBase.appendChild(form);
                    }
                }
            }, error:function (err) {
                console.log(err)
            }
        });
    }

    menuUpdate(beforeSubject, index) {
        let form = document.getElementsByClassName("business-form")[index];
        let formData = new FormData(form);
        formData.set("bizno", this.bizno);
        formData.set("beforeSubject", beforeSubject);
        for(let key of formData.keys()){
            console.log(key, ", ", formData.get(key));
        }
        console.log(formData.get("subject"));

        $.ajax({
            url: "/mmypage/menuUpdate", // 서버의 DELETE 요청을 처리하는 엔드포인트
            type:"POST",
            data:formData,
            contentType:false,
            processData:false,
            success: function (result) {
                if(result){
                    document.getElementsByClassName("menu_imgFile")[index].value = "";
                    let menuInfo = document.getElementsByClassName("menuInfoUpdate")[index];
                    menuInfo.innerHTML = `
                        <input type="button" class="menuUpdateBtn" value="메뉴 업데이트" onclick="menu.menuUpdate('${formData.get("subject")}',${index})">
                        <input type="button" class="menuDeleteBtn" value="메뉴 삭제" onclick="menu.menuDelete(${index})">
                    `;
                }
            },error: function (error) {
                console.error(error);
            }
        });
    }

    menuDelete(index) {
        let form = document.getElementsByClassName("business-form")[index];
        let formData = new FormData(form);
        formData.set("bizno", this.bizno);
        for(let key of formData.keys()){
            console.log(key, ", ", formData.get(key));
        }

        $.ajax({
            url: "/mmypage/menuDeleteOk", // 서버의 DELETE 요청을 처리하는 엔드포인트
            type:"POST",
            data:formData,
            contentType:false,
            processData:false,
            success: function (result) {
                if(result){
                    form.remove();
                }
            },error: function (error) {
                console.error(error);
            }
        });
    }
}







document.addEventListener('DOMContentLoaded', function () {
    let index = 0;
    // expand-button1 클릭 시
    /*document.getElementById('expand-button1').addEventListener('click', function () {

    });*/

    // expand-button2 클릭 시
    document.getElementById('expand-button2').addEventListener('click', function () {
        // business-li 요소의 개수를 가져온다.
        var liCount = document.getElementsByClassName('business-form').length;

        // business-li가 한개 이상이면 마지막 요소를 삭제한다.
        if (liCount > 0) {
            var lastLi = document.getElementsByClassName('business-form')[liCount - 1];
            lastLi.parentNode.removeChild(lastLi);
        }
        index--;
        // jQuery를 사용한 AJAX 요청
    });
});


 
function menuImgUpLoad(index) {
    let imgUpload = document.getElementsByClassName("menu_imgFile")[index];
    let imgPreview = document.getElementsByClassName("menu")[index];

    let file = imgUpload.files[0];
    if(file){
        let reader = new FileReader();
        reader.onload = function (e){
            imgPreview.src = e.target.result;
        };
        reader.readAsDataURL(file);
    } else {
        imgPreview.src="";
    }
}