// combain (술장고) 페이지에서 사용하는 자바스크립트 파일
// 작성자 : YJ

document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("#sel_zairyo");
    const selectedList = document.querySelector("#selectedList");

    form.addEventListener("change", bubble_sel_change);

    function bubble_sel_change() {
        // console.log("change");

        //선택한 재료 보여주는거
        const selectedItems = Array.from(form.querySelectorAll("input[name='ing']:checked"))
            .map(checkbox => checkbox.value);

        // console.log(selectedItems);
        updateSelectedList(selectedItems);
    }

    function updateSelectedList(items) {
        selectedList.innerHTML = "";

        if (items.length === 0) {
            selectedList.innerHTML = "<p>선택된 재료가 없습니다.</p>";

        } else {
            items.forEach(item => {
                const divContainer = document.createElement("div");
                divContainer.classList.add("suljanggo__select_bubble");

                const span = document.createElement("span");
                span.textContent = `${item}`;
                divContainer.appendChild(span);

                const span_del_btn = document.createElement("span");
                span_del_btn.textContent = "close";
                span_del_btn.classList.add("material-icons");
                span_del_btn.classList.add("suljanggo__select_bubble_del_btn");
                span_del_btn.addEventListener("click", function () {
                    const checkbox = form.querySelector(`input[value="${item}"]`);
                    checkbox.checked = false;
                    bubble_sel_change();
                });
                divContainer.appendChild(span_del_btn);
                selectedList.appendChild(divContainer);

            });


        }
    }


// 재료 초기화 버튼클릭 (구현완료)
    const reset_btn = document.querySelector("#sel__reset");

    function zairyo_reset() {

        console.log("재료 초기화!");

        const form = document.querySelector("#sel_zairyo");
        const selectedList = document.querySelector("#selectedList");

        const canMakeCoktail_notice = document.querySelector("#suljanggo_result > div > p.suljanggo_top_canmakecount")
        const canMakeCoktailarea = document.querySelector("#suljanggo_result__middle")

        form.reset();

        selectedList.innerHTML = "<p>선택된 재료가 없습니다.</p>";
        canMakeCoktail_notice.innerHTML = "<p>재료를 선택해 주세요</p>";
        canMakeCoktailarea.innerHTML = "";

    }

    reset_btn.addEventListener("click", zairyo_reset);

// ----------------------------------------------------

//저장된 재료 불러오기 ( combain/load )
    const load_btn = document.querySelector("#sel__load");

    function combain_load() {

        $.ajax({
            url: "/combain/load",
            type: "GET",
            dataType: "json",
            success: function (data) {
                console.log("data : " + data); // 받아온 데이터
                try {
                    //데이터를 , 를 기준으로 배열로 전환
                    const dataString = JSON.stringify(data);
                    const dataStringNoBrackets = dataString.replace("[\"", "").replace("\"]", "");
                    const dataArrNoBrackets = dataStringNoBrackets.split(",");

                    const labels = document.querySelectorAll("#sel_zairyo > label");

                    //전체 체크 해제 ( 완 )
                    labels.forEach(function (label) {
                        const checkbox = label.querySelector("input");
                        checkbox.checked = false;
                    });

                    // 받아온 데이터와 대조해서 checked
                    labels.forEach(function (label) {
                        const checkbox = label.querySelector("input");
                        const span = label.querySelector("span");
                        const spanText = span.innerText;

                        // console.log("spanText : " + spanText);
                        // console.log("dataArrNoBrackets : " + dataArrNoBrackets);

                        //받아온 데이터와 대조해서 checked
                        if (dataArrNoBrackets.includes(spanText)) {
                            checkbox.checked = true;
                        }
                        bubble_sel_change();

                    });

                } catch (e) {
                    //에러 이유
                    console.log("에러 이유 : " + e);
                }
            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        })

    }

// === 재료 저장하기 ===
    const save_btn = document.querySelector("#sul__save");

    function ing_sava() {
        //재료 리스트 가져오기
        const selectedList = document.querySelector("#selectedList");
        const selectedItems = Array.from(selectedList.querySelectorAll("#selectedList > span > span.suljanggo__select_bubble"))
            .map(span => span.textContent);

        //선택된 재료가 없으면
        if (selectedItems.length === 0) {
            alert("재료를 선택해주세요!");
            return;
        }

        // console.log("selectedItems : " + selectedItems);
        //selectedItems 변수에 아무것도 포함되어 있지 않은 경우, selectedItems_toString 변수의 값을 null로 설정
        const selectedItems_toString = selectedItems.length > 0 ? selectedItems.toString() : null;
        // console.log ("selectedItems_toString : " + selectedItems_toString);

        //재료 리스트를 서버로 보내기
        $.ajax({
            url: "combain/save",
            type: "POST",
            dataType: "json",
            data: {
                outputData: selectedItems_toString
            },
            success: function (data) {
                console.log("유저의 재료 : " + selectedItems_toString);
                //재료 저장 성공시
                console.log("재료 저장 성공!");
            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        })
    }

    function searchBox_pressEnter() {
        if (Event.keyCode === 13) {
            console.log("press enter");
            // 엔터키가 눌렸을 때
            handleSearchClick();
        }
    }


// === 재료 검색하기 === (구현 80%)
    const search_btn = document.querySelector("#combain__search_btn");

    function handleSearchClick() {
        const searchWord = document.querySelector(".search_input").value;

        $.ajax({

            url: "/combain/search",
            type: "GET",
            dataType: "json",
            data: {
                searchWord: searchWord
            },
            success: function (data) {
                // data는 [0] , [1]같은 순서로 들어
                console.log("data의 갯수 : " + data.length + ", 넘어온 데이터 목록 : " + data);

                if (data.length === 0) {
                    console.log("검색 결과가 없습니다")
                } else {
                    console.log("검색 결과 : " + data);
                }

                // ----------------------------------------

                //#sel_zairyo 의 자식 <label> 을 가져옴
                const labels = document.querySelectorAll("#sel_zairyo > label");

                labels.forEach(function (label) {
                    // label의 자식 <span> 의 텍스트를 가져옴
                    const span = label.querySelector("span");
                    const spanText = span.innerText;

                    // 가져온 텍스트가 data에 포함되어있는지 확인하고 있으면 hidden 클래스를 삭제
                    if (data.includes(spanText)) {
                        label.classList.remove("hidden");
                    } else {
                        // 포함되어있지 않으면 label의 클래스를 hidden으로 바꿈
                        label.classList.add("hidden");
                    }
                });
            },

            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                alert("저장된 재료가 없습니다");
            }
        });
    }

//실행 script
    search_btn.addEventListener("click", handleSearchClick);
    save_btn.addEventListener("click", ing_sava);
    load_btn.addEventListener("click", combain_load);

});