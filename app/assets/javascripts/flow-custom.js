
// Scroll when Savings Button is Clicked
$('#savings-btn').click(function () {
    $('html,body').animate({
        scrollTop: $("#purchase").offset().top
    }, 1000);
});