class Response
  attr_accessor :success, :object

  def initialize(success: true, object: nil)
    self.success = success
    self.object = object
  end

  def successful?
    success
  end

  def errors
    return {} unless object

    object.errors
  end
end
