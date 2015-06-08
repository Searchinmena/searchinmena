class TagsStoringHandler < BaseService
  inject :tag_repository, :business_repository

  takes :business, :tags_params

  def perform
    success = tags_params.map do |attributes|
      tag = tag_repository.find_or_create(attributes)
      business_repository.add_tag(business, tag)
    end.all?
    Response.new(success: success)
  end
end
