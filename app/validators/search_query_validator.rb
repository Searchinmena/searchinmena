class SearchQueryValidator
  include ActiveModel::Validations

  takes :query

  validates :query, presence: true
end
