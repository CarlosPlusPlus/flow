$('document').ready(function(){

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

  // Collapse effects for FAQs.
  $('.faq .question .collapse').on('show.bs.collapse', function (n) {
    $(n.target).siblings('.faq-toggle').toggleClass('open');
  });

  $('.faq .question .collapse').on('hide.bs.collapse', function (n) {
      $(n.target).siblings('.faq-toggle').toggleClass('open');        
  });
});