//카테고리 보여주는 JS

document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("#sel_zairyo");
    const selectedList = document.querySelector("#selectedList");
    const category = document.querySelector("#sel_category");
    const sel_bubble = document.querySelector("#sel_zairyo > label");

    category.addEventListener("change", combain_category_change);
    form.addEventListener("change", find_make_cocktail);
});

function combain_category_change() {
    //cheked 된 카테고리가 뭔지 출력
    const sel_category = document.querySelectorAll("#sel_category > .z_sel > input");
    for (let i = 0; i < sel_category.length; i++) {
        console.log(sel_category[i].checked);
        if (sel_category[i].checked === true) {
            //sel_category[i] 의 부모의 span 요소
            let sel_category_parent = sel_category[i].parentElement;
            let sel_category_parent_span = sel_category_parent.querySelector("span");
            let span = sel_category_parent_span.innerText;

            console.log(sel_category[i].parentElement);
            console.log("현재 분류" + span); //현재 분류 뭔지 출력

            // 전체, 강한도수, 약한도수, 음료수, 주스, 과일, 기타
            if (span === "전체" || span ==="강한도수" || span === "약한도수" || span === "음료수" || span === "기타" || span === "과일" || span === "주스") {
                $.ajax({
                    url: "/combain/category",
                    type: "GET",
                    dataType: "json" ,
                    data: {
                        category: span
                    },
                    success: function (data) {
                        console.log(data);
                        // 가져온 데이터를 하나씩 출력

                        try {

                            data.forEach(function (item) {
                                // console.log(item);
                                const labels = document.querySelectorAll("#sel_zairyo > label");

                                labels.forEach(function (label) {
                                    const span = label.querySelector("span");
                                    const spanText = span.innerText;

                                    if (data.includes(spanText)) {
                                        label.classList.remove("hidden");
                                    } else {
                                        label.classList.add("hidden");
                                    }
                                });

                            });

                        } catch (error) {
                            console.log("error : " + error);
                        }

                        data.forEach(function (item) {
                            // console.log(item);
                            const labels = document.querySelectorAll("#sel_zairyo > label");

                            labels.forEach(function (label) {
                                const span = label.querySelector("span");
                                const spanText = span.innerText;

                                if ( data.includes(spanText) ) {
                                    label.classList.remove("hidden");
                                } else {
                                    label.classList.add("hidden");
                                }
                            });

                        });
                    }
                });

            } else {
                console.log("error... 뭔가 잘못됨!");
            }
        }
    }
}

// === 재료로 만들 수 있는 칵테일 찾기 ===
function find_make_cocktail() {
    console.log("find_make_cocktail 함수 실행");

    //재료 리스트 가져오기
    const selectedList = document.querySelector("#selectedList");
    const selectedItems = Array.from(selectedList.querySelectorAll("#selectedList > div > span:first-child"))
        .map(span => span.textContent);
    // console.log("보내는 데이터 : " + selectedItems.toString());

    //선택된 재료가 없으면
    if (selectedItems.length === 0) {
        return;
    }

    $.ajax({
        url: "/combain/find",
        type: "GET",
        dataType: "json",
        contentType: "application/json",
        data : {
            send_data: selectedItems.toString()
        },
        success: function (data) {
            data = data.toString();
            console.log("받은 데이터 :" + data.toString());

            if (data === "" ) {

                console.log("검색 결과가 없습니다")
                const split_data_length = 0;

                // 몇개 만들 수 있는지 나타내주는거
                const print_count = document.querySelector("#suljanggo_result > div > p.suljanggo_top_canmakecount");
                print_count.innerText = split_data_length + "개의 칵테일을 만들 수 있습니다.";

                const print_cocktail_area = document.querySelector("#suljanggo_result__middle");
                print_cocktail_area.innerHTML = "";

                return;

            } else {

                //받은 데이터를 , 기준으로 나누기
                const split_data = data.split(",");
                console.log ( "받은 데이터 갯수" + split_data.length );

                //split_data에 들어오 갯수
                const split_data_length = split_data.length;

                // 몇개 만들 수 있는지 나타내주는거
                const print_count = document.querySelector("#suljanggo_result > div > p.suljanggo_top_canmakecount");
                print_count.innerText = split_data_length + "개의 칵테일을 만들 수 있습니다.";

                const print_cocktail_area = document.querySelector("#suljanggo_result__middle");
                print_cocktail_area.innerHTML = "";

                for (let i = 0; i < split_data_length; i++) {
                    // console.log("111 : " + split_data[i]);
                    const name = split_data[i];

                    let get_num;
                    let get_detail;
                    let get_img;

                    $.ajax({
                        url: "/combain/cocktail_info",
                        type: "GET",
                        dataType: "json",
                        contentType: "application/json",
                        data: {
                            name: name
                        },
                        success: function (data) {
                            console.log("data : " + data);

                            console.log(typeof data); //object
                            //object에서 첫번째 데이터 가져오기
                            get_num = data[0];
                            get_detail = data[1];
                            get_img = data[2];

                            // console.log("get_num : " + get_num);
                            // console.log("get_detail : " + get_detail);
                            // console.log("get_img : " + get_img);

                            print_cocktail_area.innerHTML += `
                            <a href="/cocktail/${split_data[i]}" class="suljanggo_result_wrap">
                                <div class="suljanggo_result__img">
                                    <img src="${get_img}" alt="칵테일 이미지" class="suljanggo_result__src">
                                </div>
                                <div class="suljanggo_result__text">
                                    <p class="suljanggo_result__text__name">${split_data[i]}</p>
                                    <p class="suljanggo_result__text__desc">${get_detail}</p>
                                </div>
                    </a>
            `;
                        },
                        error: function (request, status, error) {
                            console.log("에러가 떳어용!!")
                            console.log("★code:" + request.status + "\n" + "★message:" + request.responseText + "\n" + "★error:" + error);
                        }
                    });
                }

            }

        },
        error : function(request,status,error){
            console.log("에러!!!!")
            console.log("★code:"+request.status+"\n"+"★message:"+request.responseText+"\n"+"★error:"+error);
        }

    })
}
