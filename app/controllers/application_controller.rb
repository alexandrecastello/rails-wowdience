class ApplicationController < ActionController::Base
  before_action :set_locale

  def switch_language
    locale = params[:locale]
    if I18n.available_locales.include?(locale.to_sym)
      I18n.locale = locale
      redirect_to root_path(locale: locale)
    else
      redirect_to root_path
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
