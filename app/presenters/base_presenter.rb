class BasePresenter
  extend Dependor::Injectable

  def injector
    @injector ||= PresentersInjector.new
  end
end
