class InsightlyUpdateWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    InsightlyService::InsightlyCreator.new(user).update
  end
end
