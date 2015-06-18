require 'base64'

class PolicyBuilder
  def call
    policy_document = File.read(policy_path)
    Base64.encode64(policy_document).gsub("\n", "")
  end

  def policy_path
    Rails.root.join("config", "aws", "policy.#{A9n.env}.json")
  end
end
