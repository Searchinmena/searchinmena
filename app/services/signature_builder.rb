require 'openssl'
require 'digest/sha1'

class SignatureBuilder
  def call(policy)
    secret = A9n.aws[:secret_access_key]
    signed_policy = OpenSSL::HMAC.digest(hash, secret, policy)
    Base64.encode64(signed_policy).gsub("\n","")
  end

  def hash
    OpenSSL::Digest::Digest.new('sha1')
  end
end
