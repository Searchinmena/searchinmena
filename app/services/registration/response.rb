class Registration::Response < ::Response
  attr_accessor :user, :business

  def initialize(success: true, user: nil, business: nil)
    self.success = success
    self.user = user
    self.business = business
  end
end
