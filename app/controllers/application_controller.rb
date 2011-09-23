class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :fetch_country
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

  def fetch_country
    country_code = Rails::Application.config.domains.invert[request.host]
    @country = Country.find_by_country_code country_code
    render :status => 404 and return if @country.nil?
  end
end
