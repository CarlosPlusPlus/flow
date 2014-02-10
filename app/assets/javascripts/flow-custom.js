$('#savings-btn').click(function () {
    $('html,body').animate({
        scrollTop: $("#purchase").offset().top
    }, 2000, function(){
    	$('.active').removeClass();
    });
});