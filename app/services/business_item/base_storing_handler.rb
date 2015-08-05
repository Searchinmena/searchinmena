class BusinessItem::BaseStoringHandler < BaseService
  def perform
    success = if valid?
                store
              else
                copy_errors
              end
    response(success)
  end

  def response(success)
    Response.new(success: success, object: object)
  end

  def valid?
    handlers.map(&:valid?).all?
  end

  def copy_errors
    handlers.map(&:copy_errors)
    false
  end

  def store
    handlers.map(&:perform).all?(&:successful?)
  end

  def objects
    handlers.map(&:object)
  end
end
