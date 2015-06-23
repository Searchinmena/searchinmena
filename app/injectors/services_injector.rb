class ServicesInjector
  include Dependor::AutoInject

  def storer_factory
    Registration::StorerFactory.new
  end

  def storer_wrapper
    Product::StorerWrapper.new
  end
end

