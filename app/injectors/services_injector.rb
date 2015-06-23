class ServicesInjector
  include Dependor::AutoInject

  def storer_factory
    Registration::StorerFactory.new
  end
end

