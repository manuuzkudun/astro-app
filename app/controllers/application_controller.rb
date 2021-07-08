class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    if cookies[:user_locale] && I18n.available_locales.include?(cookies[:user_locale].to_sym)
      l = cookies[:user_locale].to_sym
    else
      l = I18n.default_locale
      cookies.permanent[:user_locale] = l
    end
    I18n.locale = l
  end
end
