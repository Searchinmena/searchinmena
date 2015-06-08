class Api::BaseController < ActionController::Base
  protect_from_forgery

  extend Dependor::Injectable

  inject :user_repository, :error_presenter

  def injector
    @injector ||= ControllersInjector.new(params, session, request)
  end
end
