$('document').ready(function(){

  // Add scroll effect:
  //   Learn More button on intro page.
  $('#learn-btn').click(function () {
    $('html,body').animate({
      scrollTop: $("#why").offset().top - 85
    }, 1000);
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
    var days = ((Math.abs(curr.getTime()) - Math.abs(past.getTime()))/60/60/24/1000).toFixed(5) / 40
    
    var c = 1000;
    var water_per_day = c * 24.325;   // avg s
    var money_per_day = c * 0.82;     // avg $
    
    document.getElementById("gallons-saved").innerHTML =       Math.round((c * water_per_day * days)).toLocaleString(0);
    document.getElementById("dollars-saved").innerHTML = '$' + Math.round((c * money_per_day * days)).toLocaleString(0);
  };

  // Only initialize counter if on the index page.
  if ($('#gallons-saved').length){
    setInterval(function() { flowCounter() }, 1000);
  }

  // Calculator functionality.
  $("#calc-btn").click(function() {
    event.preventDefault();

    var bill = $('input[name=bill]:radio:checked').val();

    var cost = bill * 12; 
    var save = cost * .25;
    var paid = Math.ceil((600 / (bill * .25)));
    
    $("#calc-cost").text("$" + cost.toFixed(2));
    $("#calc-paid").text(paid);
  });

  // Checkbox functionality.
  $("#installation-checkbox").change(function() {
    if (this.checked) {
      $("#shipping-address").hide();
    }
    else {
      $("#shipping-address").show();
    }
  });

  // Coupon Code functionality.
  $("#coupon-btn").click(function(e) {
    e.preventDefault();

    var code = $("#coupon-input").val();
      
      $.ajax({
        url: '/couponcode',
        dataType: 'json',
        type: 'POST',
        data : { code: code },
        
        success: function(result) {
          if (result.discount == true) {
            $("#coupon-status").addClass("f-green p-top-10").
                text("Coupon Code has been successfully applied!");

            $("#flow-cost").text("$" + result.price)
            $("#flow-cost").animate({ backgroundColor: "green", color: "white"},1000);
            $("#flow-cost").animate({ backgroundColor: "white", color: "black"},1000);
          } else {
            $("#coupon-input").val("").attr("placeholder", "Invalid Coupon Code");

            $("#flow-cost").animate({ backgroundColor: "red", color: "white"},1000);
            $("#flow-cost").animate({ backgroundColor: "white", color: "black"},1000);

            setTimeout(function() {
              $("#coupon-input").val("").attr("placeholder", "Enter Coupon Code");
            }, 2000);
          }
        }
      })
  });
});
