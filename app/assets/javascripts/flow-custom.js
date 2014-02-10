$('#savings-btn').click(function () {
    $('html,body').animate({
        scrollTop: $("#purchase").offset().top
    }, 1500, function(){
    	$('.active').removeClass();
    });
});