class PaymentsController < ApplicationController
  before_action :check_coupon_code, only: :couponcode
  before_action :check_zip_code,    only: :iframe

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
             merge(discount:    session[:discount])) if @valid_install

    # Generate iframe only if shipping (installation) zip code is valid.
    respond_to do |format|
      if @valid_install
        reset_coupon_variables
        format.js
      else
        format.js { render :action => 'error' }
      end
    end
  end

  private

  def check_coupon_code
    reset_coupon_variables

    session[:coupon_code] = params['code'] unless params['code'].empty?
    session[:discount]    = valid_coupon_code?(session[:coupon_code])
  end

  def check_zip_code
    installation_zip_code = params[:shipping][:zip].blank? ?
      params[:billing][:zip] : params[:shipping][:zip]
    @valid_install        = valid_zip_code?(installation_zip_code)
  end

  def valid_coupon_code?(coupon_code)
    (coupon_code =~ /#{ENV['FLOW_COUPON_REGEX']}/) ? true : nil
  end

  def valid_zip_code?(zip_code)
    zip_regex(zip_code) && zip_exclusion_check(zip_code)
  end

  def reset_coupon_variables
    session[:coupon_code] = nil
    session[:discount]    = false
  end

  def zip_regex(zip_code)
    zip_code =~ /#{ENV['FLOW_ZIP_REGEX']}/
  end

  def zip_exclusion_check(zip_code)
    !(ENV['FLOW_ZIP_EXCL'].split(',').include?(zip_code))
  end
end
