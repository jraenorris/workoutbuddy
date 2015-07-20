class Trainer::UsersController < ApplicationController
  before_action :authorize_trainer!

  def index
    @users = User.all.order(:fullname).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @workouts = Workout.where(user: @user).page(params[:page]).per(10)
    @completeds = Completed.where(user: @user).where('created_at > ?', 30.days.ago)
  end
end
