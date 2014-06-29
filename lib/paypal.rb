module Paypal
  extend self
  
  def authenticate_iframe(params)
    secure_token_id = generate_secure_token_id
    paypal_params   = generate_paypal_params(params, secure_token_id)
    paypal_response = generate_paypal_response(CGI.unescape(paypal_params))

    generate_iframe_string(paypal_response)
  end

  private

  def generate_secure_token_id
    SecureRandom.uuid.gsub('-', '').slice(0, 25)
  end

  def generate_paypal_params(params, secure_token_id)
    {
      'PARTNER' => ENV['PAYPAL_PARTNER'],
      'VENDOR'  => ENV['PAYPAL_VENDOR'],
      'USER'    => ENV['PAYPAL_VENDOR'],
      'PWD'     => ENV['PAYPAL_PASSWORD'],
      'AMT'     => (params[:discount] ? ENV['FLOW_DISCOUNT'] : ENV['FLOW_COST']),
      'SECURETOKENID'     => secure_token_id,
      'CREATESECURETOKEN' => 'Y',
      'TRXTYPE'           => 'S',
      'CURRENCY'          => 'USD',
      'BILLTOFIRSTNAME'   => params[:customer][:fname],
      'BILLTOLASTNAME'    => params[:customer][:lname],
      'BILLTOSTREET'      => params[:billing][:street],
      'BILLTOCITY'        => params[:billing][:city],
      'BILLTOSTATE'       => params[:billing][:state],
      'BILLTOZIP'         => params[:billing][:zip],
      'BILLTOCOUNTRY'     => 'US',
      'BILLTOPHONENUM'    => params[:customer][:phone],
      'SHIPTOFIRSTNAME'   => params[:customer][:fname],
      'SHIPTOLASTNAME'    => params[:customer][:lname],
      'SHIPTOSTREET'      => (params[:shipping][:street].blank? ? params[:billing][:street] : params[:shipping][:street]),
      'SHIPTOCITY'        => (params[:shipping][:city].blank?   ? params[:billing][:city]   : params[:shipping][:city]),
      'SHIPTOSTATE'       => (params[:shipping][:state].blank?  ? params[:billing][:state]  : params[:shipping][:state]),
      'SHIPTOZIP'         => (params[:shipping][:zip].blank?    ? params[:billing][:zip]    : params[:shipping][:zip]),
      'SHIPTOCOUNTRY'     => 'US',
      'BILLTOEMAIL'       => params[:customer][:email],
      'SHIPTOEMAIL'       => params[:customer][:email],
      'EMAILCUSTOMER'     => 'TRUE',
      'CANCELURL'     => "#{params[:root_url]}/checkout",
      'ERRORURL'      => "#{params[:root_url]}/error",
      'RETURNURL'     => "#{params[:root_url]}/success"
    }.merge(params[:discount] ? { 'COMMENT1' => params[:coupon_code] } : {}).to_param
  end

  def generate_paypal_response(paypal_params)
    response = %x[ curl "#{ENV['PAYPAL_ENDPOINT']}" -kd "#{paypal_params}" ]
    Rack::Utils.parse_query(response)
  end

  def generate_iframe_string(paypal_response)
    "<iframe src='https://payflowlink.paypal.com?SECURETOKEN=#{paypal_response['SECURETOKEN']}&SECURETOKENID=#{paypal_response['SECURETOKENID']}&MODE=#{ENV['PAYPAL_MODE']}' width='500' height='600' border='0' frameborder='0' scrolling='no' allowtransparency='true'></iframe>"
  end
end
