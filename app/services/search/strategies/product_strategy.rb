class Search::Strategies::ProductStrategy < Search::Strategies::BaseStrategy
  def repository
    repositories[:product]
  end
end
