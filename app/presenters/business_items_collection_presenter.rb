class BusinessItemsCollectionPresenter
  attr_accessor :user, :page, :repository, :locale

  LIMIT = 10

  def initialize(user, page, repository, locale)
    self.user = user
    self.page = page.present? ? page.to_i : 1
    self.repository = repository
    self.locale = locale
  end

  def as_json(*)
    business_items = repository.for_user(user)

    {
      items: items(business_items),
      count: count(business_items)
    }
  end

  private

  def items(business_items)
    offset = (page - 1) * LIMIT
    business_items.limit(LIMIT).offset(offset).map do |i|
      BusinessItemWithCategoryPresenter.new(i, repository, locale)
    end
  end

  def count(business_items)
    business_items.count
  end
end
