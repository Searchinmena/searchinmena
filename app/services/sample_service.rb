class SampleService
  takes :another_sample_service, :user_repository

  def perform(user_id)
    user = user_repository.find_by_id(user_id)
    response = another_sample_service.perform(user)

    return response unless response.successful?

    important_thing = response.object

    # some short logic or call to another service if more logic needed
    # important_thing = ...

    Response.new(success: true, object: important_thing)
  end
end
