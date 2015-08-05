class BusinessItem::Storer
  attr_accessor :handlers, :object

  def perform(object)
    success = if valid?
                store
              else
                copy_errors
              end

    ::Response.new(
      success: success, object: object)
  end

  def valid?
    handlers.map(&:valid?).all?
  end

  def store
    handlers.map(&:perform).all?(&:successful?)
  end

  def copy_errors
    handlers.each(&:copy_errors)
    false
  end
end
