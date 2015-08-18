class Search::Strategies::ServiceStrategy < Search::Strategies::BaseStrategy
  def repository
    repositories[:service]
  end
end
