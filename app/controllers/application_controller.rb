class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_for_login

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      if username == ENV['INTIGI_RIVERS_USERNAME'] && password == ENV['INTIGI_RIVERS_PASSWORD']
        session[:is_logged_in] = true
        true
      else
        false
      end
    end
  end

  def check_for_login
    @logged_in = session[:is_logged_in].present? ? true : false
  end

end
