class TagsStoringHandler < BaseService
  inject :tag_repository, :business_repository

  takes :business, :tags_params, :locale

  def perform
    success = tags_params.map do |attributes|
      tag = find_or_create_tag(attributes)
      business_repository.add_tag(business, tag)
    end.all?
    Response.new(success: success)
  end

  private

  def find_or_create_tag(attributes)
    if id = attributes[:id]
      tag_repository.find_by_id(id)
    else
      tag_repository.find_or_create_by_translation(attributes[:label], locale)
    end
  end
end
