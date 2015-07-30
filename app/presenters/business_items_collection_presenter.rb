class BusinessItemsCollectionPresenter
  attr_accessor :user, :page, :repository, :locale

  LIMIT = A9n.items_per_page

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
    items = business_items.order(created_at: :desc).limit(LIMIT).offset(offset)
    items.map do |i|
      BusinessItemWithCategoryPresenter.new(i, repository, locale)
    end
  end

  def count(business_items)
    business_items.count
  end
end
