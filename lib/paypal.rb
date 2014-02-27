module Paypal
  extend self
  
  def generate_iframe(params)
    secure_token  = generate_secure_token_id
    paypal_params = generate_paypal_params(params, secure_token)
    # CURL to get response
    # Parse out response parameters
    # BUILD AND RETURN STRING
  end

  private

  def generate_secure_token_id
    SecureRandom.uuid.gsub('-', '').slice(0, 25)
  end

  def generate_paypal_params(params, secure_token)
    {
      'PARTNER' => ENV['PAYPAL_PARTNER'],
      'VENDOR'  => ENV['PAYPAL_VENDOR'],
      'USER'    => ENV['PAYPAL_VENDOR'],
      'PWD'     => ENV['PAYPAL_PASSWORD'],
      'AMT'     => ENV['FLOW_COST'],
      'SECURETOKENID'     => secure_token,
      'CREATESECURETOKEN' => 'Y',
      'TRXTYPE'           => 'S',
      'CURRENCY'          => 'USD',
      'BILLTOFIRSTNAME'   => params[:customer][:first_name],
      'BILLTOLASTNAME'    => params[:customer][:last_name],
      'BILLTOSTREET'      => params[:billing][:street],
      'BILLTOCITY'        => params[:billing][:city],
      'BILLTOSTATE'       => params[:billing][:state],
      'BILLTOZIP'         => params[:billing][:zip],
      'BILLTOCOUNTRY'     => 'US',
      'SHIPTOFIRSTNAME'   => params[:customer][:first_name],
      'SHIPTOLASTNAME'    => params[:customer][:last_name],
      'SHIPTOSTREET'      => params[:shipping][:street],
      'SHIPTOCITY'        => params[:shipping][:city],
      'SHIPTOSTATE'       => params[:shipping][:state],
      'SHIPTOZIP'         => params[:shipping][:zip],
      'SHIPTOCOUNTRY'     => 'US',
      'EMAILCUSTOMER' => 'TRUE',
      'ERRORURL'      => "#{params[:root_url]}/error",
      'RETURNURL'     => "#{params[:root_url]}/success"
    }.to_param
  end
end