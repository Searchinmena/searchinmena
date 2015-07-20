class BasePresenter
  extend Dependor::Injectable

  def injector
    @injector ||= PresentersInjector.new
  end

  def formatted_price(price)
    return "" unless price

    format("%.2f", price)
  end
end
