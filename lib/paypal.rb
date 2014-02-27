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

  # ADDRESS INFO
  # RETURN URLS

  def generate_paypal_params(params, secure_token)
    binding.pry
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
      'BILLTOSTREET'      => '123 Main St.',
      'BILLTOCITY'        => 'San Jose',
      'BILLTOSTATE'       => 'CA',
      'BILLTOZIP'         => '95101',
      'BILLTOCOUNTRY'     => 'US',
      'SHIPTOFIRSTNAME'   => params[:customer][:first_name],
      'SHIPTOLASTNAME'    => params[:customer][:last_name],
      'SHIPTOSTREET'      => '1234 Park Ave',
      'SHIPTOCITY'        => 'San Jose',
      'SHIPTOSTATE'       => 'CA',
      'SHIPTOZIP'         => '95101',
      'SHIPTOCOUNTRY'     => 'US',
    }.to_param
  end


end

# "BILLTOFIRSTNAME" => "John",
# "BILLTOLASTNAME" => "Doe",
# "BILLTOSTREET" => "123 Main St.",
# "BILLTOCITY" => "San Jose",
# "BILLTOSTATE" => "CA",
# "BILLTOZIP" => "95101",
# "BILLTOCOUNTRY" => "US",

# "SHIPTOFIRSTNAME" => "Jane",
# "SHIPTOLASTNAME" => "Smith",
# "SHIPTOSTREET" => "1234 Park Ave",
# "SHIPTOCITY" => "San Jose",
# "SHIPTOSTATE" => "CA",
# "SHIPTOZIP" => "95101",
# "SHIPTOCOUNTRY" => "US",

# BILLTOFIRSTNAME=John
# BILLTOLASTNAME=Doe
# BILLTOSTREET=123 Main St.
# BILLTOZIP=95101
# BILLTOCITY=San Jose
# BILLTOSTATE=CA
# BILLTOCOUNTRY=US

# paypal_params += "&RETURNURL=#{paypal_success_url}&ERRORURL=#{paypal_error_url}&SILENTPOSTURL=#{paypal_silent_post_url}&CANCELURL=#{subscribe_url}"