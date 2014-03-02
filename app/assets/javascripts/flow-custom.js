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

  // Add a counter function to compute gallons / money saved.
  function flowCounter() {
    var curr = new Date(); 
    var past = new Date('1/1/2012');
    var days = ((Math.abs(curr.getTime()) - Math.abs(past.getTime()))/60/60/24/1000).toFixed(5)
    
    var customers = 10000;
    var water_per_day = customers * 25;   // 100 gallons per day @ 25% savings
    var money_per_day = customers * 0.82; // $3.30 per day       @ 25% savings
    
    document.getElementById("gallons-saved").innerHTML =       (customers * water_per_day * days).toFixed(0);
    document.getElementById("dollars-saved").innerHTML = '$' + (customers * money_per_day * days).toFixed(0);
  };

  setInterval(function() { flowCounter() }, 1000);
});