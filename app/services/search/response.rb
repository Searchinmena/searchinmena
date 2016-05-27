class Search::Response < ::Response
  attr_accessor :results, :errors, :count

  def initialize(success: true, results: [], errors: {}, count: nil)
    self.success = success
    self.results = results
    self.errors = errors
    self.count = count
  end
end
