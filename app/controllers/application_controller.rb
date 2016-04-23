class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!
  before_filter :set_locale
  before_filter :store_location

  after_filter :set_csrf_cookie_for_ng

  def set_locale
    I18n.locale = cookies[:locale] || I18n.default_locale
    cookies[:locale] = I18n.locale
  end

  def locale
    cookies[:locale]
  end

  def full_error_message_for(object)
    return unless object && object.errors.present?

    object.errors.full_messages.first
  end

  extend Dependor::Injectable

  def injector
    @injector ||= ControllersInjector.new(params, session, request)
  end

  protected

  # store last url - this is needed for post-login redirect
  # to whatever the user last visited.
  def store_location
    if !request.env["HTTP_REFERER"].nil? &&
       !request.env["HTTP_REFERER"].match("/users")
      session[:previous_url]  = request.env["HTTP_REFERER"]
    end
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end
end
