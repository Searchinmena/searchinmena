class Registration::Storer
  attr_accessor :handlers

  def perform(user, business)
    success = if valid?
                store
              else
                copy_errors
              end

    Registration::Response.new(
      success: success, user: user, business: business)
  end

  private

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
