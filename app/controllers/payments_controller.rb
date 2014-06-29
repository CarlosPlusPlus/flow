class PaymentsController < ApplicationController
  before_action :check_coupon_code, only: :couponcode

  def couponcode
    respond_to do |format|
      format.json do
        render json: { 
          :discount => session[:discount],
          :price    => (session[:discount] ? 
            ENV['FLOW_DISCOUNT'] : ENV['FLOW_COST']) }
      end
    end
  end

  # JavaScript Post of Payment Info for iframe generation.
  def iframe
    @iframe = Paypal::authenticate_iframe(
      params.merge(root_url:    root_url).
             merge(coupon_code: session[:coupon_code]).
             merge(discount:    session[:discount]))

    reset_coupon_variables

    respond_to { |format| format.js }
  end

  private

  def check_coupon_code
    reset_coupon_variables

    session[:coupon_code] = params['code'] unless params['code'].empty?
    session[:discount]    = valid_code?(session[:coupon_code])
  end

  def valid_code?(coupon_code)
    (coupon_code =~ /#{ENV['FLOW_REGEX']}/) ? true : nil
  end

  def reset_coupon_variables
    session[:coupon_code] = nil
    session[:discount]    = false
  end
end
