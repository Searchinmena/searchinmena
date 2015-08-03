class BusinessItem::Photo::StoringHandler < BaseService

  attr_reader :busiess_item, :creators

  def initialize(repository, busiess_item, photos_params)
    @busiess_item = busiess_item
    @photos_params = photos_params
    @creators = photos_params.map do |photo|
      BusinessItem::Photo::Creator.new(repository, busiess_item, photo)
    end
  end

  def perform
    success = if photos_present? && valid?
                store
              else
                copy_errors
              end
    Response.new(success: success, object: busiess_item)
  end

  def photos_present?
    @photos_params.any?
  end

  def valid?
    creators.map(&:valid?).all?
  end

  def store
    creators.map(&:perform).all?
  end

  def copy_errors
    creators.map(&:copy_errors)
    false
  end

  def objects
    creators.map(&:object)
  end

end
