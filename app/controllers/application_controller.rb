class ApplicationController < ActionController::Base

  # deviseコントローラにルーティングされた時のみ下記メソッドを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

    # アカウント登録時にユーザ名を、アカウント編集時にアバターを、それぞれストロングパラメータで受け取れるように設定
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :user_name])
    end

end

