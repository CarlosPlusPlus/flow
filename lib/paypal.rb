module Paypal
  extend self

  def generate_iframe(shipping, payment)
    # Generate Secure Token
    # Parse Address Parameters
    # CURL to get response
    # Parse out response parameters

    # BUILD AND RETURN STRING
  end

  private

  def generate_secure_token_id
    SecureRandom.uuid.gsub('-', '').slice(0, 25)
  end

end