$(document).ready(function(){
    $('.gnb_deep1').hide();
    $('.gnb_active').hide();

    //마우스 올렸을 때,
    $('.ect_header__ul_text').mouseenter(function(){
        $('.gnb_deep1').not($(this).find('.gnb_deep1')).hide();
        $(this).find('.gnb_deep1').show();
        $(this).find('.gnb_active').show();
    });

    //떠날떄
    $('.ect_header__ul_text, .gnb_deep1').mouseleave(function(){
        $('.gnb_deep1').hide();
        $(this).find('.gnb_active').hide();
    });
});