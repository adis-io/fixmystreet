class ApplicationController < ActionController::Base
  protect_from_forgery
  def check_auth
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
    if params[:locale].nil?
      session[:locale] = I18n.locale if session[:locale].nil?
    else
      session[:locale] = params[:locale]
    end
    I18n.locale = session[:locale]
  end

end
