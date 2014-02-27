class PaymentsController < ApplicationController
  
  # JSON Post of Payment Info for iframe generation.
  def iframe
    @iframe_str = Paypal::generate_iframe({
      billing:  params[:billing],
      customer: params[:customer],
      shipping: params[:shipping]
    })

    respond_to { |format| format.js }
  end
end