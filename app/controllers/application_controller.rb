class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :fetch_country
  before_filter :set_locale

  def after_sign_in_path_for(resource_or_scope)
    new_report_path
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
    country_code = Fixmystreet::Application.config.domains.invert[request.host]
    @country = Country.find_by_country_code(country_code) || Country.first
    render :status => 404 and return if @country.nil?
  end
end
