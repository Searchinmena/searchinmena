class AnotherSampleService
  def perform(user)
    # something smart
    Response.new(success: true, object: user)
  end
end
