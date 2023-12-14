$(function () {
    $("#v2").css("display", "none")

    $("#activity-radio1").click(function () {
        $("#v2").css("display", "none")
        $("#v1").css("display", "flex");
    });
    $("#activity-radio2").click(function () {
        $("#v1").css("display", "none")
        $("#v2").css("display", "flex");
    });

    // //정보 수정 버튼 클릭 시 정보수정은 안보이게 되고 정보 저장버튼만 나타나게 된다.
    // $("#activity-button").click(function () {
    //     $(".activity-text").attr("readonly", false);
    //     $("#activity-button").css("display", "none")
    //     $("#activity-button-submit").css("display", "flex");
    // })
    //
    //
    // //반대로 정보저장 버튼 클릭스 정보수정 버튼이 나타나고 정보 저장 버튼은 사라진다.
    // $("#activity-button-submit").click(function () {
    //     $(".activity-text").attr("readonly", true);
    //     $("#activity-button").css("display", "flex")
    //     $("#activity-button-submit").css("display", "none");
    // });

    // '더 보기' 버튼 클릭 시
    $("#show-more-btn").click(function () {
        $("#activity-ul").addClass("show-more");
    });

    // 페이지 버튼 클릭 시
    $(".page-btn").click(function () {
        var pageNum = parseInt($(this).data("page"));
        showPage(pageNum);
    });

    // 이전 페이지 버튼 클릭 시
    $("#prev-page").click(function () {
        var currentPage = parseInt($(".page-btn[disabled]").data("page"));
        if (currentPage > 1) {
            showPage(currentPage - 1);
        }
    });

    // 다음 페이지 버튼 클릭 시
    $("#next-page").click(function () {
        var currentPage = parseInt($(".page-btn[disabled]").data("page"));
        var totalPages = Math.ceil($("#activity-ul2 .activity-li2").length / 5);

        if (currentPage < totalPages) {
            showPage(currentPage + 1);
        }
    });

    // 초기에 첫 페이지 보이기
    showPage(1);

    $(document).on('click', '.page-btn', function () {
        var pageNum = parseInt($(this).data("page"));
        showPage(pageNum);
    });
});

// 페이지 번호를 동적으로 생성하는 함수
function generatePageButtons(currentPage, totalPages) {
    var pageButtonsHTML = '';

    // Calculate the starting point for the loop
    var startPage = Math.floor((currentPage - 1) / 5) * 5 + 1;

    // Calculate the ending point for the loop
    var endPage = Math.min(startPage + 4, totalPages);

    for (var i = startPage; i <= endPage; i++) {
        pageButtonsHTML += '<button class="page-btn" data-page="' + i + '" ' + (i === currentPage ? 'disabled' : '') + '>' + i + '</button>';
    }

    return pageButtonsHTML;
}

// 페이지를 보여주는 함수
function showPage(pageNum) {
    // Assuming 5 items per page
    var itemsPerPage = 5;

    // Calculate start and end indices for the visible items
    var startIndex = (pageNum - 1) * itemsPerPage;
    var endIndex = startIndex + itemsPerPage;

    // Show/hide items based on the calculated indices
    $("#activity-ul2 .activity-li2").each(function (index) {
        $(this).toggle(index >= startIndex && index < endIndex);
    });

    // Update the page buttons
    var totalPages = Math.ceil($("#activity-ul2 .activity-li2").length / itemsPerPage);
    $("#page-buttons").html(generatePageButtons(pageNum, totalPages));

    // Scroll to the top of the activity-bottom section
    $("#activity-bottom").scrollTop(0);
}