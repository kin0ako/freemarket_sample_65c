class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected
  def configure_permitted_parameters
    added_attrs = [ :nickname,
                    :f_name,
                    :l_name,
                    :f_name_kana,
                    :l_name_kana,
                    :birthday_year,
                    :birthday_month,
                    :birthday_day,
                    :phone_num,
                    :authentication_num,
                    :content
    ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  def index
    render html: "hello world"
  end

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]    end
  end
end
