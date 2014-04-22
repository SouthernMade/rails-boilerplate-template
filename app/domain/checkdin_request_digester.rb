require 'openssl'

class CheckdinRequestDigester

  def digest_request(request_data)
    encoded_request = encode_request_for_digest(request_data)
    OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest::SHA256.new,
      CheckdinConfig['shared_authentication_secret'],
      encoded_request
    )
  end

  private

  def encode_request_for_digest(request_data)
    # note: hash keys are automatically sorted by .to_query
    request_data.to_query
  end

end
