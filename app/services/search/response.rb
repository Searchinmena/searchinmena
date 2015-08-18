class Search::Response < ::Response
  attr_accessor :results, :errors

  def initialize(success: true, results: [], errors: {})
    self.success = success
    self.results = results
    self.errors = errors
  end
end
