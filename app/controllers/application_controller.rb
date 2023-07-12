class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def handle_record_invalid(exception)
    # 感情分析のバリデーションエラー判定
    if exception.message.include?("Contentネガティブな表現が含まれています")
      flash[:danger] = t('errors.messages.negative_content')
    end

    redirect_back fallback_location: root_path
  end

  # ログイン後のリダイレクト先
  # def after_sign_in_path_for(resource)
  #   user_session_path(resource)
  # end

end
