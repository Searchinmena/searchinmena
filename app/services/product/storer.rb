class Product::Storer
  attr_accessor :handlers

  def perform(product)
    success = if valid?
                store
              else
                copy_errors
              end

    Product::ProductResponse.new(
      success: success, product: product)
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
