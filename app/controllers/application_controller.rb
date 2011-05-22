class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :fetch_city
  before_filter :set_locale

  def check_if_logged
    unless user_signed_in?
      session[:redirect_to] = request.url
      redirect_to new_user_session_path and return
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if session[:redirect_to]
      session.delete :redirect_to
    else
      super
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t :permission_error
    redirect_to root_path
  end

  def set_locale
    session[:locale] = params[:locale] if params[:locale] and %(ru en).include? params[:locale]
    I18n.locale = session[:locale] if session[:locale]
  end

  def fetch_city
    if current_subdomain
      @city = City.find_by_subdomain(current_subdomain)
      redirect_to "/404.html" and return unless @city
      session[:city] = @city.subdomain
    elsif session[:city]
      @city = City.find_by_subdomain(session[:city])
    elsif
      @city = City.find_by_subdomain(Country.first.default_city)
      session[:city] = @city.subdomain
    else
      @city = Country.first.cities.first
      session[:city] = @city.subdomain
    end
    redirect_to root_path and return unless @city
  end
end
