class SimilarBusinessItems < BaseService
  attr_accessor :repository, :object_id , :results

  def initialize(repository,object_id)
    self.repository = repository
    self.object_id = object_id
    self.results = []
  end

  def perform
    @business_item = repository.find_by_id(object_id)
    if @business_item.present?
      results = repository.find_similar(@business_item.category,object_id)
    end
    results
  end
end
