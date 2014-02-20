// Add scroll effect:
//   Learn More button on intro page.
$('#learn-btn').click(function () {
    $('html,body').animate({
        scrollTop: $("#why").offset().top
    }, 1000);
});

// Add scroll effect:
//   Savings button on nav bar.
$('#savings-btn').click(function () {
    $('html,body').animate({
        scrollTop: $("#purchase").offset().top
    }, 2000, function(){
    	$('.active').removeClass();
    });
});

// Create function for binding JS modals.
function initModal(link_id, popup_id){
	$(link_id).bind('click', function(e) {
    // Prevents the default action to be triggered. 
    e.preventDefault();

    // Triggering bPopup when click event is fired
    $(popup_id).bPopup({
	    positionStyle: 'fixed'
  	});
	});
}

initModal('#privacy-l', '#privacy-p');
initModal(  '#terms-l',   '#terms-p');