class PaymentsController < ApplicationController
  
  # JSON Post of Payment Info for iframe generation.
  def iframe
    @iframe_str = "iframe test string!"

    respond_to { |format| format.js }
  end
end