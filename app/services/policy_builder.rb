require 'base64'

class PolicyBuilder
  EXPIRE_INTERVAL = 3.seconds
  DATE_FORMAT = "%Y-%m-%dT%H:%M:%SZ"
  MAX_CONTENT_LENGTH = 524_288_000
  KEY_STARTS_WITH = "photos/"

  def call
    policy = policy_hash.to_json
    Base64.encode64(policy).gsub("\n", "")
  end

  def policy_hash
    {
      expiration: expiration,
      conditions: [
        { bucket: A9n.aws[:bucket_name] },
        ["starts-with", "$key", KEY_STARTS_WITH],
        { acl: "private" },
        ["starts-with", "$Content-Type", ""],
        ["starts-with", "$filename", ""],
        ["content-length-range", 0, MAX_CONTENT_LENGTH]
      ]
    }
  end

  def expiration
    date = Time.now + EXPIRE_INTERVAL
    date.strftime(DATE_FORMAT)
  end
end
