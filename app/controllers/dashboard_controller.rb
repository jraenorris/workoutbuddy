class DashboardController < ApplicationController
  def home
    if current_user
      redirect_to workouts_path
    else
      redirect_to homes_path
    end
  end
end
