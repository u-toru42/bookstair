class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def handle_record_invalid(exception)
    # バリデーションエラーが含まれる場合はエラーメッセージをセットする
    if exception.message.include?("Contentネガティブな表現が含まれています")
      flash[:danger] = "ネガティブな表現が含まれています"
    end

    redirect_back fallback_location: root_path
  end

end
