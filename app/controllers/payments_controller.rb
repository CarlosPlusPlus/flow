class PaymentsController < ApplicationController
  before_action :check_coupon_code, only: :couponcode

  def couponcode
    respond_to do |format|
      format.json { render json: { :discount => @discount }}
    end
  end

  # JavaScript Post of Payment Info for iframe generation.
  def iframe
    # TODO: @discount ? ENV['FLOW_DISCOUNT_PRICE'] || ENV['FLOW_PRICE']
    # TODO: Comment1 => "" || getCouponCode
    @iframe = Paypal::authenticate_iframe(params.merge(root_url: root_url))
    reset_coupon_variables

    respond_to { |format| format.js }
  end

  private

  def check_coupon_code
    session[:coupon_code] = params['code'] || ""
    session[:discount]    = valid_code?(session[:coupon_code])
  end

  def reset_coupon_variables
    session[:coupon_code] = ""
    session[:discount]    = false
  end

  def valid_code?(coupon_code)
    (coupon_code =~ /#{ENV['FLOW_REGEX']}/) ? true : false
  end
end
