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