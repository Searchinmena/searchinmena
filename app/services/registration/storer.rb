class Registration::Storer
  attr_accessor :handlers

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
