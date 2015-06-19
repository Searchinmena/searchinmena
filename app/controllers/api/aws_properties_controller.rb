class Api::AwsPropertiesController < Api::BaseController
  inject :policy_builder, :signature_builder

  def index
    return head :unauthorized unless authorized?

    policy = policy_builder.call
    signature = signature_builder.call(policy)
    render json: { policy: policy, signature: signature }
  end

  private

  def authorized?
    return true unless Rails.env.production?

    request.headers['origin'] == A9n.app_host
  end
end
