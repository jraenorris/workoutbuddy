class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def authorize_trainer!
    if current_user.nil? || !current_user.trainer?
      flash[:notice] = "Must be a trainer to view this page"
      redirect_to workouts_path
    end
  end

  def workout_frequency(user)
    Completed.where(
      'user_id = ? and created_at > ?',
      user,
      30.days.ago
    ).count
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :fullname
    devise_parameter_sanitizer.for(:account_update) << :fullname
  end
end
