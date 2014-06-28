class PaymentsController < ApplicationController
  
  def couponcode
    # TODO: Check params[:couponcode] via REGEX (application.yml)
    # => If yes, in ApplicationController:
    # ==> Set @discount == true, @couponcode = params[:couponcode]
    # => Return 'success' || 'invalid' based on status.
    # *** DO this in PaymentsController as private methods.
    @status = "success"

    respond_to do |format|
      format.json { render json: { :status => @status }}
    end
  end

  # JavaScript Post of Payment Info for iframe generation.
  def iframe
    # TODO: @discount ? ENV['FLOW_DISCOUNT_PRICE'] || ENV['FLOW_PRICE']
    # TODO: Comment1 => "" || getCouponCode
    @iframe = Paypal::authenticate_iframe(params.merge(root_url: root_url))
    # TODO: Reset ApplicationController @discount & @couponcode Value

    respond_to { |format| format.js }
  end
end
