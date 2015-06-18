class Api::AwsPropertiesController < Api::BaseController
  inject :policy_builder, :signature_builder

  def index
    policy = policy_builder.call
    signature = signature_builder.call(policy)
    render json: { policy: policy, signature: signature }
  end
end
