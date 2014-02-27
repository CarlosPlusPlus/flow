class PaymentsController < ApplicationController
  
  # JSON Post of Payment Info for iframe generation.
  def iframe
    @iframe = Paypal::authenticate_iframe({
      billing:  params[:billing],
      customer: params[:customer],
      shipping: params[:shipping],
      root_url: root_url
    })

    respond_to { |format| format.js }
  end
end